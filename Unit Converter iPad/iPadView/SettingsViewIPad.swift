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
    @Environment(\.modelContext) private var modelContext
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("appLanguage") private var appLanguage = "en"
    @Binding var showSettings: Bool
    
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink(destination: AppearanceView()) {
                    Label("Appearance", systemImage: "paintbrush")
                }
                NavigationLink(destination: LanguageView()) {
                    Label("Language", systemImage: "globe")
                }
                NavigationLink(destination: FavoritesView()) {
                    Label("Favorites", systemImage: "star")
                }
                NavigationLink(destination: FeedbackView()) {
                    Label("Feedback", systemImage: "envelope")
                }
                NavigationLink(destination: AboutView()) {
                    Label("About", systemImage: "info.circle")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showSettings = false
                    }) {
                        Label("Back", systemImage: "chevron.left")
                    }
                }
            }
        } detail: {
            Text("Select a setting to view details")
                .font(.largeTitle)
                .foregroundColor(.secondary)
        }
        .navigationSplitViewStyle(.balanced)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    showSettings = false
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back to Main Menu")
                    }
                }
            }
        }
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct AppearanceView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        Form {
            Toggle("Dark Mode", isOn: $isDarkMode)
        }
        .navigationTitle("Appearance")
    }
}

struct LanguageView: View {
    @AppStorage("appLanguage") private var appLanguage = "en"
    @State private var showLanguageChangeAlert = false

    var body: some View {
        Form {
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
        .navigationTitle("Language")
        .alert(isPresented: $showLanguageChangeAlert) {
            Alert(
                title: Text("Language Changed"),
                message: Text("Please restart the app for the language change to take effect."),
                dismissButton: .default(Text("OK")) {
                    exit(0)
                }
            )
        }
    }
}

struct FavoritesView: View {
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var showingClearConfirmation = false

    var body: some View {
        Form {
            Button("Clear All Favorites") {
                showingClearConfirmation = true
            }
            .foregroundColor(.red)
        }
        .navigationTitle("Favorites")
        .alert("Clear All Favorites", isPresented: $showingClearConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                favoritesViewModel.clearAllFavorites()
            }
        } message: {
            Text("Are you sure you want to clear all favorites? This action cannot be undone.")
        }
    }
}

struct FeedbackView: View {
    @State private var isShowingMailView = false
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil

    var body: some View {
        Form {
            Button("Send Feedback") {
                isShowingMailView = true
            }
            .foregroundColor(.accentColor)
        }
        .navigationTitle("Feedback")
        .sheet(isPresented: $isShowingMailView) {
            MailViewIPad(result: $mailResult) { composer in
                composer.setSubject(String(localized: "Feedback for Unit Converter App"))
                composer.setToRecipients(["burak_albayrak0@icloud.com"])
            }
        }
    }
}

struct AboutView: View {
    var body: some View {
        Form {
            Link("Rate the App", destination: URL(string: "https://apps.apple.com/tr/app/unit-converter-scientific/id6692634387")!)
            Text("Version \(getAppVersion())")
                .foregroundColor(.secondary)
        }
        .navigationTitle("About")
    }

    func getAppVersion() -> String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return SettingsViewIPad(showSettings: .constant(true))
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
