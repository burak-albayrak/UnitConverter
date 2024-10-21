//
//  ContentViewIPad.swift
//  UnitConverterIPad
//
//  Created by Burak Albayrak on 21.10.2024.
//

import SwiftUI

struct ContentViewIPad: View {
    @Binding var hasSeenWelcomeScreen: Bool
    @State private var mainMenuScale: CGFloat = 1
    @State private var mainMenuOpacity: Double = 0.0
    @State private var isTransitioningToMainMenu: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var sizeClass
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if !hasSeenWelcomeScreen {
                    WelcomeViewIPad(showWelcomeScreen: Binding(
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
                    mainMenuView(geometry: geometry)
                        .scaleEffect(mainMenuScale)
                        .opacity(mainMenuOpacity)
                }
            }
        }
        .onAppear {
            if hasSeenWelcomeScreen && !isTransitioningToMainMenu {
                mainMenuScale = 1.0
                mainMenuOpacity = 1.0
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
    
    private func mainMenuView(geometry: GeometryProxy) -> some View {
        MainMenuViewIPad()
            .frame(width: sizeClass == .regular ? geometry.size.width * 1 : nil)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentViewIPad(hasSeenWelcomeScreen: .constant(false))
}
