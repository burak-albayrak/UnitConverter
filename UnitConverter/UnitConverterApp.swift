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
    @AppStorage("appLanguage") private var appLanguage: String = ""

    init() {
        setupInitialLanguage()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(hasSeenWelcomeScreen: $hasSeenWelcomeScreen)
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environment(\.colorScheme, isDarkMode ? .dark : .light)
                .environment(\.locale, .init(identifier: appLanguage))
        }
        .modelContainer(for: FavoriteConversion.self)
    }

    private func setupInitialLanguage() {
        if appLanguage.isEmpty {
            let preferredLanguage = Locale.preferredLanguages.first ?? "en"
            appLanguage = preferredLanguage.starts(with: "tr") ? "tr" : "en"
        }
        UserDefaults.standard.set([appLanguage], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}
