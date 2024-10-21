//
//  MainMenuViewIPad.swift
//  UnitConverterIPad
//
//  Created by Burak Albayrak on 21.10.2024.
//

import SwiftUI

struct MainMenuViewIPad: View {
    @State private var selectedCategory: AllConvertersCategory?
    @State private var selectedUnitCategory: UnitCategory?
    @State private var showSettings = false
    @State private var showFavorites = false
    @State private var selectedItem: String?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedItem) {
                Section("Common Converters") {
                    ForEach(CommonUnitsCategory.allCases, id: \.self) { category in
                        NavigationLink(value: category.rawValue) {
                            Label(category.localizedName, systemImage: category.icon)
                        }
                    }
                }
                
                Section("Price Converter") {
                    NavigationLink(value: "Currency") {
                        Label("Currency", systemImage: "dollarsign.circle")
                    }
                }
                
                Section("All Converters") {
                    ForEach(AllConvertersCategory.allCases) { category in
                        NavigationLink(value: category.rawValue) {
                            Label(category.localizedName, systemImage: category.icon)
                        }
                    }
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: { showFavorites = true }) {
                            Image(systemName: "star.fill")
                                .font(.title2)
                                .foregroundColor(.cyan)
                        }
                        
                        Button(action: { showSettings = true }) {
                            Image(systemName: "gear")
                                .font(.title2)
                                .foregroundColor(.cyan)
                        }
                    }
                }
            }
        } detail: {
            if let selectedItem = selectedItem {
                if let commonCategory = CommonUnitsCategory(rawValue: selectedItem) {
                    UnitConversionViewIPad(viewModel: UnitConversionViewModel(category: commonCategory))
                } else if selectedItem == "Currency" {
                    CurrencyConversionViewIPad()
                } else if let allConvertersCategory = AllConvertersCategory(rawValue: selectedItem) {
                    AllConvertersMenuIPad(category: allConvertersCategory)
                }
            } else {
                Text("Bir dönüştürücü seçin")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
        }
        .navigationSplitViewStyle(.balanced)
        .sheet(isPresented: $showSettings) {
            SettingsViewIPad()
        }
        .sheet(isPresented: $showFavorites) {
            NavigationView {
                FavoritesViewIPad()
            }
        }
    }
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return MainMenuViewIPad()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
