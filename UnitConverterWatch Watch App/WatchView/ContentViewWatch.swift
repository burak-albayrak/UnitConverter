//
//  ContentViewWatch.swift
//  UnitConverterWatch Watch App
//
//  Created by Burak Albayrak on 18.10.2024.
//

import SwiftUI

struct ContentViewWatch: View {
    @Binding var hasSeenWelcomeScreen: Bool
    
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
        // Watch OS için varsayılan renk şemasını kullan
        .environment(\.colorScheme, .dark)
    }
}

#Preview {
    ContentViewWatch(hasSeenWelcomeScreen: .constant(false))
}
