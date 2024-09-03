//
//  FluidsUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation

enum FluidsUnitsCategory: String, CaseIterable, UnitCategory {
    case flow = "Flow"
    case flowMass = "Flow - Mass"
    case flowMolar = "Flow Molar"
    case massFluxDensity = "Mass Flux Density"
    case concentrationMolar = "Concentration - Molar"
    case concentrationSolution = "Concentration Solution"
    case viscosityDynamic = "Viscosity - Dynamic"
    case viscosityKinematic = "Viscosity - Kinematic"
    case surfaceTension = "Surface Tension"
    case permeability = "Permeability"

    
    var icon: String {
        switch self {
        case .concentrationMolar:
            return "circle.grid.cross"
        case .concentrationSolution:
            return "drop"
        case .flow:
            return "arrow.right.to.line"
        case .flowMass:
            return "scalemass"
        case .flowMolar:
            return "wave.3.forward"
        case .massFluxDensity:
            return "chart.bar"
        case .permeability:
            return "square.stack.3d.forward.dottedline"
        case .surfaceTension:
            return "drop.triangle"
        case .viscosityDynamic:
            return "waveform.path.ecg"
        case .viscosityKinematic:
            return "waveform.path.ecg.rectangle"
        }
    }
    
    var info: String {
        switch self {
        case .concentrationMolar:
            return "Mass is a fundamental property of matter that causes it to resist being accelerated by a force. The SI unit for mass is the kilogram (kg), which is defined in terms of the mass of the international prototype kilogram."
        case .concentrationSolution:
            return "Length is the dimensional extent of matter. The SI unit for length is the meter (m), which is defined in terms of the distance traveled by light in a vacuum."
        case .flow:
            return "Area is a quantity of extent in two dimensions. Area can be expressed by SI derived units in terms of square meters (m2). Area is also commonly measured in square feet (ft2) and acres (ac)."
        case .flowMass:
            return "Volume is a quantity of the extent of matter in three dimensions. The SI accepted unit of volume is the liter (L), which is derived as one cubic decimeter (1 dm3). Volume is also commonly expressed in terms of cubic meters (m3), gallons (gal), and cups (cup)."
        case .flowMolar:
            return "Pressure is the normal force over a surface. The SI unit for pressure is the pascal (Pa), which is derived as one newton of force over one square meter (1Pa = 1N / 1m2)."
        case .massFluxDensity:
            return "Temperature is a comparative measure of thermal energy. The SI unit for temperature is the kelvin (K), which is defined in terms of the triple point of water. Temperature is also commonly measured by degrees of various scales, including Celsius (°C) and Fahrenheit (°F)."
        case .permeability:
            return "Angle is a quantity of rotation. The SI unit for angle is the radian (rad), which is dimensionless and defined to be the angle subtended by an arc that is equal in length to the radius of a circle. Angle is also commonly expressed in terms of degrees (°) and revolutions (rev)."
        case .surfaceTension:
            return "Speed is the magnitude of velocity, or the rate of change of position. Speed can be expressed by SI derived units in terms of meters per second (m/s), and is also commonly expressed in terms of kilometers per hour (km/h) and miles per hour (mph)."
        case .viscosityDynamic:
            return "Duration is a quantity of time. The SI unit for time is the second (sec), which is defined in terms of the radioactivity of a cesium-133 atom. Duration is also commonly expressed in terms of minutes (min) and hours (hr)."
        case .viscosityKinematic:
            return "Duration is a quantity of time. The SI unit for time is the second (sec), which is defined in terms of the radioactivity of a cesium-133 atom. Duration is also commonly expressed in terms of minutes (min) and hours (hr)."
        }
    }
    
    var availableUnits: [Dimension] {
        switch self {
        case .concentrationMolar:
            return [
                UnitArea.squareMegameters,
                UnitArea.squareKilometers,
                UnitArea.squareMeters,
                UnitArea.squareCentimeters,
                UnitArea.squareMillimeters,
                UnitArea.squareNanometers,
                UnitArea.squareInches,
                UnitArea.squareFeet,
                UnitArea.squareYards,
                UnitArea.squareMiles,
                UnitArea.acres,
                UnitArea.ares,
                UnitArea.hectares
            ]
            
        case .concentrationSolution:
            return [
                UnitLength.megameters,
                UnitLength.kilometers,
                UnitLength.hectometers,
                UnitLength.decameters,
                UnitLength.meters,
                UnitLength.decimeters,
                UnitLength.centimeters,
                UnitLength.millimeters,
                UnitLength.micrometers,
                UnitLength.nanometers,
                UnitLength.picometers,
                UnitLength.inches,
                UnitLength.feet,
                UnitLength.yards,
                UnitLength.miles,
                UnitLength.scandinavianMiles,
                UnitLength.lightyears,
                UnitLength.nauticalMiles,
                UnitLength.fathoms,
                UnitLength.astronomicalUnits,
                UnitLength.parsecs
            ]
            
        case .flow:
            return [
                UnitPressure.newtonsPerMetersSquared,
                UnitPressure.gigapascals,
                UnitPressure.megapascals,
                UnitPressure.kilopascals,
                UnitPressure.hectopascals,
                UnitPressure.inchesOfMercury,
                UnitPressure.bars,
                UnitPressure.millibars,
                UnitPressure.millimetersOfMercury,
                UnitPressure.poundsForcePerSquareInch
            ]
            
        case .flowMass:
            return [UnitTemperature.celsius,
                    UnitTemperature.fahrenheit,
                    UnitTemperature.kelvin]
            
        case .flowMolar:
            return [
                UnitVolume.megaliters,
                UnitVolume.kiloliters,
                UnitVolume.liters,
                UnitVolume.deciliters,
                UnitVolume.centiliters,
                UnitVolume.milliliters,
                UnitVolume.cubicKilometers,
                UnitVolume.cubicMeters,
                UnitVolume.cubicDecimeters,
                UnitVolume.cubicCentimeters,
                UnitVolume.cubicMillimeters,
                UnitVolume.cubicInches,
                UnitVolume.cubicFeet,
                UnitVolume.cubicYards,
                UnitVolume.cubicMiles,
                UnitVolume.acreFeet,
                UnitVolume.bushels,
                UnitVolume.teaspoons,
                UnitVolume.tablespoons,
                UnitVolume.fluidOunces,
                UnitVolume.cups,
                UnitVolume.pints,
                UnitVolume.quarts,
                UnitVolume.gallons,
                UnitVolume.imperialTeaspoons,
                UnitVolume.imperialTablespoons,
                UnitVolume.imperialFluidOunces,
                UnitVolume.imperialPints,
                UnitVolume.imperialQuarts,
                UnitVolume.imperialGallons,
                UnitVolume.metricCups
            ]
            
        case .massFluxDensity:
            return [
                UnitMass.kilograms,
                UnitMass.grams,
                UnitMass.decigrams,
                UnitMass.centigrams,
                UnitMass.milligrams,
                UnitMass.micrograms,
                UnitMass.nanograms,
                UnitMass.picograms,
                UnitMass.ounces,
                UnitMass.pounds,
                UnitMass.stones,
                UnitMass.metricTons,
                UnitMass.shortTons,
                UnitMass.carats,
                UnitMass.ouncesTroy,
                UnitMass.slugs
            ]
            
        case .permeability:
            return [
                UnitAngle.degrees,
                UnitAngle.arcMinutes,
                UnitAngle.arcSeconds,
                UnitAngle.radians,
                UnitAngle.gradians,
                UnitAngle.revolutions
            ]
            
        case .surfaceTension:
            return [
                UnitSpeed.metersPerSecond,
                UnitSpeed.kilometersPerHour,
                UnitSpeed.milesPerHour,
                UnitSpeed.knots
            ]
            
        case .viscosityDynamic:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
            
        case .viscosityKinematic:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
        }
    }
}
