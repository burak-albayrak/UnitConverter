//
//  AllConvertersMenuIPad.swift
//  UnitConverterIPad
//
//  Created by Burak Albayrak on 21.10.2024.
//

import SwiftUI

struct AllConvertersMenuIPad: View {
    let category: AllConvertersCategory
    let onDismiss: () -> Void
    @State private var selectedUnitCategoryIndex: Int?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var showSettings = false
    @State private var showFavorites = false

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(Array(category.unitCategory.enumerated()), id: \.offset, selection: $selectedUnitCategoryIndex) { index, unitCategory in
                Button(action: {
                    selectedUnitCategoryIndex = index
                }) {
                    Label {
                        Text(unitCategory.localizedName)
                            .foregroundColor(selectedUnitCategoryIndex == index ? .accentColor : .primary)
                    } icon: {
                        Image(systemName: unitCategory.icon)
                            .foregroundColor(.accentColor)
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
            .navigationSplitViewColumnWidth(min: 250, ideal: 400, max: 400)
            .navigationTitle(category.localizedName)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: onDismiss) {
                        Label("Back", systemImage: "chevron.left")
                    }
                }
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
            if let index = selectedUnitCategoryIndex,
               let selectedCategory = category.unitCategory[safe: index] {
                makeUnitConversionView(for: selectedCategory)
                    .id(index)
            } else {
                Text("Bir dönüştürücü seçin")
                    .font(.title)
                    .foregroundColor(.secondary)
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
    
    @ViewBuilder
    private func makeUnitConversionView(for unitCategory: any UnitCategory) -> some View {
        if let engineeringCategory = unitCategory as? EngineeringUnitsCategory {
            UnitConversionViewIPad(viewModel: UnitConversionViewModel(category: engineeringCategory))
        } else if let heatCategory = unitCategory as? HeatUnitsCategory {
            UnitConversionViewIPad(viewModel: UnitConversionViewModel(category: heatCategory))
        } else if let fluidsCategory = unitCategory as? FluidsUnitsCategory {
            UnitConversionViewIPad(viewModel: UnitConversionViewModel(category: fluidsCategory))
        } else if let lightCategory = unitCategory as? LightUnitsCategory {
            UnitConversionViewIPad(viewModel: UnitConversionViewModel(category: lightCategory))
        } else if let electricityCategory = unitCategory as? ElectricityUnitsCategory {
            UnitConversionViewIPad(viewModel: UnitConversionViewModel(category: electricityCategory))
        } else if let magnetismCategory = unitCategory as? MagnetismUnitsCategory {
            UnitConversionViewIPad(viewModel: UnitConversionViewModel(category: magnetismCategory))
        } else if let radiologyCategory = unitCategory as? RadiollogyUnitsCategory {
            UnitConversionViewIPad(viewModel: UnitConversionViewModel(category: radiologyCategory))
        }
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    NavigationView {
        AllConvertersMenuIPad(category: AllConvertersCategory.fluidsConverters, onDismiss: {})
    }
}
