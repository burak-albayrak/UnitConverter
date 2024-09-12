//
//  MagnetismUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation
import SwiftUI

enum MagnetismUnitsCategory: String, CaseIterable, UnitCategory {
    case magnetomotiveForce = "Magnetomotive Force"
    case magneticFieldStrength = "Magnetic Field Strength"
    case magneticFlux = "Magnetic Flux"
    case magneticFluxDensity = "Magnetic Flux Density"
    
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
    
    func convert(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
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
    
    private func convertMagnetomotiveForce(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let ampereTurnValues: [String: Decimal] = [
            "ampere turn": 1,
            "kiloampere turn": Decimal(sign: .plus, exponent: 3, significand: 1),
            "milliampere turn": Decimal(sign: .minus, exponent: 3, significand: 1),
            "abampere turn": 10,
            "gilbert": Decimal(string: "0.7957747151")!
        ]

        guard let fromValue = ampereTurnValues[fromUnit.lowercased()], let toValue = ampereTurnValues[toUnit.lowercased()] else {
            return value 
        }

        let ampereTurns = value * fromValue
        return ampereTurns / toValue
    }
    
    private func convertMagneticFieldStrength(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let amperePerMeterValues: [String: Decimal] = [
            "ampere/meter": 1,
            "ampere turn/meter": 1,
            "kiloampere/meter": Decimal(sign: .plus, exponent: 3, significand: 1),
            "oersted": Decimal(string: "79.5774715459")!
        ]

        guard let fromValue = amperePerMeterValues[fromUnit.lowercased()], let toValue = amperePerMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let amperePerMeter = value * fromValue
        return amperePerMeter / toValue
    }
    
    private func convertMagneticFlux(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let weberValues: [String: Decimal] = [
            "weber": 1,
            "milliweber": Decimal(sign: .minus, exponent: 3, significand: 1),
            "microweber": Decimal(sign: .minus, exponent: 6, significand: 1),
            "volt second": 1,
            "unit pole": Decimal(string: "1.256637061436e-7")!,
            "megaline": Decimal(string: "0.01")!,
            "kiloline": Decimal(sign: .minus, exponent: 5, significand: 1),
            "line": Decimal(sign: .minus, exponent: 8, significand: 1),
            "maxwell": Decimal(sign: .minus, exponent: 8, significand: 1),
            "tesla square meter": 1,
            "tesla square centimeter": Decimal(sign: .minus, exponent: 4, significand: 1),
            "gauss square centimeter": Decimal(sign: .minus, exponent: 8, significand: 1),
            "Magnetic flux quantum": Decimal(string: "2.06783461e-15")!
        ]

        guard let fromValue = weberValues[fromUnit.lowercased()], let toValue = weberValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let webers = value * fromValue
        return webers / toValue
    }
    
    private func convertMagneticFluxDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let teslaValues: [String: Decimal] = [
            "tesla": 1,
            "weber/square meter": 1,
            "weber/square centimeter": Decimal(sign: .plus, exponent: 4, significand: 1),
            "weber/square inch": Decimal(string: "1550.0031000062")!,
            "maxwell/square meter": 1,
            "maxwell/square centimeter": Decimal(sign: .minus, exponent: 4, significand: 1),
            "maxwell/square inch": Decimal(string: "1.55e-5")!,
            "gauss": Decimal(sign: .minus, exponent: 4, significand: 1),
            "line/square centimeter": Decimal(sign: .minus, exponent: 4, significand: 1),
            "line/square inch": Decimal(string: "1.55e-5")!,
            "gamma": Decimal(sign: .minus, exponent: 9, significand: 1)
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
    
    var info: LocalizedStringKey {
        switch self {
        case .magneticFieldStrength:
            return "MagneticFieldStrengthInfo"
        case .magneticFlux:
            return "MagneticFluxInfo"
        case .magneticFluxDensity:
            return "MagneticFluxDensityInfo"
        case .magnetomotiveForce:
            return "MagnetomotiveForceInfo"
        }
    }
    
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .magnetomotiveForce:
            return [
                ("At", String(localized: "ampere turn")),
                ("kAt", String(localized: "kiloampere turn")),
                ("mAt", String(localized: "milliampere turn")),
                ("abAt", String(localized: "abampere turn")),
                ("Gb", String(localized: "gilbert"))
            ]
        case .magneticFieldStrength:
            return [
                ("A/m", String(localized: "ampere/meter")),
                ("At/m", String(localized: "ampere turn/meter")),
                ("kA/m", String(localized: "kiloampere/meter")),
                ("Oe", String(localized: "oersted"))
            ]
        case .magneticFlux:
            return [
                ("Wb", String(localized: "weber")),
                ("mWb", String(localized: "milliweber")),
                ("µWb", String(localized: "microweber")),
                ("V·s", String(localized: "volt second")),
                ("up", String(localized: "unit pole")),
                ("MΦ", String(localized: "megaline")),
                ("kΦ", String(localized: "kiloline")),
                ("Φ", String(localized: "line")),
                ("Mx", String(localized: "maxwell")),
                ("T·m²", String(localized: "tesla square meter")),
                ("T·cm²", String(localized: "tesla square centimeter")),
                ("G·cm²", String(localized: "gauss square centimeter")),
                ("Φ₀", String(localized: "Magnetic flux quantum"))
            ]
        case .magneticFluxDensity:
            return [
                ("T", String(localized: "tesla")),
                ("Wb/m²", String(localized: "weber/square meter")),
                ("Wb/cm²", String(localized: "weber/square centimeter")),
                ("Wb/in²", String(localized: "weber/square inch")),
                ("Mx/m²", String(localized: "maxwell/square meter")),
                ("Mx/cm²", String(localized: "maxwell/square centimeter")),
                ("Mx/in²", String(localized: "maxwell/square inch")),
                ("G", String(localized: "gauss")),
                ("Φ/cm²", String(localized: "line/square centimeter")),
                ("Φ/in²", String(localized: "line/square inch")),
                ("γ", String(localized: "gamma"))
            ]
        }
    }
}

