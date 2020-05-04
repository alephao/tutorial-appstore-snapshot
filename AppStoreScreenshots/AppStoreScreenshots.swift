import XCTest
import MyAwesomeAppFramework // Access to GreetingView
import SnapshotTesting // Access to the snapshot library
import SwiftUI // Access to UIHostingController

class AppStoreScreenshots: XCTestCase {

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func testScreenshots() throws {
      record = true // 1
      let view = GreetingView() // 2
      let vc = UIHostingController(rootView: view) // 3
      assertSnapshot(matching: vc, as: .image(on: .iPhoneXsMax)) // 4
    }

}
