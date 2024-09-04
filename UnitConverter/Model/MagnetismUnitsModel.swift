//
//  MagnetismUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation

enum MagnetismUnitsCategory: String, CaseIterable, UnitCategory {
    case magnetomotiveForce = "Magnetomotive Force"
    case magneticFieldStrength = "Magnetic Field Strength"
    case magneticFlux = "Magnetic Flux"
    case magneticFluxDensity = "Magnetic Flux Density"
    
    var icon: String {
        switch self {
        case .magneticFieldStrength:
            return "waveform.circle"
        case .magneticFlux:
            return "circle.grid.cross"
        case .magneticFluxDensity:
            return "dot.circle.and.hand.point.up.left.fill"
        case .magnetomotiveForce:
            return "bolt.square"
        }
    }
    
    var info: String {
        switch self {
        case .magneticFieldStrength:
            return """
                Magnetic field strength, also known as magnetic field intensity, measures the force that a magnetic field exerts on moving electric charges and magnetic materials. It indicates the intensity of the magnetic field in a specific area.
                
                The SI unit for magnetic field strength is the ampere per meter (A/m). This property is crucial in understanding and designing magnetic systems, such as electromagnets, transformers, and electric motors.
                
                Magnetic field strength plays a vital role in various applications, including MRI machines in medical diagnostics, where strong magnetic fields are used to produce detailed images of the human body.
                
                Accurate measurement of magnetic field strength is essential for ensuring the proper functioning and safety of devices that rely on magnetic fields.
                """
        case .magneticFlux:
            return """
                Magnetic flux quantifies the total magnetic field passing through a given area. It measures the strength and extent of a magnetic field over a surface, providing a key understanding of how magnetic fields interact with materials.
                
                The SI unit for magnetic flux is the weber (Wb), where one weber equals one tesla meter squared (T·m²). For example, in an electrical generator, the magnetic flux through the coils influences the amount of electrical current generated.
                
                Magnetic flux is fundamental in electromagnetism, affecting the operation of transformers, inductors, and motors.
                
                Accurate measurement of magnetic flux is essential for designing and optimizing devices that rely on magnetic fields to function efficiently.
                """
        case .magneticFluxDensity:
            return """
                Magnetic flux density, also known as the magnetic field density or simply the magnetic field, measures the strength and direction of a magnetic field in a given area. It represents the amount of magnetic flux passing through a unit area perpendicular to the magnetic field.
                
                The SI unit for magnetic flux density is the tesla (T), where one tesla equals one weber per square meter (Wb/m²). For example, the Earth's magnetic field has a flux density of about 25 to 65 microteslas (µT).
                
                Magnetic flux density is crucial in various applications, including designing electric motors, transformers, and magnetic resonance imaging (MRI) machines.
                
                Accurate measurement of flux density is essential for optimizing performance and ensuring safety in devices that utilize magnetic fields.
                """
        case .magnetomotiveForce:
            return """
                Magnetomotive force (MMF) is a measure of the magnetic potential that drives the magnetic flux through a magnetic circuit. It represents the force required to produce a magnetic field and is analogous to electromotive force (EMF) in electrical circuits.
                
                The SI unit for magnetomotive force is the ampere-turn (At), which quantifies the product of the current in amperes and the number of turns in a coil generating the magnetic field. For example, a coil with 10 turns carrying a current of 2 amperes produces an MMF of 20 ampere-turns.
                
                MMF is essential in understanding the behavior of magnetic circuits and designing electromagnetic devices such as transformers, inductors, and magnetic relays.
                
                Accurate measurement of MMF helps in optimizing the efficiency and performance of magnetic systems.
                """
        }
    }
    
    var availableUnits: [Dimension] {
        switch self {
        case .magneticFieldStrength:
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
            
        case .magneticFlux:
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
            
        case .magneticFluxDensity:
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
            
        case .magnetomotiveForce:
            return [UnitTemperature.celsius,
                    UnitTemperature.fahrenheit,
                    UnitTemperature.kelvin]
        }
    }
    
    var availableUnitNames: [String] {
        switch self {
        case .magneticFieldStrength:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .magneticFlux:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .magneticFluxDensity:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .magnetomotiveForce:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        }
    }
}

