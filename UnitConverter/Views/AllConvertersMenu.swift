////
////  AllUnitsView.swift
////  UnitConverter
////
////  Created by Burak Albayrak on 31.08.2024.
////

import SwiftUI

struct AllConvertersMenu: View {
    let category: AllConvertersCategory

    var body: some View {
        List {
            ForEach(category.unitCategory, id: \.rawValue) { unitCategory in
                NavigationLink {
                    AnyView(makeUnitConversionView(for: unitCategory))
                } label: {
                    Label(unitCategory.rawValue, systemImage: unitCategory.icon)
                }
            }
        }
        .navigationTitle(category.rawValue)
    }
    
    @ViewBuilder
    private func makeUnitConversionView(for unitCategory: any UnitCategory) -> some View {
        if let engineeringCategory = unitCategory as? EngineeringUnitsCategory {
            UnitConversionView(viewModel: UnitConversionViewModel(category: engineeringCategory))
        } else if let heatCategory = unitCategory as? HeatUnitsCategory {
            UnitConversionView(viewModel: UnitConversionViewModel(category: heatCategory))
        } else if let fluidsCategory = unitCategory as? FluidsUnitsCategory {
            UnitConversionView(viewModel: UnitConversionViewModel(category: fluidsCategory))
        } else if let lightCategory = unitCategory as? LightUnitsCategory {
            UnitConversionView(viewModel: UnitConversionViewModel(category: lightCategory))
        } else if let electricityCategory = unitCategory as? ElectricityUnitsCategory {
            UnitConversionView(viewModel: UnitConversionViewModel(category: electricityCategory))
        } else if let magnetismCategory = unitCategory as? MagnetismUnitsCategory {
            UnitConversionView(viewModel: UnitConversionViewModel(category: magnetismCategory))
        } else if let radiologyCategory = unitCategory as? RadiollogyUnitsCategory {
            UnitConversionView(viewModel: UnitConversionViewModel(category: radiologyCategory))
        }
    }
}

#Preview {
    AllConvertersMenu(category: AllConvertersCategory.fluidsConverters)
}
