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
                ("m³/s", String(localized: "cubic meter/second")),
                ("m³/d", String(localized: "cubic meter/day")),
                ("m³/h", String(localized: "cubic meter/hour")),
                ("m³/min", String(localized: "cubic meter/minute")),
                ("cm³/d", String(localized: "cubic centimeter/day")),
                ("cm³/h", String(localized: "cubic centimeter/hour")),
                ("cm³/min", String(localized: "cubic centimeter/minute")),
                ("cm³/s", String(localized: "cubic centimeter/second")),
                ("L/d", String(localized: "liter/day")),
                ("L/h", String(localized: "liter/hour")),
                ("L/min", String(localized: "liter/minute")),
                ("L/s", String(localized: "liter/second")),
                ("mL/d", String(localized: "milliliter/day")),
                ("mL/h", String(localized: "milliliter/hour")),
                ("mL/min", String(localized: "milliliter/minute")),
                ("mL/s", String(localized: "milliliter/second")),
                ("gal(US)/d", String(localized: "gallon (US)/day")),
                ("gal(US)/h", String(localized: "gallon (US)/hour")),
                ("gal(US)/min", String(localized: "gallon (US)/minute")),
                ("gal(US)/s", String(localized: "gallon (US)/second")),
                ("gal(UK)/d", String(localized: "gallon (UK)/day")),
                ("gal(UK)/h", String(localized: "gallon (UK)/hour")),
                ("gal(UK)/min", String(localized: "gallon (UK)/minute")),
                ("gal(UK)/s", String(localized: "gallon (UK)/second")),
                ("kbbl(US)/d", String(localized: "kilobarrel (US)/day")),
                ("bbl(US)/d", String(localized: "barrel (US)/day")),
                ("bbl(US)/h", String(localized: "barrel (US)/hour")),
                ("bbl(US)/min", String(localized: "barrel (US)/minute")),
                ("bbl(US)/s", String(localized: "barrel (US)/second")),
                ("ac·ft/y", String(localized: "acre-foot/year")),
                ("ac·ft/d", String(localized: "acre-foot/day")),
                ("ac·ft/h", String(localized: "acre-foot/hour")),
                ("hcf/d", String(localized: "hundred-cubic foot/day")),
                ("hcf/h", String(localized: "hundred-cubic foot/hour")),
                ("hcf/min", String(localized: "hundred-cubic foot/minute")),
                ("oz/h", String(localized: "ounce/hour")),
                ("oz/min", String(localized: "ounce/minute")),
                ("oz/s", String(localized: "ounce/second")),
                ("oz(UK)/h", String(localized: "ounce (UK)/hour")),
                ("oz(UK)/min", String(localized: "ounce (UK)/minute")),
                ("oz(UK)/s", String(localized: "ounce (UK)/second")),
                ("yd³/h", String(localized: "cubic yard/hour")),
                ("yd³/min", String(localized: "cubic yard/minute")),
                ("yd³/s", String(localized: "cubic yard/second")),
                ("ft³/h", String(localized: "cubic foot/hour")),
                ("ft³/min", String(localized: "cubic foot/minute")),
                ("ft³/s", String(localized: "cubic foot/second")),
                ("in³/h", String(localized: "cubic inch/hour")),
                ("in³/min", String(localized: "cubic inch/minute")),
                ("in³/s", String(localized: "cubic inch/second")),
                ("lb/s (Gas)", String(localized: "pound/second (Gasoline at 15.5°C)")),
                ("lb/min (Gas)", String(localized: "pound/minute (Gasoline at 15.5°C)")),
                ("lb/h (Gas)", String(localized: "pound/hour (Gasoline at 15.5°C)")),
                ("lb/d (Gas)", String(localized: "pound/day (Gasoline at 15.5°C)")),
                ("kg/s (Gas)", String(localized: "kilogram/second (Gasoline at 15.5°C)")),
                ("kg/min (Gas)", String(localized: "kilogram/minute (Gasoline at 15.5°C)")),
                ("kg/h (Gas)", String(localized: "kilogram/hour (Gasoline at 15.5°C)")),
                ("kg/d (Gas)", String(localized: "kilogram/day (Gasoline at 15.5°C)"))
            ]
        case .flowMass:
            return [
                ("kg/s", String(localized: "kilogram/second")),
                ("g/s", String(localized: "gram/second")),
                ("g/min", String(localized: "gram/minute")),
                ("g/h", String(localized: "gram/hour")),
                ("g/d", String(localized: "gram/day")),
                ("mg/min", String(localized: "milligram/minute")),
                ("mg/h", String(localized: "milligram/hour")),
                ("mg/d", String(localized: "milligram/day")),
                ("kg/min", String(localized: "kilogram/minute")),
                ("kg/h", String(localized: "kilogram/hour")),
                ("kg/d", String(localized: "kilogram/day")),
                ("Eg/s", String(localized: "exagram/second")),
                ("Pg/s", String(localized: "petagram/second")),
                ("Tg/s", String(localized: "teragram/second")),
                ("Gg/s", String(localized: "gigagram/second")),
                ("Mg/s", String(localized: "megagram/second")),
                ("hg/s", String(localized: "hectogram/second")),
                ("dag/s", String(localized: "dekagram/second")),
                ("dg/s", String(localized: "decigram/second")),
                ("cg/s", String(localized: "centigram/second")),
                ("mg/s", String(localized: "milligram/second")),
                ("µg/s", String(localized: "microgram/second")),
                ("t/s", String(localized: "ton (metric)/second")),
                ("t/min", String(localized: "ton (metric)/minute")),
                ("t/h", String(localized: "ton (metric)/hour")),
                ("t/d", String(localized: "ton (metric)/day")),
                ("ton(short)/h", String(localized: "ton (short)/hour")),
                ("lb/s", String(localized: "pound/second")),
                ("lb/min", String(localized: "pound/minute")),
                ("lb/h", String(localized: "pound/hour")),
                ("lb/d", String(localized: "pound/day"))
            ]
        case .flowMolar:
            return [
                ("mol/s", String(localized: "mol/second")),
                ("Emol/s", String(localized: "examol/second")),
                ("Pmol/s", String(localized: "petamol/second")),
                ("Tmol/s", String(localized: "teramol/second")),
                ("Gmol/s", String(localized: "gigamol/second")),
                ("Mmol/s", String(localized: "megamol/second")),
                ("kmol/s", String(localized: "kilomol/second")),
                ("hmol/s", String(localized: "hectomol/second")),
                ("damol/s", String(localized: "dekamol/second")),
                ("dmol/s", String(localized: "decimol/second")),
                ("cmol/s", String(localized: "centimol/second")),
                ("mmol/s", String(localized: "millimol/second")),
                ("µmol/s", String(localized: "micromol/second")),
                ("nmol/s", String(localized: "nanomol/second")),
                ("pmol/s", String(localized: "picomol/second")),
                ("fmol/s", String(localized: "femtomol/second")),
                ("amol/s", String(localized: "attomol/second")),
                ("mol/min", String(localized: "mol/minute")),
                ("mol/h", String(localized: "mol/hour")),
                ("mol/d", String(localized: "mol/day")),
                ("mmol/min", String(localized: "millimol/minute")),
                ("mmol/h", String(localized: "millimol/hour")),
                ("mmol/d", String(localized: "millimol/day")),
                ("kmol/min", String(localized: "kilomol/minute")),
                ("kmol/h", String(localized: "kilomol/hour")),
                ("kmol/d", String(localized: "kilomol/day"))
            ]
        case .massFluxDensity:
            return [
                ("g/s/m²", String(localized: "gram/second/square meter")),
                ("kg/h/m²", String(localized: "kilogram/hour/square meter")),
                ("kg/h/ft²", String(localized: "kilogram/hour/square foot")),
                ("kg/s/m²", String(localized: "kilogram/second/square meter")),
                ("g/s/cm²", String(localized: "gram/second/sq. centimeter")),
                ("lb/h/ft²", String(localized: "pound/hour/square foot")),
                ("lb/s/ft²", String(localized: "pound/second/square foot"))
            ]
        case .concentrationMolar:
            return [
                ("mol/m³", String(localized: "mol/cubic meter")),
                ("mol/L", String(localized: "mol/liter")),
                ("mol/cm³", String(localized: "mol/cubic centimeter")),
                ("mol/mm³", String(localized: "mol/cubic millimeter")),
                ("kmol/m³", String(localized: "kilomol/cubic meter")),
                ("kmol/L", String(localized: "kilomol/liter")),
                ("kmol/cm³", String(localized: "kilomol/cubic centimeter")),
                ("kmol/mm³", String(localized: "kilomol/cubic millimeter")),
                ("mmol/m³", String(localized: "millimol/cubic meter")),
                ("mmol/L", String(localized: "millimol/liter")),
                ("mmol/cm³", String(localized: "millimol/cubic centimeter")),
                ("mmol/mm³", String(localized: "millimol/cubic millimeter"))
            ]
        case .concentrationSolution:
            return [
                ("kg/L", String(localized: "kilogram/liter")),
                ("g/L", String(localized: "gram/liter")),
                ("mg/L", String(localized: "milligram/liter")),
                ("ppm", String(localized: "part/million (ppm)")),
                ("gr/gal(US)", String(localized: "grain/gallon (US)")),
                ("gr/gal(UK)", String(localized: "grain/gallon (UK)")),
                ("lb/gal(US)", String(localized: "pound/gallon (US)")),
                ("lb/gal(UK)", String(localized: "pound/gallon (UK)")),
                ("lb/Mgal(US)", String(localized: "pound/million gallon (US)")),
                ("lb/Mgal(UK)", String(localized: "pound/million gallon (UK)")),
                ("lb/ft³", String(localized: "pound/cubic foot"))
            ]
        case .viscosityDynamic:
            return [
                ("Pa·s", String(localized: "pascal second")),
                ("kgf·s/m²", String(localized: "kilogram-force second/square meter")),
                ("N·s/m²", String(localized: "newton second/square meter")),
                ("mN·s/m²", String(localized: "millinewton second/sq. meter")),
                ("dyn·s/cm²", String(localized: "dyne second/sq. centimeter")),
                ("P", String(localized: "poise")),
                ("EP", String(localized: "exapoise")),
                ("PP", String(localized: "petapoise")),
                ("TP", String(localized: "terapoise")),
                ("GP", String(localized: "gigapoise")),
                ("MP", String(localized: "megapoise")),
                ("kP", String(localized: "kilopoise")),
                ("hP", String(localized: "hectopoise")),
                ("daP", String(localized: "dekapoise")),
                ("dP", String(localized: "decipoise")),
                ("cP", String(localized: "centipoise")),
                ("mP", String(localized: "millipoise")),
                ("µP", String(localized: "micropoise")),
                ("nP", String(localized: "nanopoise")),
                ("pP", String(localized: "picopoise")),
                ("fP", String(localized: "femtopoise")),
                ("aP", String(localized: "attopoise")),
                ("lbf·s/in²", String(localized: "pound-force second/sq. inch")),
                ("lbf·s/ft²", String(localized: "pound-force second/sq. foot")),
                ("pdl·s/ft²", String(localized: "poundal second/square foot")),
                ("g/cm/s", String(localized: "gram/centimeter/second")),
                ("slug/ft/s", String(localized: "slug/foot/second")),
                ("lb/ft/s", String(localized: "pound/foot/second")),
                ("lb/ft/h", String(localized: "pound/foot/hour"))
            ]
        case .viscosityKinematic:
            return [
                ("m²/s", String(localized: "square meter/second")),
                ("m²/h", String(localized: "square meter/hour")),
                ("cm²/s", String(localized: "square centimeter/second")),
                ("mm²/s", String(localized: "square millimeter/second")),
                ("ft²/s", String(localized: "square foot/second")),
                ("ft²/h", String(localized: "square foot/hour")),
                ("in²/s", String(localized: "square inch/second")),
                ("St", String(localized: "stokes")),
                ("ESt", String(localized: "exastokes")),
                ("PSt", String(localized: "petastokes")),
                ("TSt", String(localized: "terastokes")),
                ("GSt", String(localized: "gigastokes")),
                ("MSt", String(localized: "megastokes")),
                ("kSt", String(localized: "kilostokes")),
                ("hSt", String(localized: "hectostokes")),
                ("daSt", String(localized: "dekastokes")),
                ("dSt", String(localized: "decistokes")),
                ("cSt", String(localized: "centistokes")),
                ("mSt", String(localized: "millistokes")),
                ("µSt", String(localized: "microstokes")),
                ("nSt", String(localized: "nanostokes")),
                ("pSt", String(localized: "picostokes")),
                ("fSt", String(localized: "femtostokes")),
                ("aSt", String(localized: "attostokes"))
            ]
        case .surfaceTension:
            return [
                ("N/m", String(localized: "newton/meter")),
                ("mN/m", String(localized: "millinewton/meter")),
                ("gf/cm", String(localized: "gram-force/centimeter")),
                ("dyn/cm", String(localized: "dyne/centimeter")),
                ("erg/cm²", String(localized: "erg/square centimeter")),
                ("erg/mm²", String(localized: "erg/square millimeter")),
                ("pdl/in", String(localized: "poundal/inch")),
                ("lbf/in", String(localized: "pound-force/inch"))
            ]
        case .permeability:
            return [
                ("kg/Pa·s·m²", String(localized: "kilogram/pascal/second/square meter")),
                ("perm(0°C)", String(localized: "permeability (0°C)")),
                ("perm(23°C)", String(localized: "permeability (23°C)")),
                ("perm·in(0°C)", String(localized: "permeability inches (0°C)")),
                ("perm·in(23°C)", String(localized: "permeability inches (23°C)"))
            ]
        }
    }
}
