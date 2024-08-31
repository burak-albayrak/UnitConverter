//
//  UnitConverterViewModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import Foundation

final class DetailViewModel: ObservableObject {
    @Published var selectedFirstUnitIndex = 0
    @Published var selectedSecondUnitIndex = 1
    @Published var firstUnitInputValue = ""
    @Published var secondUnitInputValue = "" //FIXME: ??? second input value derken ?? is this output??
    @Published var isInfoPresented = false
    
    var category: Category
    
    var availableUnits: [Dimension] {
        return unitsForCategory(category: category)
    }
    
    init(category: Category) {
        self.category = category
    }
    
    func convertUnits<T: Dimension>(value: String, unit1: T, unit2: T) -> Double {
        guard let numericValue = Double(value) else {
            return 0.0
        }
        return Measurement(value: numericValue, unit: unit1).converted(to: unit2).value
    }
    
    func unitsForCategory(category: Category) -> [Dimension] {
        switch category {
        case .area:
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
            
        case .length:
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
            
        case .pressure:
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
            
        case .temperature:
            return [UnitTemperature.celsius, 
                    UnitTemperature.fahrenheit,
                    UnitTemperature.kelvin]
            
        case .volume:
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
            
        case .mass:
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
            
        case .angle:
            return [
                UnitAngle.degrees, 
                UnitAngle.arcMinutes,
                UnitAngle.arcSeconds,
                UnitAngle.radians,
                UnitAngle.gradians,
                UnitAngle.revolutions
            ]
            
        case .speed:
            return [
                UnitSpeed.metersPerSecond, 
                UnitSpeed.kilometersPerHour,
                UnitSpeed.milesPerHour,
                UnitSpeed.knots
            ]
            
        case .duration:
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
