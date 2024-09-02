//
//  AllUnitsView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

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
        }
        // Diğer kategoriler için benzer şekilde devam edin
        // else if let heatCategory = unitCategory as? HeatUnitsCategory {
        //     UnitConversionView(viewModel: UnitConversionViewModel(category: heatCategory))
        // }
        // ...
        else {
            Text("Unsupported category")
        }
    }
}

#Preview {
    AllConvertersMenu(category: AllConvertersCategory.engineeringConverters)
}
