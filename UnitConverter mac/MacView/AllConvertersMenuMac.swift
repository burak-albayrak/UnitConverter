//
//  AllConvertersMenuMac.swift
//  UnitConverter mac
//
//  Created by Burak Albayrak on 28.10.2024.
//

import SwiftUI

struct AllConvertersMenuMac: View {
    let category: AllConvertersCategory
    @State private var selectedUnitCategory: (any UnitCategory)?
    
    var body: some View {
        if let selectedCategory = selectedUnitCategory {
            makeUnitConversionView(for: selectedCategory)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
        } else {
            List {
                ForEach(category.unitCategory, id: \.rawValue) { unitCategory in
                    Button {
                        withAnimation(.smooth) {
                            selectedUnitCategory = unitCategory
                        }
                    } label: {
                        Label(unitCategory.localizedName, systemImage: unitCategory.icon)
                            .foregroundColor(.accentColor)
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle(category.localizedName)
            .transition(.asymmetric(
                insertion: .move(edge: .leading).combined(with: .opacity),
                removal: .move(edge: .trailing).combined(with: .opacity)
            ))
        }
    }
    
    @ViewBuilder
    private func makeUnitConversionView(for unitCategory: any UnitCategory) -> some View {
        VStack {
            HStack {
                Button {
                    withAnimation(.smooth) {
                        selectedUnitCategory = nil
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.accentColor)
                        Text(category.localizedName)
                            .buttonStyle(TransparentButtonStyle())
                            .foregroundColor(.accentColor)
                    }
                }
                .buttonStyle(.bordered)
                Spacer()
            }
            .padding(.horizontal)
            
            Group {
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
    }
}

#Preview {
    NavigationView {
        AllConvertersMenuMac(category: .fluidsConverters)
    }
}
