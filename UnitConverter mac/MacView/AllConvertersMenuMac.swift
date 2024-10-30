//
//  AllConvertersMenuMac.swift
//  UnitConverter mac
//
//  Created by Burak Albayrak on 28.10.2024.
//

import SwiftUI

struct AllConvertersMenuMac: View {
    let category: AllConvertersCategory
    
    var body: some View {
        List {
            ForEach(category.unitCategory, id: \.rawValue) { unitCategory in
                NavigationLink {
                    AnyView(makeUnitConversionView(for: unitCategory))
                } label: {
                    VStack(alignment: .leading) {
                        Text(unitCategory.localizedName)
                            .font(.headline)
                        Text(unitCategory.info)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle(category.localizedName)
        .frame(minWidth: 300, idealWidth: 350, maxWidth: .infinity,
               minHeight: 400, idealHeight: 500, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func makeUnitConversionView(for unitCategory: any UnitCategory) -> some View {
        if let engineeringCategory = unitCategory as? EngineeringUnitsCategory {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: engineeringCategory))
        } else if let heatCategory = unitCategory as? HeatUnitsCategory {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: heatCategory))
        } else if let fluidsCategory = unitCategory as? FluidsUnitsCategory {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: fluidsCategory))
        } else if let lightCategory = unitCategory as? LightUnitsCategory {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: lightCategory))
        } else if let electricityCategory = unitCategory as? ElectricityUnitsCategory {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: electricityCategory))
        } else if let magnetismCategory = unitCategory as? MagnetismUnitsCategory {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: magnetismCategory))
        } else if let radiologyCategory = unitCategory as? RadiollogyUnitsCategory {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: radiologyCategory))
        }
    }
}

#Preview {
    NavigationView {
        AllConvertersMenuMac(category: .fluidsConverters)
    }
}
