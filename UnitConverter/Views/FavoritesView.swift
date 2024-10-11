import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var favorites: [FavoriteConversion] = []
    
    var body: some View {
        Group {
            if favorites.isEmpty {
                VStack {
                    Text("No Favorites Yet")
                        .font(.title)
                        .foregroundColor(.secondary)
                        .padding(.vertical)
                    Text("Add some conversions to your favorites!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(favorites) { favorite in
                        NavigationLink(destination: destinationView(for: favorite)) {
                            VStack(alignment: .leading) {
                                Text(favorite.category)
                                    .font(.headline)
                                Text("\(favorite.fromUnit) to \(favorite.toUnit)")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .onDelete(perform: deleteFavorites)
                }
            }
        }
        .navigationTitle("Favorites")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
            updateFavorites()
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
    
    private func deleteFavorites(at offsets: IndexSet) {
        for index in offsets {
            let favorite = favorites[index]
            favoritesViewModel.removeFavorite(favorite)
        }
        updateFavorites()
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
                UnitConversionView(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
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
                UnitConversionView(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
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
                UnitConversionView(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
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
                UnitConversionView(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
            }
            
            // LightUnitsCategory
        case LightUnitsCategory.luminance.rawValue,
            LightUnitsCategory.luminousIntensity.rawValue,
            LightUnitsCategory.illumination.rawValue,
            LightUnitsCategory.digitalImageResolution.rawValue,
            LightUnitsCategory.frequencyWavelength.rawValue:
            if let category = LightUnitsCategory(rawValue: favorite.category) {
                UnitConversionView(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
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
                UnitConversionView(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
            }
            
            // MagnetismUnitsCategory
        case MagnetismUnitsCategory.magnetomotiveForce.rawValue,
            MagnetismUnitsCategory.magneticFieldStrength.rawValue,
            MagnetismUnitsCategory.magneticFlux.rawValue,
            MagnetismUnitsCategory.magneticFluxDensity.rawValue:
            if let category = MagnetismUnitsCategory(rawValue: favorite.category) {
                UnitConversionView(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
            }
            
            // RadiollogyUnitsCategory
        case RadiollogyUnitsCategory.radiation.rawValue,
            RadiollogyUnitsCategory.radiationActivity.rawValue,
            RadiollogyUnitsCategory.radiationExposure.rawValue,
            RadiollogyUnitsCategory.radiationAbsorbedDose.rawValue:
            if let category = RadiollogyUnitsCategory(rawValue: favorite.category) {
                UnitConversionView(viewModel: UnitConversionViewModel(category: category), favorite: favorite)
            }
            
            // CurrencyUnitsCategory
        case CurrencyUnitsCategory.currency.rawValue:
            CurrencyConversionView()
            
        default:
            Text("Unsupported category: \(favorite.category)")
        }
    }
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return NavigationView {
            FavoritesView()
        }
        .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
