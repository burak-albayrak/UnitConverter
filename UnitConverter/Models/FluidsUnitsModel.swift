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
            "m³/s": 1,
            "m³/d": Decimal(string: "1.15741e-5")!,
            "m³/h": Decimal(string: "0.0002777778")!,
            "m³/min": Decimal(string: "0.0166666667")!,
            "cm³/d": Decimal(string: "1.1574074074074e-11")!,
            "cm³/h": Decimal(string: "2.7777777777778e-10")!,
            "cm³/min": Decimal(string: "1.6666666666667e-8")!,
            "cm³/s": Decimal(sign: .minus, exponent: 6, significand: 1),
            "L/d": Decimal(string: "1.1574074074074e-8")!,
            "L/h": Decimal(string: "2.7777777777778e-7")!,
            "L/min": Decimal(string: "1.66667e-5")!,
            "L/s": Decimal(string: "0.001")!,
            "mL/d": Decimal(string: "1.1574074074074e-11")!,
            "mL/h": Decimal(string: "2.7777777777778e-10")!,
            "mL/min": Decimal(string: "1.6666666666667e-8")!,
            "mL/s": Decimal(sign: .minus, exponent: 6, significand: 1),
            "gal(US)/d": Decimal(string: "4.3812636388889e-8")!,
            "gal(US)/h": Decimal(string: "1.0515032733333e-6")!,
            "gal(US)/min": Decimal(string: "6.30902e-5")!,
            "gal(US)/s": Decimal(string: "0.0037854118")!,
            "gal(UK)/d": Decimal(string: "5.2616782407407e-8")!,
            "gal(UK)/h": Decimal(string: "1.2628027777778e-6")!,
            "gal(UK)/min": Decimal(string: "7.57682e-5")!,
            "gal(UK)/s": Decimal(string: "0.00454609")!,
            "kbbl(US)/d": Decimal(string: "0.0018401307")!,
            "bbl(US)/d": Decimal(string: "1.8401307283333e-6")!,
            "bbl(US)/h": Decimal(string: "4.41631e-5")!,
            "bbl(US)/min": Decimal(string: "0.0026497882")!,
            "bbl(US)/s": Decimal(string: "0.1589872949")!,
            "ac·ft/y": Decimal(string: "3.91136e-5")!,
            "ac·ft/d": Decimal(string: "0.0142764673")!,
            "ac·ft/h": Decimal(string: "0.3426352143")!,
            "hcf/d": Decimal(string: "3.27741e-5")!,
            "hcf/h": Decimal(string: "0.0007865791")!,
            "hcf/min": Decimal(string: "0.0471947443")!,
            "oz/h": Decimal(string: "8.2148693229167e-9")!,
            "oz/min": Decimal(string: "4.92892159375e-7")!,
            "oz/s": Decimal(string: "2.95735e-5")!,
            "oz(UK)/h": Decimal(string: "7.8925178504774e-9")!,
            "oz(UK)/min": Decimal(string: "4.7355107102865e-7")!,
            "oz(UK)/s": Decimal(string: "2.84131e-5")!,
            "yd³/h": Decimal(string: "0.0002123763")!,
            "yd³/min": Decimal(string: "0.012742581")!,
            "yd³/s": Decimal(string: "0.764554858")!,
            "ft³/h": Decimal(string: "7.86579072e-6")!,
            "ft³/min": Decimal(string: "0.0004719474")!,
            "ft³/s": Decimal(string: "0.0283168466")!,
            "in³/h": Decimal(string: "4.5519622224454e-9")!,
            "in³/min": Decimal(string: "2.7311773333333e-7")!,
            "in³/s": Decimal(string: "1.63871e-5")!,
            "lb/s (Gas)": Decimal(string: "0.0006135189")!,
            "lb/min (Gas)": Decimal(string: "1.02253e-5")!,
            "lb/h (Gas)": Decimal(string: "1.704219244213e-7")!,
            "lb/d (Gas)": Decimal(string: "7.1009135150463e-9")!,
            "kg/s (Gas)": Decimal(string: "0.0013525777")!,
            "kg/min (Gas)": Decimal(string: "2.2543e-5")!,
            "kg/h (Gas)": Decimal(string: "3.7571602974537e-7")!,
            "kg/d (Gas)": Decimal(string: "1.5654834571759e-8")!
        ]
        
        guard let fromValue = cubicMeterPerSecondValues[fromUnit.lowercased()], let toValue = cubicMeterPerSecondValues[toUnit.lowercased()] else {
            return value
        }
        
        let cubicMeterPerSecond = value * fromValue
        return cubicMeterPerSecond / toValue
    }
    
    private func convertMassFlowRate(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kilogramPerSecondValues: [String: Decimal] = [
            "kg/s": 1,
            "g/s": Decimal(string: "0.001")!,
            "g/min": Decimal(string: "1.66667e-5")!,
            "g/h": Decimal(string: "2.7777777777778e-7")!,
            "g/d": Decimal(string: "1.1574074074074e-8")!,
            "mg/min": Decimal(string: "1.6666666666667e-8")!,
            "mg/h": Decimal(string: "2.7777777777778e-10")!,
            "mg/d": Decimal(string: "1.1574074074074e-11")!,
            "kg/min": Decimal(string: "0.0166666667")!,
            "kg/h": Decimal(string: "0.0002777778")!,
            "kg/d": Decimal(string: "1.15741e-5")!,
            "Eg/s": Decimal(sign: .plus, exponent: 15, significand: 1),
            "Pg/s": Decimal(sign: .plus, exponent: 12, significand: 1),
            "Tg/s": Decimal(sign: .plus, exponent: 9, significand: 1),
            "Gg/s": Decimal(sign: .plus, exponent: 6, significand: 1),
            "Mg/s": 1000,
            "hg/s": Decimal(string: "0.1")!,
            "dag/s": Decimal(string: "0.01")!,
            "dg/s": Decimal(string: "0.0001")!,
            "cg/s": Decimal(sign: .minus, exponent: 5, significand: 1),
            "mg/s": Decimal(sign: .minus, exponent: 6, significand: 1),
            "µg/s": Decimal(sign: .minus, exponent: 9, significand: 1),
            "t/s": 1000,
            "t/min": Decimal(string: "16.6666666667")!,
            "t/h": Decimal(string: "0.2777777778")!,
            "t/d": Decimal(string: "0.0115740741")!,
            "ton(short)/h": Decimal(string: "0.2519957611")!,
            "lb/s": Decimal(string: "0.45359237")!,
            "lb/min": Decimal(string: "0.0075598728")!,
            "lb/h": Decimal(string: "0.0001259979")!,
            "lb/d": Decimal(string: "5.2499116898148e-6")!
        ]
        
        guard let fromValue = kilogramPerSecondValues[fromUnit.lowercased()], let toValue = kilogramPerSecondValues[toUnit.lowercased()] else {
            return value
        }
        
        let kilogramPerSecond = value * fromValue
        return kilogramPerSecond / toValue
    }
    
    private func convertMolarFlowRate(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let molPerSecondValues: [String: Decimal] = [
            "mol/s": 1,
            "Emol/s": Decimal(sign: .plus, exponent: 18, significand: 1),
            "Pmol/s": Decimal(sign: .plus, exponent: 15, significand: 1),
            "Tmol/s": Decimal(sign: .plus, exponent: 12, significand: 1),
            "Gmol/s": Decimal(sign: .plus, exponent: 9, significand: 1),
            "Mmol/s": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kmol/s": Decimal(sign: .plus, exponent: 3, significand: 1),
            "hmol/s": Decimal(sign: .plus, exponent: 2, significand: 1),
            "damol/s": Decimal(sign: .plus, exponent: 1, significand: 1),
            "dmol/s": Decimal(sign: .minus, exponent: 1, significand: 1),
            "cmol/s": Decimal(sign: .minus, exponent: 2, significand: 1),
            "mmol/s": Decimal(sign: .minus, exponent: 3, significand: 1),
            "µmol/s": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nmol/s": Decimal(sign: .minus, exponent: 9, significand: 1),
            "pmol/s": Decimal(sign: .minus, exponent: 12, significand: 1),
            "fmol/s": Decimal(sign: .minus, exponent: 15, significand: 1),
            "amol/s": Decimal(sign: .minus, exponent: 18, significand: 1),
            "mol/min": Decimal(string: "0.0166666667")!,
            "mol/h": Decimal(string: "0.0002777778")!,
            "mol/d": Decimal(string: "1.15741e-5")!,
            "mmol/min": Decimal(string: "1.66667e-5")!,
            "mmol/h": Decimal(string: "2.7777777777778e-7")!,
            "mmol/d": Decimal(string: "1.1574074074074e-8")!,
            "kmol/min": Decimal(string: "16.6666666667")!,
            "kmol/h": Decimal(string: "0.2777777778")!,
            "kmol/d": Decimal(string: "0.0115740741")!
        ]
        
        guard let fromValue = molPerSecondValues[fromUnit.lowercased()], let toValue = molPerSecondValues[toUnit.lowercased()] else {
            return value
        }
        
        let molPerSecond = value * fromValue
        return molPerSecond / toValue
    }
    
    private func convertMassFlowRateDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let gramPerSecondPerSquareMeterValues: [String: Decimal] = [
            "g/s/m²": 1,
            "kg/h/m²": Decimal(string: "0.2777777778")!,
            "kg/h/ft²": Decimal(string: "2.9899751173")!,
            "kg/s/m²": 1000,
            "g/s/cm²": 10000,
            "lb/h/ft²": Decimal(string: "1.3562299132")!,
            "lb/s/ft²": Decimal(string: "4882.4276872752")!
        ]
        
        guard let fromValue = gramPerSecondPerSquareMeterValues[fromUnit.lowercased()], let toValue = gramPerSecondPerSquareMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let gramPerSecondPerSquareMeter = value * fromValue
        return gramPerSecondPerSquareMeter / toValue
    }
    
    private func convertMolarConcentration(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let molPerCubicMeterValues: [String: Decimal] = [
            "mol/m³": 1,
            "mol/L": 1000,
            "mol/cm³": 1000000,
            "mol/mm³": 1000000000,
            "kmol/m³": 1000,
            "kmol/L": 1000000,
            "kmol/cm³": 1000000000,
            "kmol/mm³": 1000000000000,
            "mmol/m³": Decimal(string: "0.001")!,
            "mmol/L": 1,
            "mmol/cm³": 1000,
            "mmol/mm³": 1000000
        ]
        
        guard let fromValue = molPerCubicMeterValues[fromUnit.lowercased()], let toValue = molPerCubicMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let molPerCubicMeter = value * fromValue
        return molPerCubicMeter / toValue
    }
    
    private func convertDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kilogramPerLiterValues: [String: Decimal] = [
            "kg/L": 1,
            "g/L": Decimal(string: "0.001")!,
            "mg/L": Decimal(sign: .minus, exponent: 6, significand: 1),
            "ppm": Decimal(string: "9.988590003673e-7")!,
            "gr/gal(US)": Decimal(string: "1.71181e-5")!,
            "gr/gal(UK)": Decimal(string: "1.42538e-5")!,
            "lb/gal(US)": Decimal(string: "0.1198264284")!,
            "lb/gal(UK)": Decimal(string: "0.0997763736")!,
            "lb/Mgal(US)": Decimal(string: "1.1982642843713e-7")!,
            "lb/Mgal(UK)": Decimal(string: "9.9776373608464e-8")!,
            "lb/ft³": Decimal(string: "0.0160184635")!
        ]
        
        guard let fromValue = kilogramPerLiterValues[fromUnit.lowercased()], let toValue = kilogramPerLiterValues[toUnit.lowercased()] else {
            return value
        }
        
        let kilogramPerLiter = value * fromValue
        return kilogramPerLiter / toValue
    }
    
    private func convertDynamicViscosity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let pascalSecondValues: [String: Decimal] = [
            "Pa·s": 1,
            "kgf·s/m²": Decimal(string: "9.80665")!,
            "N·s/m²": 1,
            "mN·s/m²": Decimal(string: "0.001")!,
            "dyn·s/cm²": Decimal(string: "0.1")!,
            "P": Decimal(string: "0.1")!,
            "EP": Decimal(sign: .plus, exponent: 17, significand: 1),
            "PP": Decimal(sign: .plus, exponent: 14, significand: 1),
            "TP": Decimal(sign: .plus, exponent: 11, significand: 1),
            "GP": Decimal(sign: .plus, exponent: 8, significand: 1),
            "MP": Decimal(sign: .plus, exponent: 5, significand: 1),
            "kP": 100,
            "hP": 10,
            "daP": 1,
            "dP": Decimal(string: "0.01")!,
            "cP": Decimal(string: "0.001")!,
            "mP": Decimal(sign: .minus, exponent: 4, significand: 1),
            "µP": Decimal(sign: .minus, exponent: 7, significand: 1),
            "nP": Decimal(sign: .minus, exponent: 10, significand: 1),
            "pP": Decimal(sign: .minus, exponent: 13, significand: 1),
            "fP": Decimal(sign: .minus, exponent: 16, significand: 1),
            "aP": Decimal(sign: .minus, exponent: 19, significand: 1),
            "lbf·s/in²": Decimal(string: "6894.7572931684")!,
            "lbf·s/ft²": Decimal(string: "47.8802589802")!,
            "pdl·s/ft²": Decimal(string: "1.4881639436")!,
            "g/cm/s": Decimal(string: "0.1")!,
            "slug/ft/s": Decimal(string: "47.8802589802")!,
            "lb/ft/s": Decimal(string: "1.4881639436")!,
            "lb/ft/h": Decimal(string: "0.0004133789")!
        ]
        
        guard let fromValue = pascalSecondValues[fromUnit.lowercased()], let toValue = pascalSecondValues[toUnit.lowercased()] else {
            return value
        }
        
        let pascalSecond = value * fromValue
        return pascalSecond / toValue
    }
    
    private func convertKinematicViscosity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let squareMeterPerSecondValues: [String: Decimal] = [
            "m²/s": 1,
            "m²/h": Decimal(string: "0.0002777778")!,
            "cm²/s": Decimal(string: "0.0001")!,
            "mm²/s": Decimal(sign: .minus, exponent: 6, significand: 1),
            "ft²/s": Decimal(string: "0.09290304")!,
            "ft²/h": Decimal(string: "2.58064e-5")!,
            "in²/s": Decimal(string: "0.00064516")!,
            "St": Decimal(string: "0.0001")!,
            "ESt": Decimal(sign: .plus, exponent: 14, significand: 1),
            "PSt": Decimal(sign: .plus, exponent: 11, significand: 1),
            "TSt": Decimal(sign: .plus, exponent: 8, significand: 1),
            "GSt": Decimal(sign: .plus, exponent: 5, significand: 1),
            "MSt": 100,
            "kSt": Decimal(string: "0.1")!,
            "hSt": Decimal(string: "0.01")!,
            "daSt": Decimal(string: "0.001")!,
            "dSt": Decimal(sign: .minus, exponent: 5, significand: 1),
            "cSt": Decimal(sign: .minus, exponent: 6, significand: 1),
            "mSt": Decimal(sign: .minus, exponent: 7, significand: 1),
            "µSt": Decimal(sign: .minus, exponent: 10, significand: 1),
            "nSt": Decimal(sign: .minus, exponent: 13, significand: 1),
            "pSt": Decimal(sign: .minus, exponent: 16, significand: 1),
            "fSt": Decimal(sign: .minus, exponent: 19, significand: 1),
            "aSt": Decimal(sign: .minus, exponent: 22, significand: 1)
        ]
        
        guard let fromValue = squareMeterPerSecondValues[fromUnit.lowercased()], let toValue = squareMeterPerSecondValues[toUnit.lowercased()] else {
            return value
        }
        
        let squareMeterPerSecond = value * fromValue
        return squareMeterPerSecond / toValue
    }
    
    private func convertSurfaceTension(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let newtonPerMeterValues: [String: Decimal] = [
            "N/m": 1,
            "mN/m": Decimal(string: "0.001")!,
            "gf/cm": Decimal(string: "0.980665")!,
            "dyn/cm": Decimal(string: "0.001")!,
            "erg/cm²": Decimal(string: "0.001")!,
            "erg/mm²": Decimal(string: "0.1")!,
            "pdl/in": Decimal(string: "5.443108491")!,
            "lbf/in": Decimal(string: "175.1268369864")!
        ]
        
        guard let fromValue = newtonPerMeterValues[fromUnit.lowercased()], let toValue = newtonPerMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let newtonPerMeter = value * fromValue
        return newtonPerMeter / toValue
    }
    
    private func convertPermeability(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kgPerPascalSecondSquareMeterValues: [String: Decimal] = [
            "kg/Pa·s·m²": 1,
            "perm(0°C)": Decimal(string: "5.72135e-11")!,
            "perm(23°C)": Decimal(string: "5.74525e-11")!,
            "perm·in(0°C)": Decimal(string: "1.45322e-12")!,
            "perm·in(23°C)": Decimal(string: "1.45929e-12")!
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
