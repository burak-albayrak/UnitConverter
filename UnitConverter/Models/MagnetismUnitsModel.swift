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
            "At": 1,
            "kAt": Decimal(sign: .plus, exponent: 3, significand: 1),
            "mAt": Decimal(sign: .plus, exponent: -3, significand: 1),
            "abAt": 10,
            "Gb": Decimal(string: "0.7957747151")!
        ]

        guard let fromValue = ampereTurnValues[fromUnit], let toValue = ampereTurnValues[toUnit] else {
            return value 
        }

        let ampereTurns = value * fromValue
        return ampereTurns / toValue
    }
    
    private func convertMagneticFieldStrength(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let amperePerMeterValues: [String: Decimal] = [
            "A/m": 1,
            "At/m": 1,
            "kA/m": Decimal(sign: .plus, exponent: 3, significand: 1),
            "Oe": Decimal(string: "79.5774715459")!
        ]

        guard let fromValue = amperePerMeterValues[fromUnit], let toValue = amperePerMeterValues[toUnit] else {
            return value
        }

        let amperePerMeter = value * fromValue
        return amperePerMeter / toValue
    }
    
    private func convertMagneticFlux(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let weberValues: [String: Decimal] = [
            "Wb": 1,
            "mWb": Decimal(sign: .plus, exponent: -3, significand: 1),
            "µWb": Decimal(sign: .plus, exponent: -6, significand: 1),
            "V·s": 1,
            "up": Decimal(string: "1.256637061436e-7")!,
            "MΦ": Decimal(string: "0.01")!,
            "kΦ": Decimal(sign: .plus, exponent: -5, significand: 1),
            "Φ": Decimal(sign: .plus, exponent: -8, significand: 1),
            "Mx": Decimal(sign: .plus, exponent: -8, significand: 1),
            "T·m²": 1,
            "T·cm²": Decimal(sign: .plus, exponent: -4, significand: 1),
            "G·cm²": Decimal(sign: .plus, exponent: -8, significand: 1),
            "Φ₀": Decimal(string: "2.06783461e-15")!
        ]

        guard let fromValue = weberValues[fromUnit], let toValue = weberValues[toUnit] else {
            return value
        }

        let webers = value * fromValue
        return webers / toValue
    }
    
    private func convertMagneticFluxDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let teslaValues: [String: Decimal] = [
            "T": 1,
            "Wb/m²": 1,
            "Wb/cm²": Decimal(sign: .plus, exponent: 4, significand: 1),
            "Wb/in²": Decimal(string: "1550.0031000062")!,
            "Mx/m²": 1,
            "Mx/cm²": Decimal(sign: .plus, exponent: -4, significand: 1),
            "Mx/in²": Decimal(string: "1.55e-5")!,
            "G": Decimal(sign: .plus, exponent: -4, significand: 1),
            "Φ/cm²": Decimal(sign: .plus, exponent: -4, significand: 1),
            "Φ/in²": Decimal(string: "1.55e-5")!,
            "γ": Decimal(sign: .plus, exponent: -9, significand: 1)
        ]

        guard let fromValue = teslaValues[fromUnit], let toValue = teslaValues[toUnit] else {
            return value
        }

        let teslas = value * fromValue
        return teslas / toValue
    }
    
    var icon: String {
        switch self {
        case .magneticFieldStrength:
            return "bolt.shield"
        case .magneticFlux:
            return "bolt.brakesignal"
        case .magneticFluxDensity:
            return "bolt.horizontal"
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

