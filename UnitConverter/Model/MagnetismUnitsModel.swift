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
    
    func convert(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        switch self {
        case .magnetomotiveForce:
            return convertMagnetomotiveForce(value, from: fromUnit, to: toUnit)
        case .magneticFieldStrength:
            return convertMagneticFieldStrength(value, from: fromUnit, to: toUnit)
        case .magneticFlux:
            return convertMagneticFlux(value, from: fromUnit, to: toUnit)
        case .magneticFluxDensity:
            return convertMagneticFluxDensity(value, from: fromUnit, to: toUnit)
        }
    }
    
    private func convertMagnetomotiveForce(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let ampereTurnValues: [String: Double] = [
            "ampere turn": 1,
            "kiloampere turn": 1e3,
            "milliampere turn": 1e-3,
            "abampere turn": 10,
            "gilbert": 0.7957747151
        ]

        guard let fromValue = ampereTurnValues[fromUnit.lowercased()], let toValue = ampereTurnValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let ampereTurns = value * fromValue
        return ampereTurns / toValue
    }
    
    private func convertMagneticFieldStrength(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let amperePerMeterValues: [String: Double] = [
            "ampere/meter": 1,
            "ampere turn/meter": 1,
            "kiloampere/meter": 1e3,
            "oersted": 79.5774715459
        ]

        guard let fromValue = amperePerMeterValues[fromUnit.lowercased()], let toValue = amperePerMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let amperePerMeter = value * fromValue
        return amperePerMeter / toValue
    }
    
    private func convertMagneticFlux(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let weberValues: [String: Double] = [
            "weber": 1,
            "milliweber": 1e-3,
            "microweber": 1e-6,
            "volt second": 1,
            "unit pole": 1.256637061436e-7,
            "megaline": 0.01,
            "kiloline": 1e-5,
            "line": 1e-8,
            "maxwell": 1e-8,
            "tesla square meter": 1,
            "tesla square centimeter": 1e-4,
            "gauss square centimeter": 1e-8,
            "Magnetic flux quantum": 2.06783461e-15
        ]

        guard let fromValue = weberValues[fromUnit.lowercased()], let toValue = weberValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let webers = value * fromValue
        return webers / toValue
    }
    
    private func convertMagneticFluxDensity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let teslaValues: [String: Double] = [
            "tesla": 1,
            "weber/square meter": 1,
            "weber/square centimeter": 1e4,
            "weber/square inch": 1550.0031000062,
            "maxwell/square meter": 1,
            "maxwell/square centimeter": 1e-4,
            "maxwell/square inch": 1.55e-5,
            "gauss": 1e-4,
            "line/square centimeter": 1e-4,
            "line/square inch": 1.55e-5,
            "gamma": 1e-9
        ]

        guard let fromValue = teslaValues[fromUnit.lowercased()], let toValue = teslaValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let teslas = value * fromValue
        return teslas / toValue
    }
    
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
    
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .magnetomotiveForce:
            return [
                ("At", "ampere turn"),
                ("kAt", "kiloampere turn"),
                ("mAt", "milliampere turn"),
                ("abAt", "abampere turn"),
                ("Gb", "gilbert")
            ]
        case .magneticFieldStrength:
            return [
                ("A/m", "ampere/meter"),
                ("At/m", "ampere turn/meter"),
                ("kA/m", "kiloampere/meter"),
                ("Oe", "oersted")
            ]
        case .magneticFlux:
            return [
                ("Wb", "weber"),
                ("mWb", "milliweber"),
                ("µWb", "microweber"),
                ("V·s", "volt second"),
                ("up", "unit pole"),
                ("MΦ", "megaline"),
                ("kΦ", "kiloline"),
                ("Φ", "line"),
                ("Mx", "maxwell"),
                ("T·m²", "tesla square meter"),
                ("T·cm²", "tesla square centimeter"),
                ("G·cm²", "gauss square centimeter"),
                ("Φ₀", "Magnetic flux quantum")
            ]
        case .magneticFluxDensity:
            return [
                ("T", "tesla"),
                ("Wb/m²", "weber/square meter"),
                ("Wb/cm²", "weber/square centimeter"),
                ("Wb/in²", "weber/square inch"),
                ("Mx/m²", "maxwell/square meter"),
                ("Mx/cm²", "maxwell/square centimeter"),
                ("Mx/in²", "maxwell/square inch"),
                ("G", "gauss"),
                ("Φ/cm²", "line/square centimeter"),
                ("Φ/in²", "line/square inch"),
                ("γ", "gamma")
            ]
        }
    }
}

