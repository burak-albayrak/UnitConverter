//
//  FluidsUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation
import SwiftUI

enum FluidsUnitsCategory: String, CaseIterable, UnitCategory {
    case flow = "Flow"
    case flowMass = "Flow - Mass"
    case flowMolar = "Flow Molar"
    case massFluxDensity = "Mass Flux Density"
    case concentrationMolar = "Concentration - Molar"
    case concentrationSolution = "Concentration Solution"
    case viscosityDynamic = "Viscosity - Dynamic"
    case viscosityKinematic = "Viscosity - Kinematic"
    case surfaceTension = "Surface Tension"
    case permeability = "Permeability"

    var localizedName: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }

    func convert(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        switch self {
        case .flow:
            return convertVolumetricFlowRate(value, from: fromUnit, to: toUnit)
        case .flowMass:
            return convertMassFlowRate(value, from: fromUnit, to: toUnit)
        case .flowMolar:
            return convertMolarFlowRate(value, from: fromUnit, to: toUnit)
        case .massFluxDensity:
            return convertMassFlowRateDensity(value, from: fromUnit, to: toUnit)
        case .concentrationMolar:
            return convertMolarConcentration(value, from: fromUnit, to: toUnit)
        case .concentrationSolution:
            return convertDensity(value, from: fromUnit, to: toUnit)
        case .viscosityDynamic:
            return convertDynamicViscosity(value, from: fromUnit, to: toUnit)
        case .viscosityKinematic:
            return convertKinematicViscosity(value, from: fromUnit, to: toUnit)
        case .surfaceTension:
            return convertSurfaceTension(value, from: fromUnit, to: toUnit)
        case .permeability:
            return convertPermeability(value, from: fromUnit, to: toUnit)

        }
    }
    
    private func convertVolumetricFlowRate(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let cubicMeterPerSecondValues: [String: Decimal] = [
            "cubic meter/second": 1,
            "cubic meter/day": Decimal(string: "1.15741e-5")!,
            "cubic meter/hour": Decimal(string: "0.0002777778")!,
            "cubic meter/minute": Decimal(string: "0.0166666667")!,
            "cubic centimeter/day": Decimal(string: "1.1574074074074e-11")!,
            "cubic centimeter/hour": Decimal(string: "2.7777777777778e-10")!,
            "cubic centimeter/minute": Decimal(string: "1.6666666666667e-8")!,
            "cubic centimeter/second": Decimal(sign: .minus, exponent: 6, significand: 1),
            "liter/day": Decimal(string: "1.1574074074074e-8")!,
            "liter/hour": Decimal(string: "2.7777777777778e-7")!,
            "liter/minute": Decimal(string: "1.66667e-5")!,
            "liter/second": Decimal(string: "0.001")!,
            "milliliter/day": Decimal(string: "1.1574074074074e-11")!,
            "milliliter/hour": Decimal(string: "2.7777777777778e-10")!,
            "milliliter/minute": Decimal(string: "1.6666666666667e-8")!,
            "milliliter/second": Decimal(sign: .minus, exponent: 6, significand: 1),
            "gallon (US)/day": Decimal(string: "4.3812636388889e-8")!,
            "gallon (US)/hour": Decimal(string: "1.0515032733333e-6")!,
            "gallon (US)/minute": Decimal(string: "6.30902e-5")!,
            "gallon (US)/second": Decimal(string: "0.0037854118")!,
            "gallon (UK)/day": Decimal(string: "5.2616782407407e-8")!,
            "gallon (UK)/hour": Decimal(string: "1.2628027777778e-6")!,
            "gallon (UK)/minute": Decimal(string: "7.57682e-5")!,
            "gallon (UK)/second": Decimal(string: "0.00454609")!,
            "kilobarrel (US)/day": Decimal(string: "0.0018401307")!,
            "barrel (US)/day": Decimal(string: "1.8401307283333e-6")!,
            "barrel (US)/hour": Decimal(string: "4.41631e-5")!,
            "barrel (US)/minute": Decimal(string: "0.0026497882")!,
            "barrel (US)/second": Decimal(string: "0.1589872949")!,
            "acre-foot/year": Decimal(string: "3.91136e-5")!,
            "acre-foot/day": Decimal(string: "0.0142764673")!,
            "acre-foot/hour": Decimal(string: "0.3426352143")!,
            "hundred-cubic foot/day": Decimal(string: "3.27741e-5")!,
            "hundred-cubic foot/hour": Decimal(string: "0.0007865791")!,
            "hundred-cubic foot/minute": Decimal(string: "0.0471947443")!,
            "ounce/hour": Decimal(string: "8.2148693229167e-9")!,
            "ounce/minute": Decimal(string: "4.92892159375e-7")!,
            "ounce/second": Decimal(string: "2.95735e-5")!,
            "ounce (UK)/hour": Decimal(string: "7.8925178504774e-9")!,
            "ounce (UK)/minute": Decimal(string: "4.7355107102865e-7")!,
            "ounce (UK)/second": Decimal(string: "2.84131e-5")!,
            "cubic yard/hour": Decimal(string: "0.0002123763")!,
            "cubic yard/minute": Decimal(string: "0.012742581")!,
            "cubic yard/second": Decimal(string: "0.764554858")!,
            "cubic foot/hour": Decimal(string: "7.86579072e-6")!,
            "cubic foot/minute": Decimal(string: "0.0004719474")!,
            "cubic foot/second": Decimal(string: "0.0283168466")!,
            "cubic inch/hour": Decimal(string: "4.5519622224454e-9")!,
            "cubic inch/minute": Decimal(string: "2.7311773333333e-7")!,
            "cubic inch/second": Decimal(string: "1.63871e-5")!,
            "pound/second (Gasoline at 15.5°C)": Decimal(string: "0.0006135189")!,
            "pound/minute (Gasoline at 15.5°C)": Decimal(string: "1.02253e-5")!,
            "pound/hour (Gasoline at 15.5°C)": Decimal(string: "1.704219244213e-7")!,
            "pound/day (Gasoline at 15.5°C)": Decimal(string: "7.1009135150463e-9")!,
            "kilogram/second (Gasoline at 15.5°C)": Decimal(string: "0.0013525777")!,
            "kilogram/minute (Gasoline at 15.5°C)": Decimal(string: "2.2543e-5")!,
            "kilogram/hour (Gasoline at 15.5°C)": Decimal(string: "3.7571602974537e-7")!,
            "kilogram/day (Gasoline at 15.5°C)": Decimal(string: "1.5654834571759e-8")!
        ]
        
        guard let fromValue = cubicMeterPerSecondValues[fromUnit.lowercased()], let toValue = cubicMeterPerSecondValues[toUnit.lowercased()] else {
            return value
        }

        let cubicMeterPerSecond = value * fromValue
        return cubicMeterPerSecond / toValue
    }
    
    private func convertMassFlowRate(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kilogramPerSecondValues: [String: Decimal] = [
            "kilogram/second": 1,
            "gram/second": Decimal(string: "0.001")!,
            "gram/minute": Decimal(string: "1.66667e-5")!,
            "gram/hour": Decimal(string: "2.7777777777778e-7")!,
            "gram/day": Decimal(string: "1.1574074074074e-8")!,
            "milligram/minute": Decimal(string: "1.6666666666667e-8")!,
            "milligram/hour": Decimal(string: "2.7777777777778e-10")!,
            "milligram/day": Decimal(string: "1.1574074074074e-11")!,
            "kilogram/minute": Decimal(string: "0.0166666667")!,
            "kilogram/hour": Decimal(string: "0.0002777778")!,
            "kilogram/day": Decimal(string: "1.15741e-5")!,
            "exagram/second": Decimal(sign: .plus, exponent: 15, significand: 1),
            "petagram/second": Decimal(sign: .plus, exponent: 12, significand: 1),
            "teragram/second": Decimal(sign: .plus, exponent: 9, significand: 1),
            "gigagram/second": Decimal(sign: .plus, exponent: 6, significand: 1),
            "megagram/second": 1000,
            "hectogram/second": Decimal(string: "0.1")!,
            "dekagram/second": Decimal(string: "0.01")!,
            "decigram/second": Decimal(string: "0.0001")!,
            "centigram/second": Decimal(sign: .minus, exponent: 5, significand: 1),
            "milligram/second": Decimal(sign: .minus, exponent: 6, significand: 1),
            "microgram/second": Decimal(sign: .minus, exponent: 9, significand: 1),
            "ton (metric)/second": 1000,
            "ton (metric)/minute": Decimal(string: "16.6666666667")!,
            "ton (metric)/hour": Decimal(string: "0.2777777778")!,
            "ton (metric)/day": Decimal(string: "0.0115740741")!,
            "ton (short)/hour": Decimal(string: "0.2519957611")!,
            "pound/second": Decimal(string: "0.45359237")!,
            "pound/minute": Decimal(string: "0.0075598728")!,
            "pound/hour": Decimal(string: "0.0001259979")!,
            "pound/day": Decimal(string: "5.2499116898148e-6")!
        ]
        
        guard let fromValue = kilogramPerSecondValues[fromUnit.lowercased()], let toValue = kilogramPerSecondValues[toUnit.lowercased()] else {
            return value
        }

        let kilogramPerSecond = value * fromValue
        return kilogramPerSecond / toValue
    }
    
    private func convertMolarFlowRate(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let molPerSecondValues: [String: Decimal] = [
            "mol/second": 1,
            "examol/second": Decimal(sign: .plus, exponent: 18, significand: 1),
            "petamol/second": Decimal(sign: .plus, exponent: 15, significand: 1),
            "teramol/second": Decimal(sign: .plus, exponent: 12, significand: 1),
            "gigamol/second": Decimal(sign: .plus, exponent: 9, significand: 1),
            "megamol/second": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kilomol/second": Decimal(sign: .plus, exponent: 3, significand: 1),
            "hectomol/second": Decimal(sign: .plus, exponent: 2, significand: 1),
            "dekamol/second": Decimal(sign: .plus, exponent: 1, significand: 1),
            "decimol/second": Decimal(sign: .minus, exponent: 1, significand: 1),
            "centimol/second": Decimal(sign: .minus, exponent: 2, significand: 1),
            "millimol/second": Decimal(sign: .minus, exponent: 3, significand: 1),
            "micromol/second": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nanomol/second": Decimal(sign: .minus, exponent: 9, significand: 1),
            "picomol/second": Decimal(sign: .minus, exponent: 12, significand: 1),
            "femtomol/second": Decimal(sign: .minus, exponent: 15, significand: 1),
            "attomol/second": Decimal(sign: .minus, exponent: 18, significand: 1),
            "mol/minute": Decimal(string: "0.0166666667")!,
            "mol/hour": Decimal(string: "0.0002777778")!,
            "mol/day": Decimal(string: "1.15741e-5")!,
            "millimol/minute": Decimal(string: "1.66667e-5")!,
            "millimol/hour": Decimal(string: "2.7777777777778e-7")!,
            "millimol/day": Decimal(string: "1.1574074074074e-8")!,
            "kilomol/minute": Decimal(string: "16.6666666667")!,
            "kilomol/hour": Decimal(string: "0.2777777778")!,
            "kilomol/day": Decimal(string: "0.0115740741")!
        ]

        guard let fromValue = molPerSecondValues[fromUnit.lowercased()], let toValue = molPerSecondValues[toUnit.lowercased()] else {
            return value
        }

        let molPerSecond = value * fromValue
        return molPerSecond / toValue
    }
    
    private func convertMassFlowRateDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let gramPerSecondPerSquareMeterValues: [String: Decimal] = [
            "gram/second/square meter": 1,
            "kilogram/hour/square meter": Decimal(string: "0.2777777778")!,
            "kilogram/hour/square foot": Decimal(string: "2.9899751173")!,
            "kilogram/second/square meter": 1000,
            "gram/second/sq. centimeter": 10000,
            "pound/hour/square foot": Decimal(string: "1.3562299132")!,
            "pound/second/square foot": Decimal(string: "4882.4276872752")!
        ]

        guard let fromValue = gramPerSecondPerSquareMeterValues[fromUnit.lowercased()], let toValue = gramPerSecondPerSquareMeterValues[toUnit.lowercased()] else {
            return value
        }

        let gramPerSecondPerSquareMeter = value * fromValue
        return gramPerSecondPerSquareMeter / toValue
    }
    
    private func convertMolarConcentration(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let molPerCubicMeterValues: [String: Decimal] = [
            "mol/cubic meter": 1,
            "mol/liter": 1000,
            "mol/cubic centimeter": 1000000,
            "mol/cubic millimeter": 1000000000,
            "kilomol/cubic meter": 1000,
            "kilomol/liter": 1000000,
            "kilomol/cubic centimeter": 1000000000,
            "kilomol/cubic millimeter": 1000000000000,
            "millimol/cubic meter": Decimal(string: "0.001")!,
            "millimol/liter": 1,
            "millimol/cubic centimeter": 1000,
            "millimol/cubic millimeter": 1000000
        ]

        guard let fromValue = molPerCubicMeterValues[fromUnit.lowercased()], let toValue = molPerCubicMeterValues[toUnit.lowercased()] else {
            return value
        }

        let molPerCubicMeter = value * fromValue
        return molPerCubicMeter / toValue
    }
    
    private func convertDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kilogramPerLiterValues: [String: Decimal] = [
            "kilogram/liter": 1,
            "gram/liter": Decimal(string: "0.001")!,
            "milligram/liter": Decimal(sign: .minus, exponent: 6, significand: 1),
            "part/million (ppm)": Decimal(string: "9.988590003673e-7")!,
            "grain/gallon (US)": Decimal(string: "1.71181e-5")!,
            "grain/gallon (UK)": Decimal(string: "1.42538e-5")!,
            "pound/gallon (US)": Decimal(string: "0.1198264284")!,
            "pound/gallon (UK)": Decimal(string: "0.0997763736")!,
            "pound/million gallon (US)": Decimal(string: "1.1982642843713e-7")!,
            "pound/million gallon (UK)": Decimal(string: "9.9776373608464e-8")!,
            "pound/cubic foot": Decimal(string: "0.0160184635")!
        ]

        guard let fromValue = kilogramPerLiterValues[fromUnit.lowercased()], let toValue = kilogramPerLiterValues[toUnit.lowercased()] else {
            return value
        }

        let kilogramPerLiter = value * fromValue
        return kilogramPerLiter / toValue
    }
    
    private func convertDynamicViscosity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let pascalSecondValues: [String: Decimal] = [
            "pascal second": 1,
            "kilogram-force second/square meter": Decimal(string: "9.80665")!,
            "newton second/square meter": 1,
            "millinewton second/sq. meter": Decimal(string: "0.001")!,
            "dyne second/sq. centimeter": Decimal(string: "0.1")!,
            "poise": Decimal(string: "0.1")!,
            "exapoise": Decimal(sign: .plus, exponent: 17, significand: 1),
            "petapoise": Decimal(sign: .plus, exponent: 14, significand: 1),
            "terapoise": Decimal(sign: .plus, exponent: 11, significand: 1),
            "gigapoise": Decimal(sign: .plus, exponent: 8, significand: 1),
            "megapoise": Decimal(sign: .plus, exponent: 5, significand: 1),
            "kilopoise": 100,
            "hectopoise": 10,
            "dekapoise": 1,
            "decipoise": Decimal(string: "0.01")!,
            "centipoise": Decimal(string: "0.001")!,
            "millipoise": Decimal(sign: .minus, exponent: 4, significand: 1),
            "micropoise": Decimal(sign: .minus, exponent: 7, significand: 1),
            "nanopoise": Decimal(sign: .minus, exponent: 10, significand: 1),
            "picopoise": Decimal(sign: .minus, exponent: 13, significand: 1),
            "femtopoise": Decimal(sign: .minus, exponent: 16, significand: 1),
            "attopoise": Decimal(sign: .minus, exponent: 19, significand: 1),
            "pound-force second/sq. inch": Decimal(string: "6894.7572931684")!,
            "pound-force second/sq. foot": Decimal(string: "47.8802589802")!,
            "poundal second/square foot": Decimal(string: "1.4881639436")!,
            "gram/centimeter/second": Decimal(string: "0.1")!,
            "slug/foot/second": Decimal(string: "47.8802589802")!,
            "pound/foot/second": Decimal(string: "1.4881639436")!,
            "pound/foot/hour": Decimal(string: "0.0004133789")!
        ]
        
        guard let fromValue = pascalSecondValues[fromUnit.lowercased()], let toValue = pascalSecondValues[toUnit.lowercased()] else {
            return value
        }

        let pascalSecond = value * fromValue
        return pascalSecond / toValue
    }
    
    private func convertKinematicViscosity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let squareMeterPerSecondValues: [String: Decimal] = [
            "square meter/second": 1,
            "square meter/hour": Decimal(string: "0.0002777778")!,
            "square centimeter/second": Decimal(string: "0.0001")!,
            "square millimeter/second": Decimal(sign: .minus, exponent: 6, significand: 1),
            "square foot/second": Decimal(string: "0.09290304")!,
            "square foot/hour": Decimal(string: "2.58064e-5")!,
            "square inch/second": Decimal(string: "0.00064516")!,
            "stokes": Decimal(string: "0.0001")!,
            "exastokes": Decimal(sign: .plus, exponent: 14, significand: 1),
            "petastokes": Decimal(sign: .plus, exponent: 11, significand: 1),
            "terastokes": Decimal(sign: .plus, exponent: 8, significand: 1),
            "gigastokes": Decimal(sign: .plus, exponent: 5, significand: 1),
            "megastokes": 100,
            "kilostokes": Decimal(string: "0.1")!,
            "hectostokes": Decimal(string: "0.01")!,
            "dekastokes": Decimal(string: "0.001")!,
            "decistokes": Decimal(sign: .minus, exponent: 5, significand: 1),
            "centistokes": Decimal(sign: .minus, exponent: 6, significand: 1),
            "millistokes": Decimal(sign: .minus, exponent: 7, significand: 1),
            "microstokes": Decimal(sign: .minus, exponent: 10, significand: 1),
            "nanostokes": Decimal(sign: .minus, exponent: 13, significand: 1),
            "picostokes": Decimal(sign: .minus, exponent: 16, significand: 1),
            "femtostokes": Decimal(sign: .minus, exponent: 19, significand: 1),
            "attostokes": Decimal(sign: .minus, exponent: 22, significand: 1)
        ]

        guard let fromValue = squareMeterPerSecondValues[fromUnit.lowercased()], let toValue = squareMeterPerSecondValues[toUnit.lowercased()] else {
            return value
        }

        let squareMeterPerSecond = value * fromValue
        return squareMeterPerSecond / toValue
    }
    
    private func convertSurfaceTension(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let newtonPerMeterValues: [String: Decimal] = [
            "newton/meter": 1,
            "millinewton/meter": Decimal(string: "0.001")!,
            "gram-force/centimeter": Decimal(string: "0.980665")!,
            "dyne/centimeter": Decimal(string: "0.001")!,
            "erg/square centimeter": Decimal(string: "0.001")!,
            "erg/square millimeter": Decimal(string: "0.1")!,
            "poundal/inch": Decimal(string: "5.443108491")!,
            "pound-force/inch": Decimal(string: "175.1268369864")!
        ]

        guard let fromValue = newtonPerMeterValues[fromUnit.lowercased()], let toValue = newtonPerMeterValues[toUnit.lowercased()] else {
            return value
        }

        let newtonPerMeter = value * fromValue
        return newtonPerMeter / toValue
    }
    
    private func convertPermeability(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kgPerPascalSecondSquareMeterValues: [String: Decimal] = [
            "kilogram/pascal/second/square meter": 1,
            "permeability (0°C)": Decimal(string: "5.72135e-11")!,
            "permeability (23°C)": Decimal(string: "5.74525e-11")!,
            "permeability inches (0°C)": Decimal(string: "1.45322e-12")!,
            "permeability inches (23°C)": Decimal(string: "1.45929e-12")!
        ]

        guard let fromValue = kgPerPascalSecondSquareMeterValues[fromUnit.lowercased()], let toValue = kgPerPascalSecondSquareMeterValues[toUnit.lowercased()] else {
            return value
        }

        let kgPerPascalSecondSquareMeter = value * fromValue
        return kgPerPascalSecondSquareMeter / toValue
    }
    
    var icon: String {
        switch self {
        case .concentrationMolar:
            return "circle.grid.cross"
        case .concentrationSolution:
            return "drop"
        case .flow:
            return "arrow.right.to.line"
        case .flowMass:
            return "scalemass"
        case .flowMolar:
            return "wave.3.forward"
        case .massFluxDensity:
            return "chart.bar"
        case .permeability:
            return "square.stack.3d.forward.dottedline"
        case .surfaceTension:
            return "drop.triangle"
        case .viscosityDynamic:
            return "waveform.path.ecg"
        case .viscosityKinematic:
            return "waveform.path.ecg.rectangle"
        }
    }
    
    var info: LocalizedStringKey {
        switch self {
        case .concentrationMolar:
            return "ConcentrationMolarInfo"
        case .concentrationSolution:
            return "ConcentrationSolutionInfo"
        case .flow:
            return "FlowInfo"
        case .flowMass:
            return "FlowMassInfo"
        case .flowMolar:
            return "FlowMolarInfo"
        case .massFluxDensity:
            return "MassFluxDensityInfo"
        case .permeability:
            return "PermeabilityInfo"
        case .surfaceTension:
            return "SurfaceTensionInfo"
        case .viscosityDynamic:
            return "ViscosityDynamicInfo"
        case .viscosityKinematic:
            return "ViscosityKinematicInfo"
        }
    }
        
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .flow:
            return [
                ("m³/s", "cubic meter/second"),
                ("m³/d", "cubic meter/day"),
                ("m³/h", "cubic meter/hour"),
                ("m³/min", "cubic meter/minute"),
                ("cm³/d", "cubic centimeter/day"),
                ("cm³/h", "cubic centimeter/hour"),
                ("cm³/min", "cubic centimeter/minute"),
                ("cm³/s", "cubic centimeter/second"),
                ("L/d", "liter/day"),
                ("L/h", "liter/hour"),
                ("L/min", "liter/minute"),
                ("L/s", "liter/second"),
                ("mL/d", "milliliter/day"),
                ("mL/h", "milliliter/hour"),
                ("mL/min", "milliliter/minute"),
                ("mL/s", "milliliter/second"),
                ("gal(US)/d", "gallon (US)/day"),
                ("gal(US)/h", "gallon (US)/hour"),
                ("gal(US)/min", "gallon (US)/minute"),
                ("gal(US)/s", "gallon (US)/second"),
                ("gal(UK)/d", "gallon (UK)/day"),
                ("gal(UK)/h", "gallon (UK)/hour"),
                ("gal(UK)/min", "gallon (UK)/minute"),
                ("gal(UK)/s", "gallon (UK)/second"),
                ("kbbl(US)/d", "kilobarrel (US)/day"),
                ("bbl(US)/d", "barrel (US)/day"),
                ("bbl(US)/h", "barrel (US)/hour"),
                ("bbl(US)/min", "barrel (US)/minute"),
                ("bbl(US)/s", "barrel (US)/second"),
                ("ac·ft/y", "acre-foot/year"),
                ("ac·ft/d", "acre-foot/day"),
                ("ac·ft/h", "acre-foot/hour"),
                ("hcf/d", "hundred-cubic foot/day"),
                ("hcf/h", "hundred-cubic foot/hour"),
                ("hcf/min", "hundred-cubic foot/minute"),
                ("oz/h", "ounce/hour"),
                ("oz/min", "ounce/minute"),
                ("oz/s", "ounce/second"),
                ("oz(UK)/h", "ounce (UK)/hour"),
                ("oz(UK)/min", "ounce (UK)/minute"),
                ("oz(UK)/s", "ounce (UK)/second"),
                ("yd³/h", "cubic yard/hour"),
                ("yd³/min", "cubic yard/minute"),
                ("yd³/s", "cubic yard/second"),
                ("ft³/h", "cubic foot/hour"),
                ("ft³/min", "cubic foot/minute"),
                ("ft³/s", "cubic foot/second"),
                ("in³/h", "cubic inch/hour"),
                ("in³/min", "cubic inch/minute"),
                ("in³/s", "cubic inch/second"),
                ("lb/s (Gas)", "pound/second (Gasoline at 15.5°C)"),
                ("lb/min (Gas)", "pound/minute (Gasoline at 15.5°C)"),
                ("lb/h (Gas)", "pound/hour (Gasoline at 15.5°C)"),
                ("lb/d (Gas)", "pound/day (Gasoline at 15.5°C)"),
                ("kg/s (Gas)", "kilogram/second (Gasoline at 15.5°C)"),
                ("kg/min (Gas)", "kilogram/minute (Gasoline at 15.5°C)"),
                ("kg/h (Gas)", "kilogram/hour (Gasoline at 15.5°C)"),
                ("kg/d (Gas)", "kilogram/day (Gasoline at 15.5°C)")
            ]
        case .flowMass:
            return [
                ("kg/s", "kilogram/second"),
                ("g/s", "gram/second"),
                ("g/min", "gram/minute"),
                ("g/h", "gram/hour"),
                ("g/d", "gram/day"),
                ("mg/min", "milligram/minute"),
                ("mg/h", "milligram/hour"),
                ("mg/d", "milligram/day"),
                ("kg/min", "kilogram/minute"),
                ("kg/h", "kilogram/hour"),
                ("kg/d", "kilogram/day"),
                ("Eg/s", "exagram/second"),
                ("Pg/s", "petagram/second"),
                ("Tg/s", "teragram/second"),
                ("Gg/s", "gigagram/second"),
                ("Mg/s", "megagram/second"),
                ("hg/s", "hectogram/second"),
                ("dag/s", "dekagram/second"),
                ("dg/s", "decigram/second"),
                ("cg/s", "centigram/second"),
                ("mg/s", "milligram/second"),
                ("µg/s", "microgram/second"),
                ("t/s", "ton (metric)/second"),
                ("t/min", "ton (metric)/minute"),
                ("t/h", "ton (metric)/hour"),
                ("t/d", "ton (metric)/day"),
                ("ton(short)/h", "ton (short)/hour"),
                ("lb/s", "pound/second"),
                ("lb/min", "pound/minute"),
                ("lb/h", "pound/hour"),
                ("lb/d", "pound/day")
            ]
        case .flowMolar:
            return [
                ("mol/s", "mol/second"),
                ("Emol/s", "examol/second"),
                ("Pmol/s", "petamol/second"),
                ("Tmol/s", "teramol/second"),
                ("Gmol/s", "gigamol/second"),
                ("Mmol/s", "megamol/second"),
                ("kmol/s", "kilomol/second"),
                ("hmol/s", "hectomol/second"),
                ("damol/s", "dekamol/second"),
                ("dmol/s", "decimol/second"),
                ("cmol/s", "centimol/second"),
                ("mmol/s", "millimol/second"),
                ("µmol/s", "micromol/second"),
                ("nmol/s", "nanomol/second"),
                ("pmol/s", "picomol/second"),
                ("fmol/s", "femtomol/second"),
                ("amol/s", "attomol/second"),
                ("mol/min", "mol/minute"),
                ("mol/h", "mol/hour"),
                ("mol/d", "mol/day"),
                ("mmol/min", "millimol/minute"),
                ("mmol/h", "millimol/hour"),
                ("mmol/d", "millimol/day"),
                ("kmol/min", "kilomol/minute"),
                ("kmol/h", "kilomol/hour"),
                ("kmol/d", "kilomol/day")
            ]
        case .massFluxDensity:
            return [
                ("g/s/m²", "gram/second/square meter"),
                ("kg/h/m²", "kilogram/hour/square meter"),
                ("kg/h/ft²", "kilogram/hour/square foot"),
                ("kg/s/m²", "kilogram/second/square meter"),
                ("g/s/cm²", "gram/second/sq. centimeter"),
                ("lb/h/ft²", "pound/hour/square foot"),
                ("lb/s/ft²", "pound/second/square foot")
            ]
        case .concentrationMolar:
            return [
                ("mol/m³", "mol/cubic meter"),
                ("mol/L", "mol/liter"),
                ("mol/cm³", "mol/cubic centimeter"),
                ("mol/mm³", "mol/cubic millimeter"),
                ("kmol/m³", "kilomol/cubic meter"),
                ("kmol/L", "kilomol/liter"),
                ("kmol/cm³", "kilomol/cubic centimeter"),
                ("kmol/mm³", "kilomol/cubic millimeter"),
                ("mmol/m³", "millimol/cubic meter"),
                ("mmol/L", "millimol/liter"),
                ("mmol/cm³", "millimol/cubic centimeter"),
                ("mmol/mm³", "millimol/cubic millimeter")
            ]
        case .concentrationSolution:
            return [
                ("kg/L", "kilogram/liter"),
                ("g/L", "gram/liter"),
                ("mg/L", "milligram/liter"),
                ("ppm", "part/million (ppm)"),
                ("gr/gal(US)", "grain/gallon (US)"),
                ("gr/gal(UK)", "grain/gallon (UK)"),
                ("lb/gal(US)", "pound/gallon (US)"),
                ("lb/gal(UK)", "pound/gallon (UK)"),
                ("lb/Mgal(US)", "pound/million gallon (US)"),
                ("lb/Mgal(UK)", "pound/million gallon (UK)"),
                ("lb/ft³", "pound/cubic foot")
            ]
        case .viscosityDynamic:
            return [
                ("Pa·s", "pascal second"),
                ("kgf·s/m²", "kilogram-force second/square meter"),
                ("N·s/m²", "newton second/square meter"),
                ("mN·s/m²", "millinewton second/sq. meter"),
                ("dyn·s/cm²", "dyne second/sq. centimeter"),
                ("P", "poise"),
                ("EP", "exapoise"),
                ("PP", "petapoise"),
                ("TP", "terapoise"),
                ("GP", "gigapoise"),
                ("MP", "megapoise"),
                ("kP", "kilopoise"),
                ("hP", "hectopoise"),
                ("daP", "dekapoise"),
                ("dP", "decipoise"),
                ("cP", "centipoise"),
                ("mP", "millipoise"),
                ("µP", "micropoise"),
                ("nP", "nanopoise"),
                ("pP", "picopoise"),
                ("fP", "femtopoise"),
                ("aP", "attopoise"),
                ("lbf·s/in²", "pound-force second/sq. inch"),
                ("lbf·s/ft²", "pound-force second/sq. foot"),
                ("pdl·s/ft²", "poundal second/square foot"),
                ("g/cm/s", "gram/centimeter/second"),
                ("slug/ft/s", "slug/foot/second"),
                ("lb/ft/s", "pound/foot/second"),
                ("lb/ft/h", "pound/foot/hour")
            ]
        case .viscosityKinematic:
            return [
                ("m²/s", "square meter/second"),
                ("m²/h", "square meter/hour"),
                ("cm²/s", "square centimeter/second"),
                ("mm²/s", "square millimeter/second"),
                ("ft²/s", "square foot/second"),
                ("ft²/h", "square foot/hour"),
                ("in²/s", "square inch/second"),
                ("St", "stokes"),
                ("ESt", "exastokes"),
                ("PSt", "petastokes"),
                ("TSt", "terastokes"),
                ("GSt", "gigastokes"),
                ("MSt", "megastokes"),
                ("kSt", "kilostokes"),
                ("hSt", "hectostokes"),
                ("daSt", "dekastokes"),
                ("dSt", "decistokes"),
                ("cSt", "centistokes"),
                ("mSt", "millistokes"),
                ("µSt", "microstokes"),
                ("nSt", "nanostokes"),
                ("pSt", "picostokes"),
                ("fSt", "femtostokes"),
                ("aSt", "attostokes")
            ]
        case .surfaceTension:
            return [
                ("N/m", "newton/meter"),
                ("mN/m", "millinewton/meter"),
                ("gf/cm", "gram-force/centimeter"),
                ("dyn/cm", "dyne/centimeter"),
                ("erg/cm²", "erg/square centimeter"),
                ("erg/mm²", "erg/square millimeter"),
                ("pdl/in", "poundal/inch"),
                ("lbf/in", "pound-force/inch")
            ]
        case .permeability:
            return [
                ("kg/Pa·s·m²", "kilogram/pascal/second/square meter"),
                ("perm(0°C)", "permeability (0°C)"),
                ("perm(23°C)", "permeability (23°C)"),
                ("perm·in(0°C)", "permeability inches (0°C)"),
                ("perm·in(23°C)", "permeability inches (23°C)")
            ]
        }
    }
}
