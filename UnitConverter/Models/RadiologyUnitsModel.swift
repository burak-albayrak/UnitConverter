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
            "gray/second": 1,
            "exagray/second": Decimal(sign: .plus, exponent: 18, significand: 1),
            "petagray/second": Decimal(sign: .plus, exponent: 15, significand: 1),
            "teragray/second": Decimal(sign: .plus, exponent: 12, significand: 1),
            "gigagray/second": Decimal(sign: .plus, exponent: 9, significand: 1),
            "megagray/second": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kilogray/second": Decimal(sign: .plus, exponent: 3, significand: 1),
            "hectogray/second": Decimal(sign: .plus, exponent: 2, significand: 1),
            "dekagray/second": Decimal(sign: .plus, exponent: 1, significand: 1),
            "decigray/second": Decimal(sign: .minus, exponent: 1, significand: 1),
            "centigray/second": Decimal(sign: .minus, exponent: 2, significand: 1),
            "milligray/second": Decimal(sign: .minus, exponent: 3, significand: 1),
            "microgray/second": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nanogray/second": Decimal(sign: .minus, exponent: 9, significand: 1),
            "picogray/second": Decimal(sign: .minus, exponent: 12, significand: 1),
            "femtogray/second": Decimal(sign: .minus, exponent: 15, significand: 1),
            "attogray/second": Decimal(sign: .minus, exponent: 18, significand: 1),
            "rad/second": Decimal(sign: .minus, exponent: 2, significand: 1),
            "joule/kilogram/second": 1,
            "watt/kilogram": 1,
            "sievert/second": 1,
            "rem/second": Decimal(sign: .minus, exponent: 2, significand: 1)
        ]
        
        guard let fromValue = grayPerSecondValues[fromUnit.lowercased()], let toValue = grayPerSecondValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let grayPerSecond = value * fromValue
        return grayPerSecond / toValue
    }
    
    private func convertRadiationActivity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let becquerelValues: [String: Decimal] = [
            "becquerel": 1,
            "terabecquerel": Decimal(sign: .plus, exponent: 12, significand: 1),
            "gigabecquerel": Decimal(sign: .plus, exponent: 9, significand: 1),
            "megabecquerel": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kilobecquerel": Decimal(sign: .plus, exponent: 3, significand: 1),
            "millibecquerel": Decimal(sign: .minus, exponent: 3, significand: 1),
            "curie": Decimal(string: "3.7e10")!,
            "kilocurie": Decimal(string: "3.7e13")!,
            "millicurie": Decimal(string: "3.7e7")!,
            "microcurie": Decimal(string: "3.7e4")!,
            "nanocurie": 37,
            "picocurie": Decimal(string: "0.037")!,
            "rutherford": Decimal(sign: .plus, exponent: 6, significand: 1),
            "one/second": 1,
            "disintegrations/second": 1,
            "disintegrations/minute": Decimal(1) / Decimal(60)
        ]

        guard let fromValue = becquerelValues[fromUnit.lowercased()], let toValue = becquerelValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let becquerels = value * fromValue
        return becquerels / toValue
    }
    
    private func convertRadiationExposure(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let coulombPerKilogramValues: [String: Decimal] = [
            "coulomb/kilogram": 1,
            "millicoulomb/kilogram": Decimal(sign: .minus, exponent: 3, significand: 1),
            "microcoulomb/kilogram": Decimal(sign: .minus, exponent: 6, significand: 1),
            "roentgen": Decimal(string: "0.000258")!,
            "tissue roentgen": Decimal(string: "0.000258")!,
            "parker": Decimal(string: "0.000258")!,
            "rep": Decimal(string: "0.000258")!
        ]

        guard let fromValue = coulombPerKilogramValues[fromUnit.lowercased()], let toValue = coulombPerKilogramValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let coulombPerKilogram = value * fromValue
        return coulombPerKilogram / toValue
    }
    
    private func convertRadiationAbsorbedDose(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let radValues: [String: Decimal] = [
            "rad": 1,
            "millirad": Decimal(sign: .minus, exponent: 3, significand: 1),
            "joule/kilogram": 100,
            "joule/gram": Decimal(sign: .plus, exponent: 5, significand: 1),
            "joule/centigram": Decimal(sign: .plus, exponent: 7, significand: 1),
            "joule/milligram": Decimal(sign: .plus, exponent: 8, significand: 1),
            "gray": 100,
            "exagray": Decimal(sign: .plus, exponent: 20, significand: 1),
            "petagray": Decimal(sign: .plus, exponent: 17, significand: 1),
            "teragray": Decimal(sign: .plus, exponent: 14, significand: 1),
            "gigagray": Decimal(sign: .plus, exponent: 11, significand: 1),
            "megagray": Decimal(sign: .plus, exponent: 8, significand: 1),
            "kilogray": Decimal(sign: .plus, exponent: 5, significand: 1),
            "hectogray": Decimal(sign: .plus, exponent: 4, significand: 1),
            "dekagray": Decimal(sign: .plus, exponent: 3, significand: 1),
            "decigray": 10,
            "centigray": 1,
            "milligray": Decimal(string: "0.1")!,
            "microgray": Decimal(sign: .minus, exponent: 4, significand: 1),
            "nanogray": Decimal(sign: .minus, exponent: 7, significand: 1),
            "picogray": Decimal(sign: .minus, exponent: 10, significand: 1),
            "femtogray": Decimal(sign: .minus, exponent: 13, significand: 1),
            "attogray": Decimal(sign: .minus, exponent: 16, significand: 1)
        ]

        guard let fromValue = radValues[fromUnit.lowercased()], let toValue = radValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
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

