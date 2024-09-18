//
//  RadiologyUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation
import SwiftUI

enum RadiollogyUnitsCategory: String, CaseIterable, UnitCategory {
    case radiation = "Radiation"
    case radiationActivity = "Radiation - Activity"
    case radiationExposure = "Radiation - Exposure"
    case radiationAbsorbedDose = "Radiation - Absorbed Dose"
    
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
    
    func convert(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        switch self {
        case .radiation:
            return convertRadiation(value, from: fromUnit, to: toUnit)
        case .radiationActivity:
            return convertRadiationActivity(value, from: fromUnit, to: toUnit)
        case .radiationExposure:
            return convertRadiationExposure(value, from: fromUnit, to: toUnit)
        case .radiationAbsorbedDose:
            return convertRadiationAbsorbedDose(value, from: fromUnit, to: toUnit)
        }
    }
    
    private func convertRadiation(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let grayPerSecondValues: [String: Decimal] = [
            "Gy/s": 1,
            "EGy/s": Decimal(sign: .plus, exponent: 18, significand: 1),
            "PGy/s": Decimal(sign: .plus, exponent: 15, significand: 1),
            "TGy/s": Decimal(sign: .plus, exponent: 12, significand: 1),
            "GGy/s": Decimal(sign: .plus, exponent: 9, significand: 1),
            "MGy/s": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kGy/s": Decimal(sign: .plus, exponent: 3, significand: 1),
            "hGy/s": Decimal(sign: .plus, exponent: 2, significand: 1),
            "daGy/s": Decimal(sign: .plus, exponent: 1, significand: 1),
            "dGy/s": Decimal(sign: .plus, exponent: -1, significand: 1),
            "cGy/s": Decimal(sign: .plus, exponent: -2, significand: 1),
            "mGy/s": Decimal(sign: .plus, exponent: -3, significand: 1),
            "µGy/s": Decimal(sign: .plus, exponent: -6, significand: 1),
            "nGy/s": Decimal(sign: .plus, exponent: -9, significand: 1),
            "pGy/s": Decimal(sign: .plus, exponent: -12, significand: 1),
            "fGy/s": Decimal(sign: .plus, exponent: -15, significand: 1),
            "aGy/s": Decimal(sign: .plus, exponent: -18, significand: 1),
            "rad/s": Decimal(sign: .plus, exponent: -2, significand: 1),
            "J/kg/s": 1,
            "W/kg": 1,
            "Sv/s": 1,
            "rem/s": Decimal(sign: .plus, exponent: -2, significand: 1)
        ]
        
        guard let fromValue = grayPerSecondValues[fromUnit], let toValue = grayPerSecondValues[toUnit] else {
            return value
        }
        
        let grayPerSecond = value * fromValue
        return grayPerSecond / toValue
    }
    
    private func convertRadiationActivity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let becquerelValues: [String: Decimal] = [
            "Bq": 1,
            "TBq": Decimal(sign: .plus, exponent: 12, significand: 1),
            "GBq": Decimal(sign: .plus, exponent: 9, significand: 1),
            "MBq": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kBq": Decimal(sign: .plus, exponent: 3, significand: 1),
            "mBq": Decimal(sign: .plus, exponent: -3, significand: 1),
            "Ci": Decimal(string: "3.7e10")!,
            "kCi": Decimal(string: "3.7e13")!,
            "mCi": Decimal(string: "3.7e7")!,
            "µCi": Decimal(string: "3.7e4")!,
            "nCi": 37,
            "pCi": Decimal(string: "0.037")!,
            "Rd": Decimal(sign: .plus, exponent: 6, significand: 1),
            "s⁻¹": 1,
            "dis/s": 1,
            "dis/min": Decimal(1) / Decimal(60)
        ]
        
        guard let fromValue = becquerelValues[fromUnit], let toValue = becquerelValues[toUnit] else {
            return value
        }
        
        let becquerels = value * fromValue
        return becquerels / toValue
    }
    
    private func convertRadiationExposure(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let coulombPerKilogramValues: [String: Decimal] = [
            "C/kg": 1,
            "mC/kg": Decimal(sign: .plus, exponent: -3, significand: 1),
            "µC/kg": Decimal(sign: .plus, exponent: -6, significand: 1),
            "R": Decimal(string: "0.000258")!,
            "TR": Decimal(string: "0.000258")!,
            "P": Decimal(string: "0.000258")!,
            "rep": Decimal(string: "0.000258")!
        ]
        
        guard let fromValue = coulombPerKilogramValues[fromUnit], let toValue = coulombPerKilogramValues[toUnit] else {
            return value
        }
        
        let coulombPerKilogram = value * fromValue
        return coulombPerKilogram / toValue
    }
    
    private func convertRadiationAbsorbedDose(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let radValues: [String: Decimal] = [
            "rad": 1,
            "mrad": Decimal(sign: .plus, exponent: -3, significand: 1),
            "J/kg": 100,
            "J/g": Decimal(sign: .plus, exponent: 5, significand: 1),
            "J/cg": Decimal(sign: .plus, exponent: 7, significand: 1),
            "J/mg": Decimal(sign: .plus, exponent: 8, significand: 1),
            "Gy": 100,
            "EGy": Decimal(sign: .plus, exponent: 20, significand: 1),
            "PGy": Decimal(sign: .plus, exponent: 17, significand: 1),
            "TGy": Decimal(sign: .plus, exponent: 14, significand: 1),
            "GGy": Decimal(sign: .plus, exponent: 11, significand: 1),
            "MGy": Decimal(sign: .plus, exponent: 8, significand: 1),
            "kGy": Decimal(sign: .plus, exponent: 5, significand: 1),
            "hGy": Decimal(sign: .plus, exponent: 4, significand: 1),
            "daGy": Decimal(sign: .plus, exponent: 3, significand: 1),
            "dGy": 10,
            "cGy": 1,
            "mGy": Decimal(string: "0.1")!,
            "µGy": Decimal(sign: .plus, exponent: -4, significand: 1),
            "nGy": Decimal(sign: .plus, exponent: -7, significand: 1),
            "pGy": Decimal(sign: .plus, exponent: -10, significand: 1),
            "fGy": Decimal(sign: .plus, exponent: -13, significand: 1),
            "aGy": Decimal(sign: .plus, exponent: -16, significand: 1)
        ]
        
        guard let fromValue = radValues[fromUnit], let toValue = radValues[toUnit] else {
            return value
        }
        
        let rads = value * fromValue
        return rads / toValue
    }
    
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
    
    var info: LocalizedStringKey {
        switch self {
        case .radiation:
            return "RadiationInfo"
        case .radiationAbsorbedDose:
            return "RadiationAbsorbedDoseInfo"
        case .radiationActivity:
            return "RadiationActivityInfo"
        case .radiationExposure:
            return "RadiationExposureInfo"
        }
    }
    
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .radiation:
            return [
                ("Gy/s", String(localized: "gray/second")),
                ("EGy/s", String(localized: "exagray/second")),
                ("PGy/s", String(localized: "petagray/second")),
                ("TGy/s", String(localized: "teragray/second")),
                ("GGy/s", String(localized: "gigagray/second")),
                ("MGy/s", String(localized: "megagray/second")),
                ("kGy/s", String(localized: "kilogray/second")),
                ("hGy/s", String(localized: "hectogray/second")),
                ("daGy/s", String(localized: "dekagray/second")),
                ("dGy/s", String(localized: "decigray/second")),
                ("cGy/s", String(localized: "centigray/second")),
                ("mGy/s", String(localized: "milligray/second")),
                ("µGy/s", String(localized: "microgray/second")),
                ("nGy/s", String(localized: "nanogray/second")),
                ("pGy/s", String(localized: "picogray/second")),
                ("fGy/s", String(localized: "femtogray/second")),
                ("aGy/s", String(localized: "attogray/second")),
                ("rad/s", String(localized: "rad/second")),
                ("J/kg/s", String(localized: "joule/kilogram/second")),
                ("W/kg", String(localized: "watt/kilogram")),
                ("Sv/s", String(localized: "sievert/second")),
                ("rem/s", String(localized: "rem/second"))
            ]
        case .radiationActivity:
            return [
                ("Bq", String(localized: "becquerel")),
                ("TBq", String(localized: "terabecquerel")),
                ("GBq", String(localized: "gigabecquerel")),
                ("MBq", String(localized: "megabecquerel")),
                ("kBq", String(localized: "kilobecquerel")),
                ("mBq", String(localized: "millibecquerel")),
                ("Ci", String(localized: "curie")),
                ("kCi", String(localized: "kilocurie")),
                ("mCi", String(localized: "millicurie")),
                ("µCi", String(localized: "microcurie")),
                ("nCi", String(localized: "nanocurie")),
                ("pCi", String(localized: "picocurie")),
                ("Rd", String(localized: "rutherford")),
                ("s⁻¹", String(localized: "one/second")),
                ("dis/s", String(localized: "disintegrations/second")),
                ("dis/min", String(localized: "disintegrations/minute"))
            ]
        case .radiationExposure:
            return [
                ("C/kg", String(localized: "coulomb/kilogram")),
                ("mC/kg", String(localized: "millicoulomb/kilogram")),
                ("µC/kg", String(localized: "microcoulomb/kilogram")),
                ("R", String(localized: "roentgen")),
                ("TR", String(localized: "tissue roentgen")),
                ("P", String(localized: "parker")),
                ("rep", String(localized: "rep"))
            ]
        case .radiationAbsorbedDose:
            return [
                ("rad", String(localized: "rad")),
                ("mrad", String(localized: "millirad")),
                ("J/kg", String(localized: "joule/kilogram")),
                ("J/g", String(localized: "joule/gram")),
                ("J/cg", String(localized: "joule/centigram")),
                ("J/mg", String(localized: "joule/milligram")),
                ("Gy", String(localized: "gray")),
                ("EGy", String(localized: "exagray")),
                ("PGy", String(localized: "petagray")),
                ("TGy", String(localized: "teragray")),
                ("GGy", String(localized: "gigagray")),
                ("MGy", String(localized: "megagray")),
                ("kGy", String(localized: "kilogray")),
                ("hGy", String(localized: "hectogray")),
                ("daGy", String(localized: "dekagray")),
                ("dGy", String(localized: "decigray")),
                ("cGy", String(localized: "centigray")),
                ("mGy", String(localized: "milligray")),
                ("µGy", String(localized: "microgray")),
                ("nGy", String(localized: "nanogray")),
                ("pGy", String(localized: "picogray")),
                ("fGy", String(localized: "femtogray")),
                ("aGy", String(localized: "attogray"))
            ]
        }
    }
}
