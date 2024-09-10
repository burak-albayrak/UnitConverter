//
//  UnitConverterApp.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import SwiftUI
import SwiftData

@main
struct UnitConverterApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("hasSeenWelcomeScreen") private var hasSeenWelcomeScreen = false
    @AppStorage("appLanguage") private var appLanguage = "en"

    init() {
        UserDefaults.standard.set([appLanguage], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(hasSeenWelcomeScreen: $hasSeenWelcomeScreen)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .modelContainer(for: FavoriteConversion.self)
    }
}
