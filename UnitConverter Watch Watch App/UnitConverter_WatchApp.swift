//
//  UnitConverterWatchApp.swift
//  UnitConverterWatch Watch App
//
//  Created by Burak Albayrak on 17.10.2024.
//

import SwiftUI
import SwiftData

@main
struct UnitConverterWatch_Watch_AppApp: App {
    @AppStorage("hasSeenWelcomeScreen") private var hasSeenWelcomeScreen = false
    @AppStorage("appLanguage") private var appLanguage: String = ""

    init() {
        setupInitialLanguage()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentViewWatch(hasSeenWelcomeScreen: $hasSeenWelcomeScreen)
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
