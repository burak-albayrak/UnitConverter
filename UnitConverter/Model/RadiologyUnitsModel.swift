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

    func convert(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
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

    private func convertRadiation(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let grayPerSecondValues: [String: Double] = [
            "gray/second": 1,
            "exagray/second": 1e18,
            "petagray/second": 1e15,
            "teragray/second": 1e12,
            "gigagray/second": 1e9,
            "megagray/second": 1e6,
            "kilogray/second": 1e3,
            "hectogray/second": 1e2,
            "dekagray/second": 1e1,
            "decigray/second": 1e-1,
            "centigray/second": 1e-2,
            "milligray/second": 1e-3,
            "microgray/second": 1e-6,
            "nanogray/second": 1e-9,
            "picogray/second": 1e-12,
            "femtogray/second": 1e-15,
            "attogray/second": 1e-18,
            "rad/second": 1e-2,
            "joule/kilogram/second": 1,
            "watt/kilogram": 1,
            "sievert/second": 1,
            "rem/second": 1e-2
        ]
        
        guard let fromValue = grayPerSecondValues[fromUnit.lowercased()], let toValue = grayPerSecondValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let grayPerSecond = value * fromValue
        return grayPerSecond / toValue
    }
    
    private func convertRadiationActivity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let becquerelValues: [String: Double] = [
            "becquerel": 1,
            "terabecquerel": 1e12,
            "gigabecquerel": 1e9,
            "megabecquerel": 1e6,
            "kilobecquerel": 1e3,
            "millibecquerel": 1e-3,
            "curie": 3.7e10,
            "kilocurie": 3.7e13,
            "millicurie": 3.7e7,
            "microcurie": 3.7e4,
            "nanocurie": 37,
            "picocurie": 0.037,
            "rutherford": 1e6,
            "one/second": 1,
            "disintegrations/second": 1,
            "disintegrations/minute": 1/60
        ]

        guard let fromValue = becquerelValues[fromUnit.lowercased()], let toValue = becquerelValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let becquerels = value * fromValue
        return becquerels / toValue
    }
    
    private func convertRadiationExposure(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let coulombPerKilogramValues: [String: Double] = [
            "coulomb/kilogram": 1,
            "millicoulomb/kilogram": 1e-3,
            "microcoulomb/kilogram": 1e-6,
            "roentgen": 0.000258,
            "tissue roentgen": 0.000258,
            "parker": 0.000258,
            "rep": 0.000258
        ]

        guard let fromValue = coulombPerKilogramValues[fromUnit.lowercased()], let toValue = coulombPerKilogramValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let coulombPerKilogram = value * fromValue
        return coulombPerKilogram / toValue
    }
    
    private func convertRadiationAbsorbedDose(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let radValues: [String: Double] = [
            "rad": 1,
            "millirad": 1e-3,
            "joule/kilogram": 100,
            "joule/gram": 1e5,
            "joule/centigram": 1e7,
            "joule/milligram": 1e8,
            "gray": 100,
            "exagray": 1e20,
            "petagray": 1e17,
            "teragray": 1e14,
            "gigagray": 1e11,
            "megagray": 1e8,
            "kilogray": 1e5,
            "hectogray": 1e4,
            "dekagray": 1e3,
            "decigray": 10,
            "centigray": 1,
            "milligray": 0.1,
            "microgray": 1e-4,
            "nanogray": 1e-7,
            "picogray": 1e-10,
            "femtogray": 1e-13,
            "attogray": 1e-16
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
    
    var availableUnits: [String] {
        switch self {
        case .radiation:
            return [
                "gray/second", "exagray/second", "petagray/second", "teragray/second",
                "gigagray/second", "megagray/second", "kilogray/second", "hectogray/second",
                "dekagray/second", "decigray/second", "centigray/second", "milligray/second",
                "microgray/second", "nanogray/second", "picogray/second", "femtogray/second",
                "attogray/second", "rad/second", "joule/kilogram/second", "watt/kilogram",
                "sievert/second", "rem/second"
            ]
        case .radiationActivity:
            return [
                "becquerel", "terabecquerel", "gigabecquerel", "megabecquerel",
                "kilobecquerel", "millibecquerel", "curie", "kilocurie",
                "millicurie", "microcurie", "nanocurie", "picocurie",
                "rutherford", "one/second", "disintegrations/second",
                "disintegrations/minute"
            ]
        case .radiationExposure:
            return [
                "coulomb/kilogram", "millicoulomb/kilogram", "microcoulomb/kilogram",
                "roentgen", "tissue roentgen", "parker", "rep"
            ]
        case .radiationAbsorbedDose:
            return [
                "rad", "millirad", "joule/kilogram", "joule/gram", "joule/centigram",
                "joule/milligram", "gray", "exagray", "petagray", "teragray", "gigagray",
                "megagray", "kilogray", "hectogray", "dekagray", "decigray", "centigray",
                "milligray", "microgray", "nanogray", "picogray", "femtogray", "attogray"
            ]
        }
    }
}

