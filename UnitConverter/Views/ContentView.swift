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

    var body: some View {
        ZStack {
            if !hasSeenWelcomeScreen {
                WelcomeView(showWelcomeScreen: Binding(
                    get: { !self.hasSeenWelcomeScreen },
                    set: { newValue in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.hasSeenWelcomeScreen = !newValue
                            self.isShowingMainMenu = !newValue
                        }
                    }
                ))
                .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            } else {
                MainMenuView()
            }
            
            if isShowingMainMenu {
                MainMenuView()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
            }
        }
    }
}

#Preview {
    ContentView(hasSeenWelcomeScreen: .constant(false))
}
