import SwiftUI
import Combine

public struct GreetingView: View {
  @ObservedObject var env: AppEnvironment = .shared

  public init() {}

  public var body: some View {
    Text(greeting(env.userDefaults.string(forKey: UserDefaults.Key.username)))
      .font(Font.title)
  }

  public func greeting(_ username: String?) -> String {
    let username = username ?? localizedString(key: "ANON")
    return localizedString(
      key: "HELLO",
      substitutions: ["name": username]
    )
  }
}

struct GreetingView_Previews: PreviewProvider {
  static var previews: some View {
    GreetingView()
  }
}
