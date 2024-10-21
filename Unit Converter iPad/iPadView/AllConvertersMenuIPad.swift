//
//  AllConvertersMenuIPad.swift
//  UnitConverterIPad
//
//  Created by Burak Albayrak on 21.10.2024.
//

import SwiftUI

struct AllConvertersMenuIPad: View {
    let category: AllConvertersCategory
    @State private var selectedUnitCategoryIndex: Int?
    
    var body: some View {
        NavigationSplitView {
            List(Array(category.unitCategory.enumerated()), id: \.offset) { index, unitCategory in
                Button(action: {
                    selectedUnitCategoryIndex = index
                }) {
                    Label(unitCategory.localizedName, systemImage: unitCategory.icon)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle(category.localizedName)
        } detail: {
            if let index = selectedUnitCategoryIndex,
               let selectedCategory = category.unitCategory[safe: index] {
                makeUnitConversionView(for: selectedCategory)
            } else {
                Text("Bir dönüştürücü seçin")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
        }
        .navigationSplitViewStyle(.balanced)
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
        AllConvertersMenuIPad(category: AllConvertersCategory.fluidsConverters)
    }
}
