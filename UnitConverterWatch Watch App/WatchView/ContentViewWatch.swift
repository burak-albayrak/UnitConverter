//
//  ContentViewWatch.swift
//  UnitConverterWatch Watch App
//
//  Created by Burak Albayrak on 18.10.2024.
//

import SwiftUI

struct ContentViewWatch: View {
    @Binding var hasSeenWelcomeScreen: Bool
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        ZStack {
            if !hasSeenWelcomeScreen {
                WelcomeViewWatch(showWelcomeScreen: Binding(
                    get: { !self.hasSeenWelcomeScreen },
                    set: { newValue in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.hasSeenWelcomeScreen = !newValue
                        }
                    }
                ))
            } else {
                MainMenuViewWatch()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentViewWatch(hasSeenWelcomeScreen: .constant(false))
}
