import XCTest
import MyAwesomeAppFramework // Access to GreetingView
import SnapshotTesting // Access to the snapshot library
import SwiftUI // Access to UIHostingController

class AppStoreScreenshots: XCTestCase {

  override func setUpWithError() throws {}
  override func tearDownWithError() throws {}

  func withEnvironment(
    _ env: MyAwesomeAppFramework.Environment,
    body: @escaping () -> Void) {
    let oldEnv = AppEnvironment.shared.env
    AppEnvironment.shared.env = env
    body()
    AppEnvironment.shared.env = oldEnv
  }

  func withEnvironment(
    userDefaults: UserDefaults = AppEnvironment.shared.userDefaults,
    language: Language = AppEnvironment.shared.language,
    body: @escaping () -> Void) {
    let env = Environment(userDefaults: userDefaults, language: language)
    withEnvironment(env, body: body)
  }

  func testScreenshots() throws {
    record = true
    let userDefaults = UserDefaults()

    let languages: [Language] = [.enAU, .enUS, .es, .pt] // 1
    let devices: [ViewImageConfig] = [.iPhoneXsMax, .iPhone8Plus] // 2

    for language in languages {
      for device in devices {
        withEnvironment(userDefaults: userDefaults, language: language) {
          let view = GreetingView()
          let vc = UIHostingController(rootView: view)
          saveScreenshot(matching: vc, as: .image(on: device), dir: folderName(for: language))
        }
      }
    }
  }

}

func saveScreenshot(
  matching value: UIViewController,
  as snapshotting: Snapshotting<UIViewController, UIImage>,
  dir: String,
  file: StaticString = #file,
  testName: String = #function,
  line: UInt = #line
  ) {
  let snapshotDirectory = ProcessInfo.processInfo.environment["FASTLANE_SCREENSHOTS_PATH"]! + "/" + dir

  let failure = verifySnapshot(
    matching: value,
    as: snapshotting,
    record: true,
    snapshotDirectory: snapshotDirectory,
    file: file,
    testName: testName,
    line: line
  )
  guard let message = failure else { return }
  XCTFail(message, file: file, line: line)
}

func folderName(for language: Language) -> String {
  switch language {
    case .enUS: return "en-US"
    case .enAU: return "en-AU"
    case .es: return "es-ES"
    case .pt: return "pt-BR"
  }
}
