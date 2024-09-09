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

    var body: some Scene {
        WindowGroup {
            Group {
                if !hasSeenWelcomeScreen {
                    WelcomeView(showWelcomeScreen: Binding(
                        get: { !self.hasSeenWelcomeScreen },
                        set: { newValue in
                            self.hasSeenWelcomeScreen = !newValue
                        }
                    ))
                } else {
                    MainMenuView()
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .modelContainer(for: FavoriteConversion.self)
    }
}
