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
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    
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
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gear")
                            .font(.title2)
                            .foregroundColor(.cyan)
                            .frame(width: 44, height: 44)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .preferredColorScheme(darkModeEnabled ? .dark : .light)
    }
}

#Preview {
    MainMenuView()
}

// islerrrrrr


// TODO: add history section with SwiftData

// TODO: add fav section with SwiftData I guess??

// TODO: her şeyi kontrol et

// TODO: birimlerin ilk girinceki unit'leri ayarla

// pre-Final

// TODO: improve info section
// TODO: improve UnitConversation View

// FINAL

// TODO: Dark mode kontrol
// TODO: Dil desteği
// TODO: uygulama rengi belirle.

// Extralar

// TODO: widget ????
// TODO: control center button ????

// TODO: add convert case (text inputum yok. farklı bir mac app olabilir.)
