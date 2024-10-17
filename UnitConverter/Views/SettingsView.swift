//
//  SettingsView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 8.09.2024.
//

import SwiftUI
import SwiftData
import MessageUI
import StoreKit

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var showingClearConfirmation = false
    @State private var isShowingMailView = false
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    @State private var showingPurchaseAlert = false
    @State private var purchaseAlertMessage = ""
    @State private var showLanguageChangeAlert = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("appLanguage") private var appLanguage = "en"
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                
                Section(header: Text("Language")) {
                    Picker("Language", selection: $appLanguage) {
                        Text("English").tag("en")
                        Text("Türkçe").tag("tr")
                    }
                    .pickerStyle(DefaultPickerStyle())
                    .onChange(of: appLanguage) { _, newValue in
                        UserDefaults.standard.set([newValue], forKey: "AppleLanguages")
                        UserDefaults.standard.synchronize()
                        showLanguageChangeAlert = true
                    }
                }
                
                Section(header: Text("Favorites")) {
                    Button("Clear All Favorites") {
                        showingClearConfirmation = true
                    }
                    .foregroundColor(.red)
                }
                
                Section(header: Text("Feedback")) {
                    Button("Feedback Me") {
                        isShowingMailView = true
                    }
                }
                
                Section(header: Text("About")) {
                    Link("Rate the App", destination: URL(string: "https://apps.apple.com/tr/app/unit-converter-scientific/id6692634387")!)
                }
                
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingMailView) {
            MailView(result: $mailResult) { composer in
                composer.setSubject(String(localized: "Feedback for Unit Converter App"))
                composer.setToRecipients(["burak_albayrak0@icloud.com"])
            }
        }
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
        }
        .alert(isPresented: $showingPurchaseAlert) {
            Alert(title: Text("Purchase"), message: Text(purchaseAlertMessage), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showLanguageChangeAlert) {
            Alert(
                title: Text("Language Changed"),
                message: Text("Please restart the app for the language change to take effect."),
                dismissButton: .default(Text("OK")) {
                    exit(0) // This will force quit the app
                }
            )
        }
        .alert("Clear All Favorites", isPresented: $showingClearConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                favoritesViewModel.clearAllFavorites()
            }
        } message: {
            Text("Are you sure you want to clear all favorites? This action cannot be undone.")
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        
        Text(getAppVersion())
            .foregroundColor(.secondary)
            .padding(.top, 20)
    }
    
    func getAppVersion() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "version \(version)"
    }
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return SettingsView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
