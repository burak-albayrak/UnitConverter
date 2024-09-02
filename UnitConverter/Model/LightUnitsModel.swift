//
//  LightUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation

enum LightUnitsCategory: String, CaseIterable, UnitCategory {
    case luminance = "Luminance"
    case luminousIntensity = "Luminous Intensity"
    case illumination = "Illumination"
    case digitalImageResolution = "Digital Image Resolution"
    case frequencyWavelength = "Frequency Wavelength"

    
    var icon: String {
        switch self {
        case .digitalImageResolution:
            return "scalemass"
        case .frequencyWavelength:
            return "ruler"
        case .illumination:
            return "skew"
        case .luminance:
            return "pyramid"
        case .luminousIntensity:
            return "pyramid"
        }
    }
    
    var info: String {
        switch self {
        case .digitalImageResolution:
            return "Mass is a fundamental property of matter that causes it to resist being accelerated by a force. The SI unit for mass is the kilogram (kg), which is defined in terms of the mass of the international prototype kilogram."
        case .frequencyWavelength:
            return "Length is the dimensional extent of matter. The SI unit for length is the meter (m), which is defined in terms of the distance traveled by light in a vacuum."
        case .illumination:
            return "Area is a quantity of extent in two dimensions. Area can be expressed by SI derived units in terms of square meters (m2). Area is also commonly measured in square feet (ft2) and acres (ac)."
        case .luminance:
            return "Volume is a quantity of the extent of matter in three dimensions. The SI accepted unit of volume is the liter (L), which is derived as one cubic decimeter (1 dm3). Volume is also commonly expressed in terms of cubic meters (m3), gallons (gal), and cups (cup)."
        case .luminousIntensity:
            return "Pressure is the normal force over a surface. The SI unit for pressure is the pascal (Pa), which is derived as one newton of force over one square meter (1Pa = 1N / 1m2)."
        }
    }
    
    var availableUnits: [Dimension] {
        switch self {
        case .digitalImageResolution:
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
            
        case .frequencyWavelength:
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
            
        case .illumination:
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
            
        case .luminance:
            return [UnitTemperature.celsius,
                    UnitTemperature.fahrenheit,
                    UnitTemperature.kelvin]
            
        case .luminousIntensity:
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
        }
    }
}

