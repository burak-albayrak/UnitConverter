//
//  ContentViewMac.swift
//  UnitConverter mac
//
//  Created by Burak Albayrak on 28.10.2024.
//

import SwiftUI
import SwiftData

struct ContentViewMac: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        MainMenuViewMac()
            .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentViewMac()
}
