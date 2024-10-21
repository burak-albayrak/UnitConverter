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
    @State private var selectedCommonCategory: CommonUnitsCategory?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var showAllConvertersMenu = false

    var body: some View {
        Group {
            if showAllConvertersMenu, let category = selectedCategory {
                AllConvertersMenuIPad(category: category, onDismiss: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showAllConvertersMenu = false
                        selectedCategory = nil
                    }
                })
            } else {
                mainMenuContent
            }
        }
        .navigationSplitViewStyle(.balanced)
        .onAppear {
            columnVisibility = .all
        }
        .sheet(isPresented: $showSettings) {
            SettingsViewIPad(showSettings: $showSettings)
        }
        .sheet(isPresented: $showFavorites) {
            NavigationView {
                FavoritesViewIPad()
            }
        }
    }

    private var mainMenuContent: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(selection: $selectedItem) {
                Section("Common Converters") {
                    ForEach(CommonUnitsCategory.allCases, id: \.self) { category in
                        NavigationLink(value: category.rawValue) {
                            Label {
                                Text(category.localizedName)
                                    .foregroundColor(selectedItem == category.rawValue ? .accentColor : .primary)

                            } icon: {
                                Image(systemName: category.icon)
                                    .foregroundColor(.accentColor)

                            }
                        }
                    }
                }
                
                Section("Price Converter") {
                    NavigationLink(value: "Currency") {
                        Label {
                            Text("Currency")
                                .foregroundColor(selectedItem == "Currency" ? .accentColor : .primary)

                        } icon: {
                            Image(systemName: "dollarsign.circle")
                                .foregroundColor(.accentColor)

                        }
                    }
                }
                
                Section("All Converters") {
                    ForEach(AllConvertersCategory.allCases) { category in
                        Button(action: {
                            selectedCategory = category
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showAllConvertersMenu = true
                            }
                        }) {
                            Label {
                                Text(category.localizedName)
                                    .foregroundColor(selectedCategory == category ? .accentColor : .primary)
                            } icon: {
                                Image(systemName: category.icon)
                                    .foregroundColor(.accentColor)
                            }
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
                                .foregroundColor(.accentColor)
                        }
                        
                        Button(action: { showSettings = true }) {
                            Image(systemName: "gear")
                                .font(.title2)
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
        } detail: {
            if let selectedItem = selectedItem {
                if let commonCategory = CommonUnitsCategory(rawValue: selectedItem) {
                    UnitConversionViewIPad(viewModel: UnitConversionViewModel(category: commonCategory))
                        .id(commonCategory)
                } else if selectedItem == "Currency" {
                    CurrencyConversionViewIPad()
                } else if let allConvertersCategory = AllConvertersCategory(rawValue: selectedItem) {
                    AllConvertersMenuIPad(category: allConvertersCategory, onDismiss: {})
                }
            } else {
                Text("Bir dönüştürücü seçin")
                    .font(.title)
                    .foregroundColor(.secondary)
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
