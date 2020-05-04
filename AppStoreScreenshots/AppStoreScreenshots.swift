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
    let userDefaults = UserDefaults() // 1
    withEnvironment(userDefaults: userDefaults, language: .enUS) {
      let view = GreetingView()
      let vc = UIHostingController(rootView: view)
      assertSnapshot(matching: vc, as: .image(on: .iPhoneXsMax))
    }
  }

}
