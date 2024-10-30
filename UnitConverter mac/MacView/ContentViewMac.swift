//
//  ContentViewMac.swift
//  UnitConverter mac
//
//  Created by Burak Albayrak on 28.10.2024.
//

import SwiftUI
import SwiftData

struct ContentViewMac: View {
    @Binding var hasSeenWelcomeScreen: Bool
    @State private var mainMenuScale: CGFloat = 0.8
    @State private var mainMenuOpacity: Double = 0.0
    @State private var isTransitioningToMainMenu: Bool = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        ZStack {
            if !hasSeenWelcomeScreen {
                WelcomeViewMac(showWelcomeScreen: Binding(
                    get: { !self.hasSeenWelcomeScreen },
                    set: { newValue in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.hasSeenWelcomeScreen = !newValue
                            if !newValue {
                                self.isTransitioningToMainMenu = true
                                withAnimation(.easeInOut(duration: 0.5).delay(0.3)) {
                                    self.mainMenuScale = 1.0
                                    self.mainMenuOpacity = 1.0
                                }
                            }
                        }
                    }
                ))
                .transition(.opacity)
            }
            
            if hasSeenWelcomeScreen || isTransitioningToMainMenu {
                MainMenuViewMac()
                    .scaleEffect(mainMenuScale)
                    .opacity(mainMenuOpacity)
            }
        }
        .onAppear {
            if hasSeenWelcomeScreen && !isTransitioningToMainMenu {
                mainMenuScale = 1.0
                mainMenuOpacity = 1.0
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentViewMac(hasSeenWelcomeScreen: .constant(false))
}
