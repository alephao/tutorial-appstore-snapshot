import UIKit
import SwiftUI
import MyAwesomeAppFramework
import PlaygroundSupport

//
// Language
// Possible values: .enUS, .enAU, .pt, .es
let language: Language = .enUS

//
// UserDefaults
let userDefaults = UserDefaults()

// Set a string value for the UserDefaults.Key.username key
userDefaults.setValue("Aleph", forKey: UserDefaults.Key.username)

// Or remove the value
//userDefaults.removeObject(forKey: UserDefaults.Key.username)

//
// Setup mocked environment
let env = Environment(userDefaults: userDefaults, language: language)
AppEnvironment.shared.env = env

//
// Show view
PlaygroundPage.current.liveView = UIHostingController(rootView: GreetingView())
