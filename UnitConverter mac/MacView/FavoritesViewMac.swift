//
//  FavoritesViewMac.swift
//  UnitConverter mac
//
//  Created by Burak Albayrak on 28.10.2024.
//

import SwiftUI
import SwiftData

struct FavoritesViewMac: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var favorites: [FavoriteConversion]
    @State private var selectedFavorite: FavoriteConversion?
    @State private var isPressed = false
    
    var body: some View {
        NavigationSplitView {
            VStack(spacing: 0) {
                HStack {
                    Text("Favorites")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                            .font(.title2)
                    }
                    .buttonStyle(.plain)
                }
                .padding()
                .background(Color(NSColor.windowBackgroundColor))
                
                if favorites.isEmpty {
                    VStack {
                        Spacer()
                        Image(systemName: "star.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.secondary)
                        Text("No Favorites Yet")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        Text("Your favorite conversions will appear here")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                } else {
                    List(selection: $selectedFavorite) {
                        ForEach(favorites) { favorite in
                            HStack {
                                Image(systemName: getCategoryIcon(for: favorite.category))
                                    .foregroundColor(selectedFavorite == favorite ? .white : .accentColor)
                                Text("\(favorite.fromUnit) → \(favorite.toUnit)")
                            }
                            .tag(favorite)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                modelContext.delete(favorites[index])
                            }
                        }
                    }
                    .listStyle(.sidebar)
                }
            }
        } detail: {
            if let favorite = selectedFavorite {
                makeConversionView(for: favorite)
                    .id(favorite.id)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            } else {
                Text("Select a favorite conversion")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
        }
        .navigationSplitViewStyle(.balanced)
        .frame(width: 1000, height: 700)
        .animation(.smooth, value: selectedFavorite)
    }
    
    @ViewBuilder
    private func makeConversionView(for favorite: FavoriteConversion) -> some View {
        if favorite.category == CurrencyUnitsCategory.currency.rawValue {
            CurrencyConversionViewMac()
        } else if let category = CommonUnitsCategory.allCases.first(where: { $0.rawValue == favorite.category }) {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
        } else if let category = EngineeringUnitsCategory.allCases.first(where: { $0.rawValue == favorite.category }) {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
        } else if let category = HeatUnitsCategory.allCases.first(where: { $0.rawValue == favorite.category }) {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
        } else if let category = FluidsUnitsCategory.allCases.first(where: { $0.rawValue == favorite.category }) {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
        } else if let category = LightUnitsCategory.allCases.first(where: { $0.rawValue == favorite.category }) {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
        } else if let category = ElectricityUnitsCategory.allCases.first(where: { $0.rawValue == favorite.category }) {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
        } else if let category = MagnetismUnitsCategory.allCases.first(where: { $0.rawValue == favorite.category }) {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
        } else if let category = RadiollogyUnitsCategory.allCases.first(where: { $0.rawValue == favorite.category }) {
            UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
        }
    }
    
    private func getCategoryIcon(for category: String) -> String {
        if category == CurrencyUnitsCategory.currency.rawValue {
            return "dollarsign.circle"
        } else if let commonCategory = CommonUnitsCategory.allCases.first(where: { $0.rawValue == category }) {
            return commonCategory.icon
        } else if let engineeringCategory = EngineeringUnitsCategory.allCases.first(where: { $0.rawValue == category }) {
            return engineeringCategory.icon
        } else if let heatCategory = HeatUnitsCategory.allCases.first(where: { $0.rawValue == category }) {
            return heatCategory.icon
        } else if let fluidsCategory = FluidsUnitsCategory.allCases.first(where: { $0.rawValue == category }) {
            return fluidsCategory.icon
        } else if let lightCategory = LightUnitsCategory.allCases.first(where: { $0.rawValue == category }) {
            return lightCategory.icon
        } else if let electricityCategory = ElectricityUnitsCategory.allCases.first(where: { $0.rawValue == category }) {
            return electricityCategory.icon
        } else if let magnetismCategory = MagnetismUnitsCategory.allCases.first(where: { $0.rawValue == category }) {
            return magnetismCategory.icon
        } else if let radiologyCategory = RadiollogyUnitsCategory.allCases.first(where: { $0.rawValue == category }) {
            return radiologyCategory.icon
        }
        return "star"
    }
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return FavoritesViewMac()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
