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

    var body: some Scene {
        WindowGroup {
            MainMenuView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .modelContainer(for: FavoriteConversion.self)
    }
}
