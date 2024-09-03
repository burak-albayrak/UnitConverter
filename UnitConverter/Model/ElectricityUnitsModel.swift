//
//  ElectricityUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation

enum ElectricityUnitsCategory: String, CaseIterable, UnitCategory {
    case charge = "Charge"
    case linearChargeDensity = "Linear Charge Density"
    case surfaceChargeDensity = "Surface Charge Density"
    case volumeChargeDensity = "Volume Charge Density"
    case current = "Current"
    case linearCurrentDensity = "Linear Current Density"
    case surfaceCurrentDensity = "Surface Current Density"
    case electricFieldStrength = "Electric Field Strength"
    case electricPotential = "Electric Potential"
    case electricResistance = "Electric Resistance"
    case electricResistivity = "Electric Resistivity"
    case electricConductance = "Electric Conductance"
    case electricConductivity = "Electric Conductivity"
    case electrostaticCapacitance = "Electrostatic Capacitance"
    case inductance = "Inductance"
    
    var icon: String {
        switch self {
        case .charge:
            return "bolt.circle"
        case .current:
            return "wave.3.forward"
        case .electricConductance:
            return "dot.radiowaves.right"
        case .electricConductivity:
            return "antenna.radiowaves.left.and.right"
        case .electricFieldStrength:
            return "waveform.path.ecg"
        case .electricPotential:
            return "bolt"
        case .electricResistance:
            return "bolt.horizontal"
        case .electricResistivity:
            return "waveform.path.badge.minus"
        case .electrostaticCapacitance:
            return "capsule.portrait"
        case .inductance:
            return "waveform.path.badge.plus"
        case .linearChargeDensity:
            return "ruler"
        case .linearCurrentDensity:
            return "cable.connector.horizontal"
        case .surfaceChargeDensity:
            return "rectangle.grid.2x2"
        case .surfaceCurrentDensity:
            return "rectangle.grid.3x2"
        case .volumeChargeDensity:
            return "cube.box"
        }
    }
    
    var info: String {
        switch self {
        case .charge:
            return "Mass is a fundamental property of matter that causes it to resist being accelerated by a force. The SI unit for mass is the kilogram (kg), which is defined in terms of the mass of the international prototype kilogram."
        case .current:
            return "Mass is a fundamental property of matter that causes it to resist being accelerated by a force. The SI unit for mass is the kilogram (kg), which is defined in terms of the mass of the international prototype kilogram."
        case .electricConductance:
            return "Length is the dimensional extent of matter. The SI unit for length is the meter (m), which is defined in terms of the distance traveled by light in a vacuum."
        case .electricConductivity:
            return "Area is a quantity of extent in two dimensions. Area can be expressed by SI derived units in terms of square meters (m2). Area is also commonly measured in square feet (ft2) and acres (ac)."
        case .electricFieldStrength:
            return "Volume is a quantity of the extent of matter in three dimensions. The SI accepted unit of volume is the liter (L), which is derived as one cubic decimeter (1 dm3). Volume is also commonly expressed in terms of cubic meters (m3), gallons (gal), and cups (cup)."
        case .electricPotential:
            return "Pressure is the normal force over a surface. The SI unit for pressure is the pascal (Pa), which is derived as one newton of force over one square meter (1Pa = 1N / 1m2)."
        case .electricResistance:
            return "Temperature is a comparative measure of thermal energy. The SI unit for temperature is the kelvin (K), which is defined in terms of the triple point of water. Temperature is also commonly measured by degrees of various scales, including Celsius (°C) and Fahrenheit (°F)."
        case .electricResistivity:
            return "Angle is a quantity of rotation. The SI unit for angle is the radian (rad), which is dimensionless and defined to be the angle subtended by an arc that is equal in length to the radius of a circle. Angle is also commonly expressed in terms of degrees (°) and revolutions (rev)."
        case .electrostaticCapacitance:
            return "Speed is the magnitude of velocity, or the rate of change of position. Speed can be expressed by SI derived units in terms of meters per second (m/s), and is also commonly expressed in terms of kilometers per hour (km/h) and miles per hour (mph)."
        case .inductance:
            return "Duration is a quantity of time. The SI unit for time is the second (sec), which is defined in terms of the radioactivity of a cesium-133 atom. Duration is also commonly expressed in terms of minutes (min) and hours (hr)."
        case .linearChargeDensity:
            return "Duration is a quantity of time. The SI unit for time is the second (sec), which is defined in terms of the radioactivity of a cesium-133 atom. Duration is also commonly expressed in terms of minutes (min) and hours (hr)."
        case .linearCurrentDensity:
            return "Duration is a quantity of time. The SI unit for time is the second (sec), which is defined in terms of the radioactivity of a cesium-133 atom. Duration is also commonly expressed in terms of minutes (min) and hours (hr)."
        case .surfaceChargeDensity:
            return "Duration is a quantity of time. The SI unit for time is the second (sec), which is defined in terms of the radioactivity of a cesium-133 atom. Duration is also commonly expressed in terms of minutes (min) and hours (hr)."
        case .surfaceCurrentDensity:
            return "Duration is a quantity of time. The SI unit for time is the second (sec), which is defined in terms of the radioactivity of a cesium-133 atom. Duration is also commonly expressed in terms of minutes (min) and hours (hr)."
        case .volumeChargeDensity:
            return "Duration is a quantity of time. The SI unit for time is the second (sec), which is defined in terms of the radioactivity of a cesium-133 atom. Duration is also commonly expressed in terms of minutes (min) and hours (hr)."
        }
    }
    
    var availableUnits: [Dimension] {
        switch self {
        case .charge:
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
        case .current:
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
        case .electricConductance:
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
            
        case .electricConductivity:
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
            
        case .electricFieldStrength:
            return [UnitTemperature.celsius,
                    UnitTemperature.fahrenheit,
                    UnitTemperature.kelvin]
            
        case .electricPotential:
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
            
        case .electricResistance:
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
            
        case .electricResistivity:
            return [
                UnitAngle.degrees,
                UnitAngle.arcMinutes,
                UnitAngle.arcSeconds,
                UnitAngle.radians,
                UnitAngle.gradians,
                UnitAngle.revolutions
            ]
            
        case .electrostaticCapacitance:
            return [
                UnitSpeed.metersPerSecond,
                UnitSpeed.kilometersPerHour,
                UnitSpeed.milesPerHour,
                UnitSpeed.knots
            ]
            
        case .inductance:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
            
        case .linearChargeDensity:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
        case .linearCurrentDensity:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
        case .surfaceChargeDensity:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
        case .surfaceCurrentDensity:
            return [
                UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds,
                UnitDuration.milliseconds,
                UnitDuration.microseconds,
                UnitDuration.nanoseconds,
                UnitDuration.picoseconds
            ]
        case .volumeChargeDensity:
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
