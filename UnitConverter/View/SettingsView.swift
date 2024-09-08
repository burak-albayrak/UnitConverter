//
//  SettingsView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 8.09.2024.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @AppStorage("darkModePreference") private var darkModePreference = DarkModePreference.system
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var showingClearConfirmation = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dark Mode Preference")) {
                    Picker("Dark Mode", selection: $darkModePreference) {
                        ForEach(DarkModePreference.allCases, id: \.self) { preference in
                            Text(preference.description).tag(preference)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Favorites")) {
                    Button("Clear All Favorites") {
                        showingClearConfirmation = true
                    }
                    .foregroundColor(.red)
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
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
        }
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

enum DarkModePreference: String, CaseIterable {
    case system
    case light
    case dark
    
    var description: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
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
