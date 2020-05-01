public enum Language: String {
  case enUS
  case enAU
  case es
  case pt

  public init?(languageString language: String) {
    switch language.lowercased() {
    case "en", "en-us": self = .enUS
    case "en-au": self = .enAU
    case "pt", "pt-br": self = .pt
    case "es": self = .es
    default: return nil
    }
  }

  public init?(languageStrings languages: [String]) {
    if let language = languages
      .compactMap(Language.init(languageString:))
      .first {
      self = language
    } else if let language = languages
      .map({ String($0.prefix(2)) })
      .compactMap(Language.init(languageString:))
      .first {
      self = language
    } else {
      return nil
    }
  }
}
