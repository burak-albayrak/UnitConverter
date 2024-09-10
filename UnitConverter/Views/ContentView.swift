//
//  ContentView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 10.09.2024.
//

import SwiftUI

struct ContentView: View {
    @Binding var hasSeenWelcomeScreen: Bool
    @State private var isShowingMainMenu = false
    @State private var mainMenuScale: CGFloat = 0.8
    @State private var mainMenuOpacity: Double = 0.0

    var body: some View {
        ZStack {
            if !hasSeenWelcomeScreen {
                WelcomeView(showWelcomeScreen: Binding(
                    get: { !self.hasSeenWelcomeScreen },
                    set: { newValue in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.hasSeenWelcomeScreen = !newValue
                            if !newValue {
                                self.isShowingMainMenu = true
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
            
            if isShowingMainMenu {
                MainMenuView()
                    .scaleEffect(mainMenuScale)
                    .opacity(mainMenuOpacity)
            }
        }
    }
}

#Preview {
    ContentView(hasSeenWelcomeScreen: .constant(false))
}
