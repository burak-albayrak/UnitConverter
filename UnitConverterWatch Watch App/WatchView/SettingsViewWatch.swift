//
//  SettingsViewWatch.swift
//  UnitConverterWatch Watch App
//
//  Created by Burak Albayrak on 18.10.2024.
//

import SwiftUI
import SwiftData

struct SettingsViewWatch: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var showingClearConfirmation = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("appLanguage") private var appLanguage = "en"
    
    var body: some View {
        List {
            Section(header: Text("Language")) {
                Picker("Language", selection: $appLanguage) {
                    Text("English").tag("en")
                    Text("Türkçe").tag("tr")
                }
            }
            
            Section(header: Text("Favorites")) {
                Button("Clear All Favorites") {
                    showingClearConfirmation = true
                }
                .foregroundColor(.red)
            }
            
            Section(header: Text("About")) {
                Text(getAppVersion())
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
        }
        .alert("Clear All Favorites", isPresented: $showingClearConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                favoritesViewModel.clearAllFavorites()
            }
        } message: {
            Text("Are you sure you want to clear all favorites?")
        }
    }
    
    func getAppVersion() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "Version \(version)"
    }
        
}

#Preview {
    SettingsViewWatch()
}
