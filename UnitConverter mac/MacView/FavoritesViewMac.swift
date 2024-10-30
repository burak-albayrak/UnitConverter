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
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var favorites: [FavoriteConversion] = []
    @State private var selectedFavorite: FavoriteConversion?
    @State private var showingClearConfirmation = false
    
    var body: some View {
        NavigationSplitView {
            Group {
                if favorites.isEmpty {
                    ContentUnavailableView {
                        Label("No Favorites", systemImage: "star.slash")
                    } description: {
                        Text("Add some conversions to your favorites!")
                    }
                } else {
                    List(favorites, selection: $selectedFavorite) { favorite in
                        FavoriteRowView(favorite: favorite)
                            .tag(favorite)
                            .contextMenu {
                                Button(role: .destructive) {
                                    favoritesViewModel.removeFavorite(favorite)
                                    updateFavorites()
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .navigationTitle("Favorites")
            .toolbar {
                if !favorites.isEmpty {
                    ToolbarItem {
                        Button(action: {
                            showingClearConfirmation = true
                        }) {
                            Label("Clear All", systemImage: "trash")
                        }
                    }
                }
            }
        } detail: {
            if let favorite = selectedFavorite {
                destinationView(for: favorite)
            } else {
                ContentUnavailableView {
                    Label("No Selection", systemImage: "star")
                } description: {
                    Text("Select a favorite conversion from the sidebar")
                }
            }
        }
        .alert("Clear All Favorites", isPresented: $showingClearConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                favoritesViewModel.clearAllFavorites()
                updateFavorites()
            }
        } message: {
            Text("Are you sure you want to clear all favorites? This action cannot be undone.")
        }
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
            updateFavorites()
        }
    }
    
    private func updateFavorites() {
        favorites = favoritesViewModel.getFavorites()
    }
    
    @ViewBuilder
    private func destinationView(for favorite: FavoriteConversion) -> some View {
        switch favorite.category {
            // CommonUnitsCategory
        case CommonUnitsCategory.length.rawValue,
            CommonUnitsCategory.mass.rawValue,
            CommonUnitsCategory.volume.rawValue,
            CommonUnitsCategory.temperature.rawValue,
            CommonUnitsCategory.area.rawValue,
            CommonUnitsCategory.pressure.rawValue,
            CommonUnitsCategory.angle.rawValue,
            CommonUnitsCategory.speed.rawValue,
            CommonUnitsCategory.duration.rawValue:
            if let category = CommonUnitsCategory(rawValue: favorite.category) {
                UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
            }
            
            // EngineeringUnitsCategory
        case EngineeringUnitsCategory.length.rawValue,
            EngineeringUnitsCategory.mass.rawValue,
            EngineeringUnitsCategory.volume.rawValue,
            EngineeringUnitsCategory.temperature.rawValue,
            EngineeringUnitsCategory.area.rawValue,
            EngineeringUnitsCategory.pressure.rawValue,
            EngineeringUnitsCategory.angle.rawValue,
            EngineeringUnitsCategory.speed.rawValue,
            EngineeringUnitsCategory.duration.rawValue,
            EngineeringUnitsCategory.energy.rawValue,
            EngineeringUnitsCategory.power.rawValue,
            EngineeringUnitsCategory.force.rawValue,
            EngineeringUnitsCategory.fuelConsumption.rawValue,
            EngineeringUnitsCategory.volumeDry.rawValue,
            EngineeringUnitsCategory.velocityAngular.rawValue,
            EngineeringUnitsCategory.acceleration.rawValue,
            EngineeringUnitsCategory.accelerationAngular.rawValue,
            EngineeringUnitsCategory.density.rawValue,
            EngineeringUnitsCategory.specificVolume.rawValue,
            EngineeringUnitsCategory.momentOfInertia.rawValue,
            EngineeringUnitsCategory.momentOfForce.rawValue,
            EngineeringUnitsCategory.torque.rawValue:
            if let category = EngineeringUnitsCategory(rawValue: favorite.category) {
                UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
            }
            
            // HeatUnitsCategory
        case HeatUnitsCategory.fuelEfficiencyMass.rawValue,
            HeatUnitsCategory.fuelEfficiencyVolume.rawValue,
            HeatUnitsCategory.temperatureInterval.rawValue,
            HeatUnitsCategory.thermalExpansion.rawValue,
            HeatUnitsCategory.thermalResistance.rawValue,
            HeatUnitsCategory.thermalConductivity.rawValue,
            HeatUnitsCategory.spesificHeatCapacity.rawValue,
            HeatUnitsCategory.heatDensity.rawValue,
            HeatUnitsCategory.heatFluxDensity.rawValue,
            HeatUnitsCategory.heatTransverCoefficient.rawValue:
            if let category = HeatUnitsCategory(rawValue: favorite.category) {
                UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
            }
            
            // FluidsUnitsCategory
        case FluidsUnitsCategory.flow.rawValue,
            FluidsUnitsCategory.flowMass.rawValue,
            FluidsUnitsCategory.flowMolar.rawValue,
            FluidsUnitsCategory.massFluxDensity.rawValue,
            FluidsUnitsCategory.concentrationMolar.rawValue,
            FluidsUnitsCategory.concentrationSolution.rawValue,
            FluidsUnitsCategory.viscosityDynamic.rawValue,
            FluidsUnitsCategory.viscosityKinematic.rawValue,
            FluidsUnitsCategory.surfaceTension.rawValue,
            FluidsUnitsCategory.permeability.rawValue:
            if let category = FluidsUnitsCategory(rawValue: favorite.category) {
                UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
            }
            
            // LightUnitsCategory
        case LightUnitsCategory.luminance.rawValue,
            LightUnitsCategory.luminousIntensity.rawValue,
            LightUnitsCategory.illumination.rawValue,
            LightUnitsCategory.digitalImageResolution.rawValue,
            LightUnitsCategory.frequencyWavelength.rawValue:
            if let category = LightUnitsCategory(rawValue: favorite.category) {
                UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
            }
            
            // ElectricityUnitsCategory
        case ElectricityUnitsCategory.charge.rawValue,
            ElectricityUnitsCategory.linearChargeDensity.rawValue,
            ElectricityUnitsCategory.surfaceChargeDensity.rawValue,
            ElectricityUnitsCategory.volumeChargeDensity.rawValue,
            ElectricityUnitsCategory.current.rawValue,
            ElectricityUnitsCategory.linearCurrentDensity.rawValue,
            ElectricityUnitsCategory.surfaceCurrentDensity.rawValue,
            ElectricityUnitsCategory.electricFieldStrength.rawValue,
            ElectricityUnitsCategory.electricPotential.rawValue,
            ElectricityUnitsCategory.electricResistance.rawValue,
            ElectricityUnitsCategory.electricResistivity.rawValue,
            ElectricityUnitsCategory.electricConductance.rawValue,
            ElectricityUnitsCategory.electricConductivity.rawValue,
            ElectricityUnitsCategory.electrostaticCapacitance.rawValue,
            ElectricityUnitsCategory.inductance.rawValue:
            if let category = ElectricityUnitsCategory(rawValue: favorite.category) {
                UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
            }
            
            // MagnetismUnitsCategory
        case MagnetismUnitsCategory.magnetomotiveForce.rawValue,
            MagnetismUnitsCategory.magneticFieldStrength.rawValue,
            MagnetismUnitsCategory.magneticFlux.rawValue,
            MagnetismUnitsCategory.magneticFluxDensity.rawValue:
            if let category = MagnetismUnitsCategory(rawValue: favorite.category) {
                UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
            }
            
            // RadiollogyUnitsCategory
        case RadiollogyUnitsCategory.radiation.rawValue,
            RadiollogyUnitsCategory.radiationActivity.rawValue,
            RadiollogyUnitsCategory.radiationExposure.rawValue,
            RadiollogyUnitsCategory.radiationAbsorbedDose.rawValue:
            if let category = RadiollogyUnitsCategory(rawValue: favorite.category) {
                UnitConversionViewMac(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
            }
            
            // CurrencyUnitsCategory
        case CurrencyUnitsCategory.currency.rawValue:
            CurrencyConversionViewMac()
            
        default:
            Text("Unsupported category: \(favorite.category)")
        }
    }
}

struct FavoriteRowView: View {
    let favorite: FavoriteConversion
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(getCategoryName(favorite.category))
                .font(.headline)
            HStack {
                Text(localizedString(favorite.fromUnit))
                Image(systemName: "arrow.right")
                    .foregroundColor(.secondary)
                Text(localizedString(favorite.toUnit))
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
    
    private func getCategoryName(_ category: String) -> String {
        if let commonCategory = CommonUnitsCategory(rawValue: category) {
            return localizedString(commonCategory.rawValue)
        } else if category == CurrencyUnitsCategory.currency.rawValue {
            return "Currency"
        }
        return localizedString(category)
    }
    
    private func localizedString(_ key: String) -> String {
        NSLocalizedString(key, comment: "")
    }
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return FavoritesViewMac()
            .modelContainer(container)
            .frame(width: 800, height: 500)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
