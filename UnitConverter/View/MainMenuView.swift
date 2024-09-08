//
//  MainMenu.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import SwiftUI

struct MainMenuView: View {
    @State private var selectedCategory: AllConvertersCategory?
    @State private var selectedUnitCategory: UnitCategory?
    @State private var showSettings = false
    @State private var showFavorites = false
    @AppStorage("darkModePreference") private var darkModePreference = DarkModePreference.system
    @Environment(\.colorScheme) private var systemColorScheme
    
    var body: some View {
        NavigationView {
            List {
                Section("Common Converters") {
                    ForEach(CommonUnitsCategory.allCases, id: \.self) { category in
                        NavigationLink {
                            UnitConversionView(viewModel: UnitConversionViewModel(category: category))
                        } label: {
                            Label(category.rawValue, systemImage: category.icon)
                        }
                    }
                }
                
                Section("Price Converter") {
                    NavigationLink {
                        CurrencyConversionView()
                    } label: {
                        Label("Currency", systemImage: "dollarsign.circle")
                    }
                }
                
                Section("All Converters") {
                    ForEach(AllConvertersCategory.allCases) { category in
                        NavigationLink {
                            AllConvertersMenu(category: category)
                        } label: {
                            Label(category.rawValue, systemImage: category.icon)
                        }
                    }
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            showFavorites = true
                        }) {
                            Image(systemName: "star.fill")
                                .font(.title2)
                                .foregroundColor(.cyan)
                                .frame(width: 40, height: 40)
                                .background(Color.gray.opacity(0.05))
                                .clipShape(Circle())
                        }
                        
                        Button(action: {
                            showSettings = true
                        }) {
                            Image(systemName: "gear")
                                .font(.title2)
                                .foregroundColor(.cyan)
                                .frame(width: 40, height: 40)
                                .background(Color.gray.opacity(0.05))
                                .clipShape(Circle())
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .sheet(isPresented: $showFavorites) {
            NavigationView {
                FavoritesView()
            }
        }
        .preferredColorScheme(preferredColorScheme)
    }
    
    private var preferredColorScheme: ColorScheme? {
        switch darkModePreference {
        case .system:
            return nil // Sistem ayarını kullan
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return MainMenuView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

// islerrrrrr

// TODO: her şeyi kontrol et

// TODO: birimlerin ilk girinceki unit'leri ayarla ??


// FINAL

// TODO: Dark mode kontrol
// TODO: Dil desteği

// Extralar

// TODO: widget ????
// TODO: control center button ????

// TODO: add convert case (text inputum yok. farklı bir mac app olabilir.)


// TODO: add history section with SwiftData (şu anki yapıma göre imkansız.)
