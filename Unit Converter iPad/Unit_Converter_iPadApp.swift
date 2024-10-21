//
//  Unit_Converter_iPadApp.swift
//  Unit Converter iPad
//
//  Created by Burak Albayrak on 21.10.2024.
//

//
//  Unit_Converter_iPadApp.swift
//  Unit Converter iPad
//
//  Created by Burak Albayrak on 21.10.2024.
//

import SwiftUI
import SwiftData

@main
struct UnitConverterApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("hasSeenWelcomeScreen") private var hasSeenWelcomeScreen = false
    @AppStorage("appLanguage") private var appLanguage: String = ""
    @Environment(\.horizontalSizeClass) var sizeClass

    init() {
        setupInitialLanguage()
    }
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { geometry in
                ContentViewIPad(hasSeenWelcomeScreen: $hasSeenWelcomeScreen)
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                    .environment(\.colorScheme, isDarkMode ? .dark : .light)
                    .environment(\.locale, .init(identifier: appLanguage))
                    .frame(maxWidth: maxWidth(for: geometry.size.width),
                           maxHeight: .infinity,
                           alignment: .center)
            }
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
    
    private func maxWidth(for width: CGFloat) -> CGFloat? {
        // iPad'de içeriği sınırla, iPhone'da tam genişlik kullan
        return sizeClass == .regular ? min(width, 800) : nil
    }
}
