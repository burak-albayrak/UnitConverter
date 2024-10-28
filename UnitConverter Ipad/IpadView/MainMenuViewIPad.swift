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
    @AppStorage("isDarkMode") private var isDarkMode = false

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
            FavoritesViewIPad()
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
                            } icon: {
                                Image(systemName: category.icon)
                            }
                        }
                        .tint(.accentColor)
                    }
                }
                
                Section("Price Converter") {
                    NavigationLink(value: "Currency") {
                        Label {
                            Text("Currency")
                        } icon: {
                            Image(systemName: "dollarsign.circle")
                        }
                    }
                    .tint(.accentColor)
                }
                
                Section("All Converters") {
                    ForEach(AllConvertersCategory.allCases) { category in
                        Button(action: {
                            selectedCategory = category
                            if UIDevice.current.userInterfaceIdiom == .pad {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    showAllConvertersMenu = true
                                }
                            } else {
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
            .navigationSplitViewColumnWidth(min: 250, ideal: 336, max: 400)
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .environment(\.colorScheme, isDarkMode ? .dark : .light)

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
                VStack(spacing: 16) {
                    Image(systemName: "arrow.left.circle")
                        .font(.system(size: 50))
                        .foregroundColor(.secondary)
                    
                    Text("Select a converter from the list")
                        .font(.title)
                        .foregroundColor(.secondary)
                }
            }
        }
        .fullScreenCover(isPresented: $showSettings) {
            SettingsViewIPad(showSettings: $showSettings)
        }
        .fullScreenCover(isPresented: $showFavorites) {
            FavoritesViewIPad()
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
