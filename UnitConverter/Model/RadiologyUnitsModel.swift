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
    
    var availableUnits: [Dimension] {
        switch self {
        case .radiation:
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
            
        case .radiationAbsorbedDose:
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
            
        case .radiationActivity:
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
            
        case .radiationExposure:
            return [UnitTemperature.celsius,
                    UnitTemperature.fahrenheit,
                    UnitTemperature.kelvin]
        }
    }
    
    var availableUnitNames: [String] {
        switch self {
        case .radiation:
            return ["Degrees", "Arc Minutes", "Arc Seconds", "Radians", "Gradians", "Revolutions"]
        case .radiationAbsorbedDose:
            return ["Square Megameters", "Square Kilometers", "Square Meters", "Square Centimeters", "Square Millimeters", "Square Nanometers", "Square Inches", "Square Feet", "Square Yards", "Square Miles", "Acres", "Ares", "Hectares"]
        case .radiationActivity:
            return ["Hours", "Minutes", "Seconds", "Milliseconds", "Microseconds", "Nanoseconds", "Picoseconds"]
        case .radiationExposure:
            return ["Megameters", "Kilometers", "Hectometers", "Decameters", "Meters", "Decimeters", "Centimeters", "Millimeters", "Micrometers", "Nanometers", "Picometers", "Inches", "Feet", "Yards", "Miles", "Scandinavian Miles", "Lightyears", "Nautical Miles", "Fathoms", "Astronomical Units", "Parsecs"]
        }
    }
}

