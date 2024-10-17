//
//  AllConvertersMenuWatch.swift
//  UnitConverterWatch Watch App
//
//  Created by Burak Albayrak on 18.10.2024.
//

import SwiftUI

struct AllConvertersMenuWatch: View {
    let category: AllConvertersCategory
    
    var body: some View {
        List {
            ForEach(category.unitCategory, id: \.rawValue) { unitCategory in
                NavigationLink(destination: makeUnitConversionView(for: unitCategory)) {
                    Label(unitCategory.localizedName, systemImage: unitCategory.icon)
                }
            }
        }
        .navigationTitle(category.localizedName)
        .listStyle(CarouselListStyle())
    }
    
    @ViewBuilder
    private func makeUnitConversionView(for unitCategory: any UnitCategory) -> some View {
        switch unitCategory {
        case let engineeringCategory as EngineeringUnitsCategory:
            UnitConversionViewWatch(viewModel: UnitConversionViewModel(category: engineeringCategory))
        case let heatCategory as HeatUnitsCategory:
            UnitConversionViewWatch(viewModel: UnitConversionViewModel(category: heatCategory))
        case let fluidsCategory as FluidsUnitsCategory:
            UnitConversionViewWatch(viewModel: UnitConversionViewModel(category: fluidsCategory))
        case let lightCategory as LightUnitsCategory:
            UnitConversionViewWatch(viewModel: UnitConversionViewModel(category: lightCategory))
        case let electricityCategory as ElectricityUnitsCategory:
            UnitConversionViewWatch(viewModel: UnitConversionViewModel(category: electricityCategory))
        case let magnetismCategory as MagnetismUnitsCategory:
            UnitConversionViewWatch(viewModel: UnitConversionViewModel(category: magnetismCategory))
        case let radiologyCategory as RadiollogyUnitsCategory:
            UnitConversionViewWatch(viewModel: UnitConversionViewModel(category: radiologyCategory))
        default:
            EmptyView()
        }
    }
}

#Preview {
    AllConvertersMenuWatch(category: .fluidsConverters)
}
