//
//  ContentView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 10.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showWelcomeScreen = true

    var body: some View {
        if showWelcomeScreen {
            WelcomeView(showWelcomeScreen: $showWelcomeScreen)
        } else {
            MainMenuView()
        }
    }
}

#Preview {
    ContentView()
}
