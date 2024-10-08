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
    
    var body: some View {
        NavigationView {
            List {
                Section("Common Converters") {
                    ForEach(CommonUnitsCategory.allCases, id: \.self) { category in
                        NavigationLink {
                            UnitConversionView(viewModel: UnitConversionViewModel(category: category))
                        } label: {
                            Label(category.localizedName, systemImage: category.icon)
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
                            Label(category.localizedName, systemImage: category.icon)
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
                        }
                        
                        Button(action: {
                            showSettings = true
                        }) {
                            Image(systemName: "gear")
                                .font(.title2)
                                .foregroundColor(.cyan)
                                .frame(width: 40, height: 40)
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
