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
    
    var localizedInfo: LocalizedStringKey {
        LocalizedStringKey("\(self.rawValue)Info")
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
    
    var info: String {
        switch self {
        case .radiation:
            return """
                Radiation refers to the emission and transmission of energy in the form of waves or particles through space or a medium. It encompasses various types of energy, including electromagnetic radiation (such as light, radio waves, and X-rays) and particulate radiation (such as alpha and beta particles).
                
                The SI unit for radiation dose is the sievert (Sv), which quantifies the biological effect of ionizing radiation.
                
                For instance, X-rays and gamma rays are forms of high-energy electromagnetic radiation, while alpha and beta particles are types of particulate radiation. 
                
                Radiation is crucial in fields like medicine, where it is used in diagnostic imaging and cancer treatment, as well as in nuclear power and research.
                
                Understanding radiation helps in managing its safe use and minimizing exposure to harmful effects.
                """
        case .radiationAbsorbedDose:
            return """
                Radiation absorbed dose measures the amount of energy deposited by ionizing radiation per unit mass of tissue. It quantifies the extent of radiation exposure experienced by an object or biological tissue.
                
                The SI unit for absorbed dose is the gray (Gy), where one gray equals one joule of energy absorbed per kilogram of tissue. For example, an absorbed dose of 1 Gy means that 1 joule of energy has been deposited in 1 kilogram of tissue.
                
                This measurement is crucial in fields like radiology and radiation therapy to assess and control the amount of radiation delivered to patients or materials.
                
                Accurate determination of absorbed dose is essential for effective medical treatments, safety assessments, and minimizing potential radiation damage.
                """
        case .radiationActivity:
            return """
                Radiation activity measures the rate at which radioactive decay occurs in a material, reflecting how much radiation is emitted over a specific period. It quantifies the number of disintegrations or transformations of radioactive atoms per unit time.
                
                The SI unit for radiation activity is the becquerel (Bq), where one becquerel equals one disintegration per second. For example, a sample with an activity of 100 Bq means it emits 100 radiation events per second.
                
                Radiation activity is crucial in monitoring and managing radioactive materials, ensuring safety in nuclear power, medical treatments, and research.
                
                Accurate measurement of activity helps assess exposure risks, manage radioactive waste, and ensure compliance with safety regulations.
                """
        case .radiationExposure:
            return """
                Radiation exposure refers to the amount of ionizing radiation that a person or object encounters over a specific period. It measures the potential for radiation to interact with and affect biological tissues. 
                
                The SI unit for radiation exposure is the coulomb per kilogram (C/kg), but it is often measured in roentgens (R) in practical applications, where 1 R equals approximately 2.58 × 10⁻⁴ C/kg.
                
                For example, an exposure of 1 roentgen indicates that 1 unit of charge has been deposited per kilogram of air. Radiation exposure is critical for assessing safety and health risks in environments where radiation is present, such as in medical imaging, nuclear industries, and research laboratories.
                
                Proper measurement and management of radiation exposure help to minimize health risks and ensure safe practices.
                """
        }
    }
    
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .radiation:
            return [
                ("Gy/s", "gray/second"),
                ("EGy/s", "exagray/second"),
                ("PGy/s", "petagray/second"),
                ("TGy/s", "teragray/second"),
                ("GGy/s", "gigagray/second"),
                ("MGy/s", "megagray/second"),
                ("kGy/s", "kilogray/second"),
                ("hGy/s", "hectogray/second"),
                ("daGy/s", "dekagray/second"),
                ("dGy/s", "decigray/second"),
                ("cGy/s", "centigray/second"),
                ("mGy/s", "milligray/second"),
                ("µGy/s", "microgray/second"),
                ("nGy/s", "nanogray/second"),
                ("pGy/s", "picogray/second"),
                ("fGy/s", "femtogray/second"),
                ("aGy/s", "attogray/second"),
                ("rad/s", "rad/second"),
                ("J/kg/s", "joule/kilogram/second"),
                ("W/kg", "watt/kilogram"),
                ("Sv/s", "sievert/second"),
                ("rem/s", "rem/second")
            ]
        case .radiationActivity:
            return [
                ("Bq", "becquerel"),
                ("TBq", "terabecquerel"),
                ("GBq", "gigabecquerel"),
                ("MBq", "megabecquerel"),
                ("kBq", "kilobecquerel"),
                ("mBq", "millibecquerel"),
                ("Ci", "curie"),
                ("kCi", "kilocurie"),
                ("mCi", "millicurie"),
                ("µCi", "microcurie"),
                ("nCi", "nanocurie"),
                ("pCi", "picocurie"),
                ("Rd", "rutherford"),
                ("s⁻¹", "one/second"),
                ("dis/s", "disintegrations/second"),
                ("dis/min", "disintegrations/minute")
            ]
        case .radiationExposure:
            return [
                ("C/kg", "coulomb/kilogram"),
                ("mC/kg", "millicoulomb/kilogram"),
                ("µC/kg", "microcoulomb/kilogram"),
                ("R", "roentgen"),
                ("TR", "tissue roentgen"),
                ("P", "parker"),
                ("rep", "rep")
            ]
        case .radiationAbsorbedDose:
            return [
                ("rad", "rad"),
                ("mrad", "millirad"),
                ("J/kg", "joule/kilogram"),
                ("J/g", "joule/gram"),
                ("J/cg", "joule/centigram"),
                ("J/mg", "joule/milligram"),
                ("Gy", "gray"),
                ("EGy", "exagray"),
                ("PGy", "petagray"),
                ("TGy", "teragray"),
                ("GGy", "gigagray"),
                ("MGy", "megagray"),
                ("kGy", "kilogray"),
                ("hGy", "hectogray"),
                ("daGy", "dekagray"),
                ("dGy", "decigray"),
                ("cGy", "centigray"),
                ("mGy", "milligray"),
                ("µGy", "microgray"),
                ("nGy", "nanogray"),
                ("pGy", "picogray"),
                ("fGy", "femtogray"),
                ("aGy", "attogray")
            ]
        }
    }
}

