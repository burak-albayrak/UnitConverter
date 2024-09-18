//
//  ContentView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 10.09.2024.
//

import SwiftUI

struct ContentView: View {
    @Binding var hasSeenWelcomeScreen: Bool
    @State private var mainMenuScale: CGFloat = 0.8
    @State private var mainMenuOpacity: Double = 0.0
    @State private var isTransitioningToMainMenu: Bool = false
    
    var body: some View {
        ZStack {
            if !hasSeenWelcomeScreen {
                WelcomeView(showWelcomeScreen: Binding(
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
                MainMenuView()
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
    }
}

#Preview {
    ContentView(hasSeenWelcomeScreen: .constant(false))
}
