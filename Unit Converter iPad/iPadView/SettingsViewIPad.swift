//
//  SettingsViewIPad.swift
//  UnitConverterIPad
//
//  Created by Burak Albayrak on 21.10.2024.
//

import SwiftUI
import SwiftData
import MessageUI
import StoreKit

struct SettingsViewIPad: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(\.horizontalSizeClass) var sizeClass
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
                Group {
                    appearanceSection
                    languageSection
                    favoritesSection
                    feedbackSection
                    aboutSection
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
            
            if sizeClass == .regular {
                // Placeholder view for iPad
                Text("Select a setting to view details")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .sheet(isPresented: $isShowingMailView) {
            MailViewIPad(result: $mailResult) { composer in
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
    
    private var appearanceSection: some View {
        Section(header: Text("Appearance")) {
            Toggle("Dark Mode", isOn: $isDarkMode)
        }
    }
    
    private var languageSection: some View {
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
    }
    
    private var favoritesSection: some View {
        Section(header: Text("Favorites")) {
            Button("Clear All Favorites") {
                showingClearConfirmation = true
            }
            .foregroundColor(.red)
        }
    }
    
    private var feedbackSection: some View {
        Section(header: Text("Feedback")) {
            Button("Feedback Me") {
                isShowingMailView = true
            }
        }
    }
    
    private var aboutSection: some View {
        Section(header: Text("About")) {
            Link("Rate the App", destination: URL(string: "https://apps.apple.com/tr/app/unit-converter-scientific/id6692634387")!)
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
        return SettingsViewIPad()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
