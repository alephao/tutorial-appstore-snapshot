import Combine

@dynamicMemberLookup
public class AppEnvironment: ObservableObject {
  #if DEBUG
  public static var shared = AppEnvironment()
  #else
  public static let shared = AppEnvironment()
  #endif

  @Published public var env: Environment

  public subscript<Value>(dynamicMember keyPath: KeyPath<Environment, Value>) -> Value {
    return env[keyPath: keyPath]
  }

  public init() {
    env = Environment()
  }
}

public struct Environment {
  public var userDefaults: UserDefaults
  public var language: Language

  public init(
    userDefaults: UserDefaults = .standard,
    language: Language = Language(languageStrings: Locale.preferredLanguages) ?? .enUS
  ) {
    self.userDefaults = userDefaults
    self.language = language
  }
}
