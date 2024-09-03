//
//  RadiologyUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation

enum RadiollogyUnitsCategory: String, CaseIterable, UnitCategory {
    case radiation = "Radiation"
    case radiationActivity = "Radiation - Activity"
    case radiationExposure = "Radiation - Exposure"
    case radiationAbsorbedDose = "Radiation - Absorbed Dose"

    
    var icon: String {
        switch self {
        case .radiation:
            return "waveform.path"
        case .radiationAbsorbedDose:
            return "dot.radiowaves.right"
        case .radiationActivity:
            return "antenna.radiowaves.left.and.right"
        case .radiationExposure:
            return "wave.3.right"
        }
    }
    
    var info: String {
        switch self {
        case .radiation:
            return "Mass is a fundamental property of matter that causes it to resist being accelerated by a force. The SI unit for mass is the kilogram (kg), which is defined in terms of the mass of the international prototype kilogram."
        case .radiationAbsorbedDose:
            return "Length is the dimensional extent of matter. The SI unit for length is the meter (m), which is defined in terms of the distance traveled by light in a vacuum."
        case .radiationActivity:
            return "Area is a quantity of extent in two dimensions. Area can be expressed by SI derived units in terms of square meters (m2). Area is also commonly measured in square feet (ft2) and acres (ac)."
        case .radiationExposure:
            return "Volume is a quantity of the extent of matter in three dimensions. The SI accepted unit of volume is the liter (L), which is derived as one cubic decimeter (1 dm3). Volume is also commonly expressed in terms of cubic meters (m3), gallons (gal), and cups (cup)."
        }
    }
    
    var availableUnits: [Dimension] {
        switch self {
        case .radiation:
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
            
        case .radiationAbsorbedDose:
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
            
        case .radiationActivity:
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
            
        case .radiationExposure:
            return [UnitTemperature.celsius,
                    UnitTemperature.fahrenheit,
                    UnitTemperature.kelvin]
        }
    }
}

