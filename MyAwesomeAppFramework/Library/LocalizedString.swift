import Foundation

public func localizedString(
  key: String,
  defaultValue: String = "",
  substitutions: [String: String] = [:],
  env: AppEnvironment = AppEnvironment.shared,
  bundle: Bundle = stringsBundle
) -> String {
  let lprojName = lprojFileNameForLanguage(env.language)
  let localized = bundle.path(forResource: lprojName, ofType: "lproj")
    .flatMap(Bundle.init(path:))
    .flatMap { $0.localizedString(forKey: key, value: nil, table: nil) } ?? defaultValue
  return substitute(localized, with: substitutions)
}

private func lprojFileNameForLanguage(_ language: Language) -> String {
  switch language {
    case .enUS: return "en"
    case .enAU: return "en-AU"
    case .pt: return "pt-BR"
    case .es: return "es"
  }
}

//// Performs simple string interpolation on keys of the form `%{key}`.
private func substitute(_ string: String, with substitutions: [String: String]) -> String {
  return substitutions.reduce(string) { accum, sub in
    accum.replacingOccurrences(of: "%{\(sub.0)}", with: sub.1)
  }
}

private class Pin {}
public let stringsBundle = Bundle(for: Pin.self)
