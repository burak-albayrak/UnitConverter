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
        let joulePerKilogramValues: [String: Decimal] = [
            "joule/kilogram": 1,
            "kilojoule/kilogram": 1000,
            "calorie (IT)/gram": Decimal(string: "4186.8")!,
            "calorie (th)/gram": Decimal(string: "4184.000000005")!,
            "Btu (IT)/pound": 2326,
            "Btu (th)/pound": Decimal(string: "2324.4444444446")!,
            "kilogram/joule": 1,
            "kilogram/kilojoule": 1000,
            "gram/calorie (IT)": Decimal(string: "4186.8")!,
            "gram/calorie (th)": Decimal(string: "4184.000000005")!,
            "pound/Btu (IT)": 2326,
            "pound/Btu (th)": Decimal(string: "2324.4444444446")!,
            "pound/horsepower/hour": Decimal(string: "5918352.5016")!,
            "gram/horsepower (metric)/hour": 2647795500,
            "gram/kilowatt/hour": 3600000000
        ]

        guard let fromValue = joulePerKilogramValues[fromUnit.lowercased()], let toValue = joulePerKilogramValues[toUnit.lowercased()] else {
            return value
        }

        let joulePerKilogram = value * fromValue
        return joulePerKilogram / toValue
    }
    
    private func convertEnergyDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let joulePerCubicMeterValues: [String: Decimal] = [
            "joule/cubic meter": 1,
            "joule/liter": 1000,
            "megajoule/cubic meter": 1000000,
            "kilojoule/cubic meter": 1000,
            "kilocalorie (IT)/cubic meter": Decimal(string: "4186.800000482")!,
            "calorie (IT)/cubic centimeter": Decimal(string: "4186800.000482")!,
            "therm/cubic foot": Decimal(string: "3725894617.319")!,
            "therm/gallon (UK)": Decimal(string: "23207984510.267")!,
            "Btu (IT)/cubic foot": Decimal(string: "37258.945807808")!,
            "Btu (th)/cubic foot": Decimal(string: "37234.028198186")!,
            "CHU/cubic foot": Decimal(string: "67066.103121737")!,
            "cubic meter/joule": 1,
            "liter/joule": 1000,
            "gallon (US)/horsepower": Decimal(string: "709175035.869")!
        ]

        guard let fromValue = joulePerCubicMeterValues[fromUnit.lowercased()], let toValue = joulePerCubicMeterValues[toUnit.lowercased()] else {
            return value
        }

        let joulePerCubicMeter = value * fromValue
        return joulePerCubicMeter / toValue
    }
    
    private func convertTemperature(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kelvin: Decimal
        
        switch fromUnit.lowercased() {
        case "kelvin", "k":
            kelvin = value
        case "degree celsius", "°c", "degree centigrade":
            kelvin = value + Decimal(273.15)
        case "degree fahrenheit", "°f":
            kelvin = (value - 32) * 5/9 + Decimal(273.15)
        case "degree rankine", "°r":
            kelvin = value * 5/9
        case "degree reaumur", "°re":
            kelvin = value * Decimal(1.25) + Decimal(273.15)
        default:
            return value
        }
        
        switch toUnit.lowercased() {
        case "kelvin", "k":
            return kelvin
        case "degree celsius", "°c", "degree centigrade":
            return kelvin - Decimal(273.15)
        case "degree fahrenheit", "°f":
            return (kelvin - Decimal(273.15)) * 9/5 + 32
        case "degree rankine", "°r":
            return kelvin * Decimal(1.8)
        case "degree reaumur", "°re":
            return (kelvin - Decimal(273.15)) * Decimal(0.8)
        default:
            return value
        }
    }
    
    private func convertThermalExpansionCoefficient(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let perKelvinValues: [String: Decimal] = [
            "length/length/kelvin": 1,
            "length/length/degree celsius": 1,
            "length/length/degree fahrenheit": Decimal(1.8),
            "length/length/degree rankine": Decimal(1.8),
            "length/length/degree reaumur": Decimal(0.8)
        ]

        guard let fromValue = perKelvinValues[fromUnit.lowercased()], let toValue = perKelvinValues[toUnit.lowercased()] else {
            return value
        }

        let perKelvin = value * fromValue
        return perKelvin / toValue
    }
    
    private func convertThermalResistance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kelvinPerWattValues: [String: Decimal] = [
            "kelvin/watt": 1,
            "degree fahrenheit hour/btu (it)": Decimal(string: "1.8956342406")!,
            "degree fahrenheit hour/btu (th)": Decimal(string: "1.8969028295")!,
            "degree fahrenheit second/btu (it)": Decimal(string: "0.0005265651")!,
            "degree fahrenheit second/btu (th)": Decimal(string: "0.0005269175")!
        ]

        guard let fromValue = kelvinPerWattValues[fromUnit.lowercased()], let toValue = kelvinPerWattValues[toUnit.lowercased()] else {
            return value
        }

        let kelvinPerWatt = value * fromValue
        return kelvinPerWatt / toValue
    }
    
    private func convertThermalConductivity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let wattPerMeterKelvinValues: [String: Decimal] = [
            "watt/meter/K": 1,
            "watt/centimeter/°C": 100,
            "kilowatt/meter/K": 1000,
            "calorie (IT)/second/cm/°C": Decimal(string: "418.6800000009")!,
            "calorie (th)/second/cm/°C": Decimal(string: "418.3999999994")!,
            "kilocalorie (IT)/hour/meter/°C": Decimal(string: "1.163")!,
            "kilocalorie (th)/hour/meter/°C": Decimal(string: "1.1622222222")!,
            "Btu (IT) inch/second/sq. foot/°F": Decimal(string: "519.2203999105")!,
            "Btu (th) inch/second/sq. foot/°F": Decimal(string: "518.8731616576")!,
            "Btu (IT) foot/hour/sq. foot/°F": Decimal(string: "1.7307346664")!,
            "Btu (th) foot/hour/sq. foot/°F": Decimal(string: "1.7295772055")!,
            "Btu (IT) inch/hour/sq. foot/°F": Decimal(string: "0.1442278889")!,
            "Btu (th) inch/hour/sq. foot/°F": Decimal(string: "0.1441314338")!
        ]

        guard let fromValue = wattPerMeterKelvinValues[fromUnit.lowercased()], let toValue = wattPerMeterKelvinValues[toUnit.lowercased()] else {
            return value
        }

        let wattPerMeterKelvin = value * fromValue
        return wattPerMeterKelvin / toValue
    }
    
    private func convertSpecificHeatCapacity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let joulePerKilogramKelvinValues: [String: Decimal] = [
            "joule/kilogram/K": 1,
            "joule/kilogram/°C": 1,
            "joule/gram/°C": 1000,
            "kilojoule/kilogram/K": 1000,
            "kilojoule/kilogram/°C": 1000,
            "calorie (IT)/gram/°C": Decimal(string: "4186.8000000087")!,
            "calorie (IT)/gram/°F": Decimal(string: "4186.8000000087")!,
            "calorie (th)/gram/°C": 4184,
            "kilocalorie (IT)/kilogram/°C": Decimal(string: "4186.8000000087")!,
            "kilocalorie (th)/kilogram/°C": 4184,
            "kilocalorie (IT)/kilogram/K": Decimal(string: "4186.8000000087")!,
            "kilocalorie (th)/kilogram/K": 4184,
            "kilogram-force meter/kilogram/K": Decimal(string: "9.80665")!,
            "pound-force foot/pound/°R": Decimal(string: "5.380320456")!,
            "Btu (IT)/pound/°F": Decimal(string: "4186.8000000087")!,
            "Btu (th)/pound/°F": 4184,
            "Btu (IT)/pound/°R": Decimal(string: "4186.8000000087")!,
            "Btu (th)/pound/°R": 4184,
            "Btu (IT)/pound/°C": Decimal(string: "2326.0000001596")!,
            "CHU/pound/°C": Decimal(string: "4186.800000482")!
        ]

        guard let fromValue = joulePerKilogramKelvinValues[fromUnit.lowercased()], let toValue = joulePerKilogramKelvinValues[toUnit.lowercased()] else {
            return value
        }

        let joulePerKilogramKelvin = value * fromValue
        return joulePerKilogramKelvin / toValue
    }
    
    private func convertRadiationEnergyDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let joulePerSquareMeterValues: [String: Decimal] = [
            "joule/square meter": 1,
            "calorie (th)/square centimeter": Decimal(string: "41839.999999999")!,
            "langley": Decimal(string: "41839.999999999")!,
            "Btu (IT)/square foot": Decimal(string: "11356.526682227")!,
            "Btu (th)/square foot": Decimal(string: "11348.931794793")!
        ]

        guard let fromValue = joulePerSquareMeterValues[fromUnit.lowercased()], let toValue = joulePerSquareMeterValues[toUnit.lowercased()] else {
            return value
        }

        let joulePerSquareMeter = value * fromValue
        return joulePerSquareMeter / toValue
    }
    
    private func convertRadiationFluxDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let wattPerSquareMeterValues: [String: Decimal] = [
            "watt/square meter": 1,
            "kilowatt/square meter": 1000,
            "watt/square centimeter": 10000,
            "watt/square inch": Decimal(string: "1550.0031012075")!,
            "joule/second/square meter": 1,
            "kilocalorie (IT)/hour/square meter": Decimal(string: "1.1629999999")!,
            "kilocalorie (IT)/hour/square foot": Decimal(string: "12.5184278205")!,
            "calorie (IT)/second/square centimeter": Decimal(string: "41868.00000482")!,
            "calorie (IT)/minute/square centimeter": Decimal(string: "697.8000000803")!,
            "calorie (IT)/hour/square centimeter": Decimal(string: "11.6300000008")!,
            "calorie (th)/second/square centimeter": Decimal(string: "41839.999999942")!,
            "calorie (th)/minute/square centimeter": Decimal(string: "697.3333333314")!,
            "calorie (th)/hour/square centimeter": Decimal(string: "11.6222222222")!,
            "dyne/hour/centimeter": Decimal(string: "2.7777777777778E-7")!,
            "erg/hour/square millimeter": Decimal(string: "2.77778E-5")!,
            "foot pound/minute/square foot": Decimal(string: "0.2432317156")!,
            "horsepower/square foot": Decimal(string: "8026.6466174305")!,
            "horsepower (metric)/square foot": Decimal(string: "7916.8426564296")!,
            "Btu (IT)/second/square foot": Decimal(string: "11356.526682221")!,
            "Btu (IT)/minute/square foot": Decimal(string: "189.2754465477")!,
            "Btu (IT)/hour/square foot": Decimal(string: "3.1545907451")!,
            "Btu (th)/second/square inch": Decimal(string: "1634246.1784508")!,
            "Btu (th)/second/square foot": Decimal(string: "11348.93179479")!,
            "Btu (th)/minute/square foot": Decimal(string: "189.1488632466")!,
            "Btu (th)/hour/square foot": Decimal(string: "3.1524810541")!,
            "CHU/hour/square foot": Decimal(string: "5.6782633986")!
        ]

        guard let fromValue = wattPerSquareMeterValues[fromUnit.lowercased()], let toValue = wattPerSquareMeterValues[toUnit.lowercased()] else {
            return value
        }

        let wattPerSquareMeter = value * fromValue
        return wattPerSquareMeter / toValue
    }
    
    private func convertHeatTransferCoefficient(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let wattPerSquareMeterKelvinValues: [String: Decimal] = [
            "watt/square meter/K": 1,
            "watt/square meter/°C": 1,
            "joule/second/square meter/K": 1,
            "calorie (IT)/second/square centimeter/°C": Decimal(string: "41868.00000482")!,
            "kilocalorie (IT)/hour/square meter/°C": Decimal(string: "1.163")!,
            "kilocalorie (IT)/hour/square foot/°C": Decimal(string: "12.5184278205")!,
            "Btu (IT)/second/square foot/°F": Decimal(string: "20441.748028012")!,
            "Btu (th)/second/square foot/°F": Decimal(string: "20428.077230618")!,
            "Btu (IT)/hour/square foot/°F": Decimal(string: "5.6782633411")!,
            "Btu (th)/hour/square foot/°F": Decimal(string: "5.6744658974")!,
            "CHU/hour/square foot/°C": Decimal(string: "5.6782633411")!
        ]

        guard let fromValue = wattPerSquareMeterKelvinValues[fromUnit.lowercased()], let toValue = wattPerSquareMeterKelvinValues[toUnit.lowercased()] else {
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
            return "waveform.path.badge.plus"
        case .heatTransverCoefficient:
            return "thermometer"
        case .spesificHeatCapacity:
            return "flame.circle"
        case .temperatureInterval:
            return "thermometer.sun"
        case .thermalConductivity:
            return "waveform.path"
        case .thermalExpansion:
            return "arrow.up.right.circle"
        case .thermalResistance:
            return "snowflake"
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
                ("J/kg", "joule/kilogram"),
                ("kJ/kg", "kilojoule/kilogram"),
                ("cal(IT)/g", "calorie (IT)/gram"),
                ("cal(th)/g", "calorie (th)/gram"),
                ("Btu(IT)/lb", "Btu (IT)/pound"),
                ("Btu(th)/lb", "Btu (th)/pound"),
                ("kg/J", "kilogram/joule"),
                ("kg/kJ", "kilogram/kilojoule"),
                ("g/cal(IT)", "gram/calorie (IT)"),
                ("g/cal(th)", "gram/calorie (th)"),
                ("lb/Btu(IT)", "pound/Btu (IT)"),
                ("lb/Btu(th)", "pound/Btu (th)"),
                ("lb/hp/h", "pound/horsepower/hour"),
                ("g/hp(m)/h", "gram/horsepower (metric)/hour"),
                ("g/kW/h", "gram/kilowatt/hour")
            ]
        case .fuelEfficiencyVolume:
            return [
                ("J/m³", "joule/cubic meter"),
                ("J/L", "joule/liter"),
                ("MJ/m³", "megajoule/cubic meter"),
                ("kJ/m³", "kilojoule/cubic meter"),
                ("kcal(IT)/m³", "kilocalorie (IT)/cubic meter"),
                ("cal(IT)/cm³", "calorie (IT)/cubic centimeter"),
                ("therm/ft³", "therm/cubic foot"),
                ("therm/gal(UK)", "therm/gallon (UK)"),
                ("Btu(IT)/ft³", "Btu (IT)/cubic foot"),
                ("Btu(th)/ft³", "Btu (th)/cubic foot"),
                ("CHU/ft³", "CHU/cubic foot"),
                ("m³/J", "cubic meter/joule"),
                ("L/J", "liter/joule"),
                ("gal(US)/hp", "gallon (US)/horsepower")
            ]
        case .temperatureInterval:
            return [
                ("K", "kelvin"),
                ("°C", "degree Celsius"),
                ("°C", "degree centigrade"),
                ("°F", "degree Fahrenheit"),
                ("°R", "degree Rankine"),
                ("°Ré", "degree Reaumur")
            ]
        case .thermalExpansion:
            return [
                ("1/K", "length/length/kelvin"),
                ("1/°C", "length/length/degree Celsius"),
                ("1/°F", "length/length/degree Fahrenheit"),
                ("1/°R", "length/length/degree Rankine"),
                ("1/°Ré", "length/length/degree Reaumur")
            ]
        case .thermalResistance:
            return [
                ("K/W", "kelvin/watt"),
                ("°F·h/Btu(IT)", "degree Fahrenheit hour/Btu (IT)"),
                ("°F·h/Btu(th)", "degree Fahrenheit hour/Btu (th)"),
                ("°F·s/Btu(IT)", "degree Fahrenheit second/Btu (IT)"),
                ("°F·s/Btu(th)", "degree Fahrenheit second/Btu (th)")
            ]
        case .thermalConductivity:
            return [
                ("W/m·K", "watt/meter/K"),
                ("W/cm·°C", "watt/centimeter/°C"),
                ("kW/m·K", "kilowatt/meter/K"),
                ("cal(IT)/s·cm·°C", "calorie (IT)/second/cm/°C"),
                ("cal(th)/s·cm·°C", "calorie (th)/second/cm/°C"),
                ("kcal(IT)/h·m·°C", "kilocalorie (IT)/hour/meter/°C"),
                ("kcal(th)/h·m·°C", "kilocalorie (th)/hour/meter/°C"),
                ("Btu(IT)·in/s·ft²·°F", "Btu (IT) inch/second/sq. foot/°F"),
                ("Btu(th)·in/s·ft²·°F", "Btu (th) inch/second/sq. foot/°F"),
                ("Btu(IT)·ft/h·ft²·°F", "Btu (IT) foot/hour/sq. foot/°F"),
                ("Btu(th)·ft/h·ft²·°F", "Btu (th) foot/hour/sq. foot/°F"),
                ("Btu(IT)·in/h·ft²·°F", "Btu (IT) inch/hour/sq. foot/°F"),
                ("Btu(th)·in/h·ft²·°F", "Btu (th) inch/hour/sq. foot/°F")
            ]
        case .spesificHeatCapacity:
            return [
                ("J/kg·K", "joule/kilogram/K"),
                ("J/kg·°C", "joule/kilogram/°C"),
                ("J/g·°C", "joule/gram/°C"),
                ("kJ/kg·K", "kilojoule/kilogram/K"),
                ("kJ/kg·°C", "kilojoule/kilogram/°C"),
                ("cal(IT)/g·°C", "calorie (IT)/gram/°C"),
                ("cal(IT)/g·°F", "calorie (IT)/gram/°F"),
                ("cal(th)/g·°C", "calorie (th)/gram/°C"),
                ("kcal(IT)/kg·°C", "kilocalorie (IT)/kilogram/°C"),
                ("kcal(th)/kg·°C", "kilocalorie (th)/kilogram/°C"),
                ("kcal(IT)/kg·K", "kilocalorie (IT)/kilogram/K"),
                ("kcal(th)/kg·K", "kilocalorie (th)/kilogram/K"),
                ("kgf·m/kg·K", "kilogram-force meter/kilogram/K"),
                ("lbf·ft/lb·°R", "pound-force foot/pound/°R"),
                ("Btu(IT)/lb·°F", "Btu (IT)/pound/°F"),
                ("Btu(th)/lb·°F", "Btu (th)/pound/°F"),
                ("Btu(IT)/lb·°R", "Btu (IT)/pound/°R"),
                ("Btu(th)/lb·°R", "Btu (th)/pound/°R"),
                ("Btu(IT)/lb·°C", "Btu (IT)/pound/°C"),
                ("CHU/lb·°C", "CHU/pound/°C")
            ]
        case .heatDensity:
            return [
                ("J/m²", "joule/square meter"),
                ("cal(th)/cm²", "calorie (th)/square centimeter"),
                ("Ly", "langley"),
                ("Btu(IT)/ft²", "Btu (IT)/square foot"),
                ("Btu(th)/ft²", "Btu (th)/square foot")
            ]
        case .heatFluxDensity:
            return [
                ("W/m²", "watt/square meter"),
                ("kW/m²", "kilowatt/square meter"),
                ("W/cm²", "watt/square centimeter"),
                ("W/in²", "watt/square inch"),
                ("J/s·m²", "joule/second/square meter"),
                ("kcal(IT)/h·m²", "kilocalorie (IT)/hour/square meter"),
                ("kcal(IT)/h·ft²", "kilocalorie (IT)/hour/square foot"),
                ("cal(IT)/s·cm²", "calorie (IT)/second/square centimeter"),
                ("cal(IT)/min·cm²", "calorie (IT)/minute/square centimeter"),
                ("cal(IT)/h·cm²", "calorie (IT)/hour/square centimeter"),
                ("cal(th)/s·cm²", "calorie (th)/second/square centimeter"),
                ("cal(th)/min·cm²", "calorie (th)/minute/square centimeter"),
                ("cal(th)/h·cm²", "calorie (th)/hour/square centimeter"),
                ("dyn/h·cm", "dyne/hour/centimeter"),
                ("erg/h·mm²", "erg/hour/square millimeter"),
                ("ft·lb/min·ft²", "foot pound/minute/square foot"),
                ("hp/ft²", "horsepower/square foot"),
                ("hp(m)/ft²", "horsepower (metric)/square foot"),
                ("Btu(IT)/s·ft²", "Btu (IT)/second/square foot"),
                ("Btu(IT)/min·ft²", "Btu (IT)/minute/square foot"),
                ("Btu(IT)/h·ft²", "Btu (IT)/hour/square foot"),
                ("Btu(th)/s·in²", "Btu (th)/second/square inch"),
                ("Btu(th)/s·ft²", "Btu (th)/second/square foot"),
                ("Btu(th)/min·ft²", "Btu (th)/minute/square foot"),
                ("Btu(th)/h·ft²", "Btu (th)/hour/square foot"),
                ("CHU/h·ft²", "CHU/hour/square foot")
            ]
        case .heatTransverCoefficient:
            return [
                ("W/m²·K", "watt/square meter/K"),
                ("W/m²·°C", "watt/square meter/°C"),
                ("J/s·m²·K", "joule/second/square meter/K"),
                ("cal(IT)/s·cm²·°C", "calorie (IT)/second/square centimeter/°C"),
                ("kcal(IT)/h·m²·°C", "kilocalorie (IT)/hour/square meter/°C"),
                ("kcal(IT)/h·ft²·°C", "kilocalorie (IT)/hour/square foot/°C"),
                ("Btu(IT)/s·ft²·°F", "Btu (IT)/second/square foot/°F"),
                ("Btu(th)/s·ft²·°F", "Btu (th)/second/square foot/°F"),
                ("Btu(IT)/h·ft²·°F", "Btu (IT)/hour/square foot/°F"),
                ("Btu(th)/h·ft²·°F", "Btu (th)/hour/square foot/°F"),
                ("CHU/h·ft²·°C", "CHU/hour/square foot/°C")
            ]
        }
    }
}
