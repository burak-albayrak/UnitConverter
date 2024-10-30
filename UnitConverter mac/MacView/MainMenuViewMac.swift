//
//  MainMenuViewMac.swift
//  UnitConverter mac
//
//  Created by Burak Albayrak on 28.10.2024.
//

import SwiftUI
import SwiftData

struct MainMenuViewMac: View {
    @State private var selectedCategory: AllConvertersCategory?
    @State private var selectedUnitCategory: UnitCategory?
    @State private var showSettings = false
    @State private var showFavorites = false
    @State private var selectedSidebarItem: SidebarItem?
    
    enum SidebarItem: Hashable {
        case common(CommonUnitsCategory)
        case currency
        case allConverters(AllConvertersCategory)
    }
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedSidebarItem) {
                Section("Common Converters") {
                    ForEach(CommonUnitsCategory.allCases, id: \.self) { category in
                        NavigationLink(value: SidebarItem.common(category)) {
                            Label(category.localizedName, systemImage: category.icon)
                        }
                    }
                }
                
                Section("Price Converter") {
                    NavigationLink(value: SidebarItem.currency) {
                        Label("Currency", systemImage: "dollarsign.circle")
                    }
                }
                
                Section("All Converters") {
                    ForEach(AllConvertersCategory.allCases) { category in
                        NavigationLink(value: SidebarItem.allConverters(category)) {
                            Label(category.localizedName, systemImage: category.icon)
                        }
                    }
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItem {
                    Button(action: { showFavorites = true }) {
                        Image(systemName: "star.fill")
                    }
                }
                ToolbarItem {
                    Button(action: { showSettings = true }) {
                        Image(systemName: "gear")
                    }
                }
            }
        } detail: {
            if let selectedItem = selectedSidebarItem {
                switch selectedItem {
                case .common(let category):
                    UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category))
                case .currency:
                    CurrencyConversionViewMac()
                case .allConverters(let category):
                    AllConvertersMenuMac(category: category)
                }
            } else {
                Text("Select a converter from the sidebar")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsViewMac()
        }
        .sheet(isPresented: $showFavorites) {
            FavoritesViewMac()
        }
    }
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return MainMenuViewMac()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
