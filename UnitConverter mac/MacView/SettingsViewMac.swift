//
//  SettingsViewMac.swift
//  UnitConverter mac
//
//  Created by Burak Albayrak on 28.10.2024.
//

import SwiftUI
import SwiftData

struct SettingsViewMac: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var showingClearConfirmation = false
    @State private var showLanguageChangeAlert = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("appLanguage") private var appLanguage = "en"
    
    var body: some View {
        Form {
            Section {
                Toggle("Dark Mode", isOn: $isDarkMode)
            } header: {
                Text("Appearance")
            }
            
            Section {
                Picker("Language", selection: $appLanguage) {
                    Text("English").tag("en")
                    Text("Türkçe").tag("tr")
                }
                .pickerStyle(.radioGroup)
                .onChange(of: appLanguage) { _, newValue in
                    UserDefaults.standard.set([newValue], forKey: "AppleLanguages")
                    UserDefaults.standard.synchronize()
                    showLanguageChangeAlert = true
                }
            } header: {
                Text("Language Settings")
            }
            
            Section {
                Button("Clear All Favorites") {
                    showingClearConfirmation = true
                }
                .foregroundColor(.red)
            } header: {
                Text("Favorites")
            }
            
            Section {
                Link("Send Feedback", destination: URL(string: "mailto:burak_albayrak0@icloud.com")!)
            } header: {
                Text("Feedback")
            }
            
            Section {
                Link("Rate the App", destination: URL(string: "https://apps.apple.com/tr/app/unit-converter-scientific/id6692634387")!)
            } header: {
                Text("About")
            }
            
            Text(getAppVersion())
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)
        }
        .formStyle(.grouped)
        .frame(width: 400, height: 500)
        .alert("Language Changed", isPresented: $showLanguageChangeAlert) {
            Button("OK") {
                NSApplication.shared.terminate(self)
            }
        } message: {
            Text("Please restart the app for the language change to take effect.")
        }
        .alert("Clear Favorites", isPresented: $showingClearConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                favoritesViewModel.clearAllFavorites()
            }
        } message: {
            Text("Are you sure you want to clear all favorites? This action cannot be undone.")
        }
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
        }
    }
    
    func getAppVersion() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "version \(version)"
    }
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return SettingsViewMac()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
