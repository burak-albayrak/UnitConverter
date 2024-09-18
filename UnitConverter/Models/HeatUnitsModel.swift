//
//  HeatUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation
import SwiftUI

enum HeatUnitsCategory: String, CaseIterable, UnitCategory {
    case fuelEfficiencyMass = "Fuel Efficiency - Mass"
    case fuelEfficiencyVolume = "Fuel Efficiency - Volume"
    case temperatureInterval = "Temperature Interval"
    case thermalExpansion = "Thermal Expansion"
    case thermalResistance = "Thermal Resistance"
    case thermalConductivity = "Thermal Conductivity"
    case spesificHeatCapacity = "Spesific Heat Capacity"
    case heatDensity = "Heat Density"
    case heatFluxDensity = "Heat Flux Density"
    case heatTransverCoefficient = "Heat Transver Coefficient"
    
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
    
    func convert(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        switch self {
        case .fuelEfficiencyMass:
            return convertSpecificEnergy(value, from: fromUnit, to: toUnit)
        case .fuelEfficiencyVolume:
            return convertEnergyDensity(value, from: fromUnit, to: toUnit)
        case .temperatureInterval:
            return convertTemperature(value, from: fromUnit, to: toUnit)
        case .thermalExpansion:
            return convertThermalExpansionCoefficient(value, from: fromUnit, to: toUnit)
        case .thermalResistance:
            return convertThermalResistance(value, from: fromUnit, to: toUnit)
        case .thermalConductivity:
            return convertThermalConductivity(value, from: fromUnit, to: toUnit)
        case .spesificHeatCapacity:
            return convertSpecificHeatCapacity(value, from: fromUnit, to: toUnit)
        case .heatDensity:
            return convertRadiationEnergyDensity(value, from: fromUnit, to: toUnit)
        case .heatFluxDensity:
            return convertRadiationFluxDensity(value, from: fromUnit, to: toUnit)
        case .heatTransverCoefficient:
            return convertHeatTransferCoefficient(value, from: fromUnit, to: toUnit)
        }
    }
    
    private func convertSpecificEnergy(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let baseValues: [String: Decimal] = [
            "J/kg": 1,
            "kJ/kg": 1000,
            "cal(IT)/g": Decimal(string: "4186.8")!,
            "cal(th)/g": Decimal(string: "4184.000000005")!,
            "Btu(IT)/lb": 2326,
            "Btu(th)/lb": Decimal(string: "2324.4444444446")!,
            "kg/J": 1,
            "kg/kJ": 0.001,
            "g/cal(IT)": 1 / Decimal(string: "4186.8")!,
            "g/cal(th)": 1 / Decimal(string: "4184.000000005")!,
            "lb/Btu(IT)": 1 / 2326,
            "lb/Btu(th)": 1 / Decimal(string: "2324.4444444446")!,
            "lb/hp/h": 1 / Decimal(string: "5918352.5016")!,
            "g/hp(m)/h": 1 / 2647795500,
            "g/kW/h": 1 / 3600000000
        ]
        
        guard let fromBase = baseValues[fromUnit], let toBase = baseValues[toUnit] else {
            return value
        }
        
        var result: Decimal
        
        // Convert from input unit to J/kg
        if fromUnit.starts(with: "g/") || fromUnit.starts(with: "lb/") {
            result = 1 / (value * fromBase)
        } else {
            result = value * fromBase
        }
        
        // Convert from J/kg to output unit
        if toUnit.starts(with: "g/") || toUnit.starts(with: "lb/") {
            result = 1 / (result * toBase)
        } else {
            result = result / toBase
        }
        
        return result
    }
    
    private func convertEnergyDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let baseValues: [String: Decimal] = [
            "J/m³": 1,
            "J/L": 1000,
            "MJ/m³": 1000000,
            "kJ/m³": 1000,
            "kcal(IT)/m³": Decimal(string: "4186.800000482")!,
            "cal(IT)/cm³": Decimal(string: "4186800.000482")!,
            "therm/ft³": Decimal(string: "3725894617.319")!,
            "therm/gal(UK)": Decimal(string: "23207984510.267")!,
            "Btu(IT)/ft³": Decimal(string: "37258.945807808")!,
            "Btu(th)/ft³": Decimal(string: "37234.028198186")!,
            "CHU/ft³": Decimal(string: "67066.103121737")!,
            "m³/J": 1,
            "L/J": 0.001,
            "gal(US)/hp": 1 / Decimal(string: "709175035.869")!
        ]
        
        guard let fromBase = baseValues[fromUnit], let toBase = baseValues[toUnit] else {
            return value
        }
        
        var result: Decimal
        
        // Convert from input unit to J/m³
        if fromUnit.starts(with: "m³/") || fromUnit.starts(with: "L/") || fromUnit == "gal(US)/hp" {
            result = 1 / (value * fromBase)
        } else {
            result = value * fromBase
        }
        
        // Convert from J/m³ to output unit
        if toUnit.starts(with: "m³/") || toUnit.starts(with: "L/") || toUnit == "gal(US)/hp" {
            result = 1 / (result * toBase)
        } else {
            result = result / toBase
        }
        
        return result
    }
    
    private func convertTemperature(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kelvin: Decimal
        switch fromUnit.lowercased() {
        case "kelvin", "k":
            kelvin = value
        case "celsius", "°c":
            kelvin = value + Decimal(273.15)
        case "fahrenheit", "°f":
            kelvin = (value - 32) * 5/9 + Decimal(273.15)
        case "rankine", "°r":
            kelvin = value * 5/9
        case "reaumur", "°re", "°ré":
            kelvin = value * 5/4 + Decimal(273.15)
        case "triple point of water", "tw":
            kelvin = value * Decimal(273.16)
        default:
            return value
        }
        
        switch toUnit.lowercased() {
        case "kelvin", "k":
            return kelvin
        case "celsius", "°c":
            return kelvin - Decimal(273.15)
        case "fahrenheit", "°f":
            return (kelvin - Decimal(273.15)) * 9/5 + 32
        case "rankine", "°r":
            return kelvin * 9/5
        case "reaumur", "°re", "°ré":
            return (kelvin - Decimal(273.15)) * 4/5
        case "triple point of water", "tw":
            return kelvin / Decimal(273.16)
        default:
            return value
        }
    }
    
    private func convertThermalExpansionCoefficient(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let perKelvinValues: [String: Decimal] = [
            "1/K": 1,
            "1/°C": 1,
            "1/°F": Decimal(1.8),
            "1/°R": Decimal(1.8),
            "1/°Ré": Decimal(0.8)
        ]
        
        guard let fromValue = perKelvinValues[fromUnit], let toValue = perKelvinValues[toUnit] else {
            return value
        }
        
        let perKelvin = value * fromValue
        return perKelvin / toValue
    }
    
    private func convertThermalResistance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kelvinPerWattValues: [String: Decimal] = [
            "K/W": 1,
            "°F·h/Btu(IT)": Decimal(string: "1.8956342406")!,
            "°F·h/Btu(th)": Decimal(string: "1.8969028295")!,
            "°F·s/Btu(IT)": Decimal(string: "0.0005265651")!,
            "°F·s/Btu(th)": Decimal(string: "0.0005269175")!
        ]
        
        guard let fromValue = kelvinPerWattValues[fromUnit], let toValue = kelvinPerWattValues[toUnit] else {
            return value
        }
        
        let kelvinPerWatt = value * fromValue
        return kelvinPerWatt / toValue
    }
    
    private func convertThermalConductivity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let wattPerMeterKelvinValues: [String: Decimal] = [
            "W/m·K": 1,
            "W/cm·°C": 100,
            "kW/m·K": 1000,
            "cal(IT)/s·cm·°C": Decimal(string: "418.6800000009")!,
            "cal(th)/s·cm·°C": Decimal(string: "418.3999999994")!,
            "kcal(IT)/h·m·°C": Decimal(string: "1.163")!,
            "kcal(th)/h·m·°C": Decimal(string: "1.1622222222")!,
            "Btu(IT)·in/s·ft²·°F": Decimal(string: "519.2203999105")!,
            "Btu(th)·in/s·ft²·°F": Decimal(string: "518.8731616576")!,
            "Btu(IT)·ft/h·ft²·°F": Decimal(string: "1.7307346664")!,
            "Btu(th)·ft/h·ft²·°F": Decimal(string: "1.7295772055")!,
            "Btu(IT)·in/h·ft²·°F": Decimal(string: "0.1442278889")!,
            "Btu(th)·in/h·ft²·°F": Decimal(string: "0.1441314338")!
        ]
        
        guard let fromValue = wattPerMeterKelvinValues[fromUnit], let toValue = wattPerMeterKelvinValues[toUnit] else {
            return value
        }
        
        let wattPerMeterKelvin = value * fromValue
        return wattPerMeterKelvin / toValue
    }
    
    private func convertSpecificHeatCapacity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let joulePerKilogramKelvinValues: [String: Decimal] = [
            "J/kg·K": 1,
            "J/kg·°C": 1,
            "J/g·°C": 1000,
            "kJ/kg·K": 1000,
            "kJ/kg·°C": 1000,
            "cal(IT)/g·°C": Decimal(string: "4186.8000000087")!,
            "cal(IT)/g·°F": Decimal(string: "4186.8000000087")!,
            "cal(th)/g·°C": 4184,
            "kcal(IT)/kg·°C": Decimal(string: "4186.8000000087")!,
            "kcal(th)/kg·°C": 4184,
            "kcal(IT)/kg·K": Decimal(string: "4186.8000000087")!,
            "kcal(th)/kg·K": 4184,
            "kgf·m/kg·K": Decimal(string: "9.80665")!,
            "lbf·ft/lb·°R": Decimal(string: "5.380320456")!,
            "Btu(IT)/lb·°F": Decimal(string: "4186.8000000087")!,
            "Btu(th)/lb·°F": 4184,
            "Btu(IT)/lb·°R": Decimal(string: "4186.8000000087")!,
            "Btu(th)/lb·°R": 4184,
            "Btu(IT)/lb·°C": Decimal(string: "2326.0000001596")!,
            "CHU/lb·°C": Decimal(string: "4186.800000482")!
        ]
        
        guard let fromValue = joulePerKilogramKelvinValues[fromUnit], let toValue = joulePerKilogramKelvinValues[toUnit] else {
            return value
        }
        
        let joulePerKilogramKelvin = value * fromValue
        return joulePerKilogramKelvin / toValue
    }
    
    private func convertRadiationEnergyDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let joulePerSquareMeterValues: [String: Decimal] = [
            "J/m²": 1,
            "cal(th)/cm²": Decimal(string: "41839.999999999")!,
            "Ly": Decimal(string: "41839.999999999")!,
            "Btu(IT)/ft²": Decimal(string: "11356.526682227")!,
            "Btu(th)/ft²": Decimal(string: "11348.931794793")!
        ]
        
        guard let fromValue = joulePerSquareMeterValues[fromUnit], let toValue = joulePerSquareMeterValues[toUnit] else {
            
            return value
        }
        
        let joulePerSquareMeter = value * fromValue
        return joulePerSquareMeter / toValue
    }
    
    private func convertRadiationFluxDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let wattPerSquareMeterValues: [String: Decimal] = [
            "W/m²": 1,
            "kW/m²": 1000,
            "W/cm²": 10000,
            "W/in²": Decimal(string: "1550.0031012075")!,
            "J/s·m²": 1,
            "kcal(IT)/h·m²": Decimal(string: "1.1629999999")!,
            "kcal(IT)/h·ft²": Decimal(string: "12.5184278205")!,
            "cal(IT)/s·cm²": Decimal(string: "41868.00000482")!,
            "cal(IT)/min·cm²": Decimal(string: "697.8000000803")!,
            "cal(IT)/h·cm²": Decimal(string: "11.6300000008")!,
            "cal(th)/s·cm²": Decimal(string: "41839.999999942")!,
            "cal(th)/min·cm²": Decimal(string: "697.3333333314")!,
            "cal(th)/h·cm²": Decimal(string: "11.6222222222")!,
            "dyn/h·cm": Decimal(string: "2.7777777777778E-7")!,
            "erg/h·mm²": Decimal(string: "2.77778E-5")!,
            "ft·lb/min·ft²": Decimal(string: "0.2432317156")!,
            "hp/ft²": Decimal(string: "8026.6466174305")!,
            "hp(m)/ft²": Decimal(string: "7916.8426564296")!,
            "Btu(IT)/s·ft²": Decimal(string: "11356.526682221")!,
            "Btu(IT)/min·ft²": Decimal(string: "189.2754465477")!,
            "Btu(IT)/h·ft²": Decimal(string: "3.1545907451")!,
            "Btu(th)/s·in²": Decimal(string: "1634246.1784508")!,
            "Btu(th)/s·ft²": Decimal(string: "11348.93179479")!,
            "Btu(th)/min·ft²": Decimal(string: "189.1488632466")!,
            "Btu(th)/h·ft²": Decimal(string: "3.1524810541")!,
            "CHU/h·ft²": Decimal(string: "5.6782633986")!
        ]
        
        guard let fromValue = wattPerSquareMeterValues[fromUnit], let toValue = wattPerSquareMeterValues[toUnit] else {
            return value
        }
        
        let wattPerSquareMeter = value * fromValue
        return wattPerSquareMeter / toValue
    }
    
    private func convertHeatTransferCoefficient(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let wattPerSquareMeterKelvinValues: [String: Decimal] = [
            "W/m²·K": 1,
            "W/m²·°C": 1,
            "J/s·m²·K": 1,
            "cal(IT)/s·cm²·°C": Decimal(string: "41868.00000482")!,
            "kcal(IT)/h·m²·°C": Decimal(string: "1.163")!,
            "kcal(IT)/h·ft²·°C": Decimal(string: "12.5184278205")!,
            "Btu(IT)/s·ft²·°F": Decimal(string: "20441.748028012")!,
            "Btu(th)/s·ft²·°F": Decimal(string: "20428.077230618")!,
            "Btu(IT)/h·ft²·°F": Decimal(string: "5.6782633411")!,
            "Btu(th)/h·ft²·°F": Decimal(string: "5.6744658974")!,
            "CHU/h·ft²·°C": Decimal(string: "5.6782633411")!
        ]
        
        guard let fromValue = wattPerSquareMeterKelvinValues[fromUnit], let toValue = wattPerSquareMeterKelvinValues[toUnit] else {
            return value
        }
        
        let wattPerSquareMeterKelvin = value * fromValue
        return wattPerSquareMeterKelvin / toValue
    }
    
    var icon: String {
        switch self {
        case .fuelEfficiencyMass:
            return "gauge"
        case .fuelEfficiencyVolume:
            return "fuelpump"
        case .heatDensity:
            return "flame"
        case .heatFluxDensity:
            return "waveform.path.ecg.rectangle"
        case .heatTransverCoefficient:
            return "thermometer.sun"
        case .spesificHeatCapacity:
            return "flame.circle"
        case .temperatureInterval:
            return "thermometer"
        case .thermalConductivity:
            return "waveform.path"
        case .thermalExpansion:
            return "arrow.up.left.and.arrow.down.right"
        case .thermalResistance:
            return "staroflife.shield"
        }
    }
    
    var info: LocalizedStringKey {
        switch self {
        case .fuelEfficiencyMass:
            return "FuelEfficiencyMassInfo"
        case .fuelEfficiencyVolume:
            return "FuelEfficiencyVolumeInfo"
        case .heatDensity:
            return "HeatDensityInfo"
        case .heatFluxDensity:
            return "HeatFluxDensityInfo"
        case .heatTransverCoefficient:
            return "HeatTransverCoefficientInfo"
        case .spesificHeatCapacity:
            return "SpesificHeatCapacityInfo"
        case .temperatureInterval:
            return "TemperatureInfo"
        case .thermalConductivity:
            return "ThermalConductivityInfo"
        case .thermalExpansion:
            return "ThermalExpansionInfo"
        case .thermalResistance:
            return "ThermalResistanceInfo"
        }
    }
    
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .fuelEfficiencyMass:
            return [
                ("J/kg", String(localized: "joule/kilogram")),
                ("kJ/kg", String(localized: "kilojoule/kilogram")),
                ("cal(IT)/g", String(localized: "calorie (IT)/gram")),
                ("cal(th)/g", String(localized: "calorie (th)/gram")),
                ("Btu(IT)/lb", String(localized: "Btu (IT)/pound")),
                ("Btu(th)/lb", String(localized: "Btu (th)/pound")),
                ("kg/J", String(localized: "kilogram/joule")),
                ("kg/kJ", String(localized: "kilogram/kilojoule")),
                ("g/cal(IT)", String(localized: "gram/calorie (IT)")),
                ("g/cal(th)", String(localized: "gram/calorie (th)")),
                ("lb/Btu(IT)", String(localized: "pound/Btu (IT)")),
                ("lb/Btu(th)", String(localized: "pound/Btu (th)")),
                ("lb/hp/h", String(localized: "pound/horsepower/hour")),
                ("g/hp(m)/h", String(localized: "gram/horsepower (metric)/hour")),
                ("g/kW/h", String(localized: "gram/kilowatt/hour"))
            ]
        case .fuelEfficiencyVolume:
            return [
                ("J/m³", String(localized: "joule/cubic meter")),
                ("J/L", String(localized: "joule/liter")),
                ("MJ/m³", String(localized: "megajoule/cubic meter")),
                ("kJ/m³", String(localized: "kilojoule/cubic meter")),
                ("kcal(IT)/m³", String(localized: "kilocalorie (IT)/cubic meter")),
                ("cal(IT)/cm³", String(localized: "calorie (IT)/cubic centimeter")),
                ("therm/ft³", String(localized: "therm/cubic foot")),
                ("therm/gal(UK)", String(localized: "therm/gallon (UK)")),
                ("Btu(IT)/ft³", String(localized: "Btu (IT)/cubic foot")),
                ("Btu(th)/ft³", String(localized: "Btu (th)/cubic foot")),
                ("CHU/ft³", String(localized: "CHU/cubic foot")),
                ("m³/J", String(localized: "cubic meter/joule")),
                ("L/J", String(localized: "liter/joule")),
                ("gal(US)/hp", String(localized: "gallon (US)/horsepower"))
            ]
        case .temperatureInterval:
            return [
                ("K", String(localized: "Kelvin")),
                ("°C", String(localized: "Celsius")),
                ("°F", String(localized: "Fahrenheit")),
                ("°R", String(localized: "Rankine")),
                ("°Ré", String(localized: "Reaumur")),
                ("Tw", String(localized: "Triple point of water"))
            ]
        case .thermalExpansion:
            return [
                ("1/K", String(localized: "length/length/kelvin")),
                ("1/°C", String(localized: "length/length/degree Celsius")),
                ("1/°F", String(localized: "length/length/degree Fahrenheit")),
                ("1/°R", String(localized: "length/length/degree Rankine")),
                ("1/°Ré", String(localized: "length/length/degree Reaumur"))
            ]
        case .thermalResistance:
            return [
                ("K/W", String(localized: "kelvin/watt")),
                ("°F·h/Btu(IT)", String(localized: "degree Fahrenheit hour/Btu (IT)")),
                ("°F·h/Btu(th)", String(localized: "degree Fahrenheit hour/Btu (th)")),
                ("°F·s/Btu(IT)", String(localized: "degree Fahrenheit second/Btu (IT)")),
                ("°F·s/Btu(th)", String(localized: "degree Fahrenheit second/Btu (th)"))
            ]
        case .thermalConductivity:
            return [
                ("W/m·K", String(localized: "watt/meter/K")),
                ("W/cm·°C", String(localized: "watt/centimeter/°C")),
                ("kW/m·K", String(localized: "kilowatt/meter/K")),
                ("cal(IT)/s·cm·°C", String(localized: "calorie (IT)/second/cm/°C")),
                ("cal(th)/s·cm·°C", String(localized: "calorie (th)/second/cm/°C")),
                ("kcal(IT)/h·m·°C", String(localized: "kilocalorie (IT)/hour/meter/°C")),
                ("kcal(th)/h·m·°C", String(localized: "kilocalorie (th)/hour/meter/°C")),
                ("Btu(IT)·in/s·ft²·°F", String(localized: "Btu (IT) inch/second/sq. foot/°F")),
                ("Btu(th)·in/s·ft²·°F", String(localized: "Btu (th) inch/second/sq. foot/°F")),
                ("Btu(IT)·ft/h·ft²·°F", String(localized: "Btu (IT) foot/hour/sq. foot/°F")),
                ("Btu(th)·ft/h·ft²·°F", String(localized: "Btu (th) foot/hour/sq. foot/°F")),
                ("Btu(IT)·in/h·ft²·°F", String(localized: "Btu (IT) inch/hour/sq. foot/°F")),
                ("Btu(th)·in/h·ft²·°F", String(localized: "Btu (th) inch/hour/sq. foot/°F"))
            ]
        case .spesificHeatCapacity:
            return [
                ("J/kg·K", String(localized: "joule/kilogram/K")),
                ("J/kg·°C", String(localized: "joule/kilogram/°C")),
                ("J/g·°C", String(localized: "joule/gram/°C")),
                ("kJ/kg·K", String(localized: "kilojoule/kilogram/K")),
                ("kJ/kg·°C", String(localized: "kilojoule/kilogram/°C")),
                ("cal(IT)/g·°C", String(localized: "calorie (IT)/gram/°C")),
                ("cal(IT)/g·°F", String(localized: "calorie (IT)/gram/°F")),
                ("cal(th)/g·°C", String(localized: "calorie (th)/gram/°C")),
                ("kcal(IT)/kg·°C", String(localized: "kilocalorie (IT)/kilogram/°C")),
                ("kcal(th)/kg·°C", String(localized: "kilocalorie (th)/kilogram/°C")),
                ("kcal(IT)/kg·K", String(localized: "kilocalorie (IT)/kilogram/K")),
                ("kcal(th)/kg·K", String(localized: "kilocalorie (th)/kilogram/K")),
                ("kgf·m/kg·K", String(localized: "kilogram-force meter/kilogram/K")),
                ("lbf·ft/lb·°R", String(localized: "pound-force foot/pound/°R")),
                ("Btu(IT)/lb·°F", String(localized: "Btu (IT)/pound/°F")),
                ("Btu(th)/lb·°F", String(localized: "Btu (th)/pound/°F")),
                ("Btu(IT)/lb·°R", String(localized: "Btu (IT)/pound/°R")),
                ("Btu(th)/lb·°R", String(localized: "Btu (th)/pound/°R")),
                ("Btu(IT)/lb·°C", String(localized: "Btu (IT)/pound/°C")),
                ("CHU/lb·°C", String(localized: "CHU/pound/°C"))
            ]
        case .heatDensity:
            return [
                ("J/m²", String(localized: "joule/square meter")),
                ("cal(th)/cm²", String(localized: "calorie (th)/square centimeter")),
                ("Ly", String(localized: "langley")),
                ("Btu(IT)/ft²", String(localized: "Btu (IT)/square foot")),
                ("Btu(th)/ft²", String(localized: "Btu (th)/square foot"))
            ]
        case .heatFluxDensity:
            return [
                ("W/m²", String(localized: "watt/square meter")),
                ("kW/m²", String(localized: "kilowatt/square meter")),
                ("W/cm²", String(localized: "watt/square centimeter")),
                ("W/in²", String(localized: "watt/square inch")),
                ("J/s·m²", String(localized: "joule/second/square meter")),
                ("kcal(IT)/h·m²", String(localized: "kilocalorie (IT)/hour/square meter")),
                ("kcal(IT)/h·ft²", String(localized: "kilocalorie (IT)/hour/square foot")),
                ("cal(IT)/s·cm²", String(localized: "calorie (IT)/second/square centimeter")),
                ("cal(IT)/min·cm²", String(localized: "calorie (IT)/minute/square centimeter")),
                ("cal(IT)/h·cm²", String(localized: "calorie (IT)/hour/square centimeter")),
                ("cal(th)/s·cm²", String(localized: "calorie (th)/second/square centimeter")),
                ("cal(th)/min·cm²", String(localized: "calorie (th)/minute/square centimeter")),
                ("cal(th)/h·cm²", String(localized: "calorie (th)/hour/square centimeter")),
                ("dyn/h·cm", String(localized: "dyne/hour/centimeter")),
                ("erg/h·mm²", String(localized: "erg/hour/square millimeter")),
                ("ft·lb/min·ft²", String(localized: "foot pound/minute/square foot")),
                ("hp/ft²", String(localized: "horsepower/square foot")),
                ("hp(m)/ft²", String(localized: "horsepower (metric)/square foot")),
                ("Btu(IT)/s·ft²", String(localized: "Btu (IT)/second/square foot")),
                ("Btu(IT)/min·ft²", String(localized: "Btu (IT)/minute/square foot")),
                ("Btu(IT)/h·ft²", String(localized: "Btu (IT)/hour/square foot")),
                ("Btu(th)/s·in²", String(localized: "Btu (th)/second/square inch")),
                ("Btu(th)/s·ft²", String(localized: "Btu (th)/second/square foot")),
                ("Btu(th)/min·ft²", String(localized: "Btu (th)/minute/square foot")),
                ("Btu(th)/h·ft²", String(localized: "Btu (th)/hour/square foot")),
                ("CHU/h·ft²", String(localized: "CHU/hour/square foot"))
            ]
        case .heatTransverCoefficient:
            return [
                ("W/m²·K", String(localized: "watt/square meter/K")),
                ("W/m²·°C", String(localized: "watt/square meter/°C")),
                ("J/s·m²·K", String(localized: "joule/second/square meter/K")),
                ("cal(IT)/s·cm²·°C", String(localized: "calorie (IT)/second/square centimeter/°C")),
                ("kcal(IT)/h·m²·°C", String(localized: "kilocalorie (IT)/hour/square meter/°C")),
                ("kcal(IT)/h·ft²·°C", String(localized: "kilocalorie (IT)/hour/square foot/°C")),
                ("Btu(IT)/s·ft²·°F", String(localized: "Btu (IT)/second/square foot/°F")),
                ("Btu(th)/s·ft²·°F", String(localized: "Btu (th)/second/square foot/°F")),
                ("Btu(IT)/h·ft²·°F", String(localized: "Btu (IT)/hour/square foot/°F")),
                ("Btu(th)/h·ft²·°F", String(localized: "Btu (th)/hour/square foot/°F")),
                ("CHU/h·ft²·°C", String(localized: "CHU/hour/square foot/°C"))
            ]
        }
    }
}
