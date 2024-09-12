//
//  ElectricityUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation
import SwiftUI

enum ElectricityUnitsCategory: String, CaseIterable, UnitCategory {
    case charge = "Charge"
    case linearChargeDensity = "Linear Charge Density"
    case surfaceChargeDensity = "Surface Charge Density"
    case volumeChargeDensity = "Volume Charge Density"
    case current = "Current"
    case linearCurrentDensity = "Linear Current Density"
    case surfaceCurrentDensity = "Surface Current Density"
    case electricFieldStrength = "Electric Field Strength"
    case electricPotential = "Electric Potential"
    case electricResistance = "Electric Resistance"
    case electricResistivity = "Electric Resistivity"
    case electricConductance = "Electric Conductance"
    case electricConductivity = "Electric Conductivity"
    case electrostaticCapacitance = "Electrostatic Capacitance"
    case inductance = "Inductance"
    
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
    
    func convert(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        switch self {
        case .charge:
            return convertElectricCharge(value, from: fromUnit, to: toUnit)
        case .linearChargeDensity:
            return convertElectricChargeDensity(value, from: fromUnit, to: toUnit)
        case .surfaceChargeDensity:
            return convertSurfaceElectricChargeDensity(value, from: fromUnit, to: toUnit)
        case .volumeChargeDensity:
            return convertVolumetricElectricChargeDensity(value, from: fromUnit, to: toUnit)
        case .current:
            return convertElectricCurrent(value, from: fromUnit, to: toUnit)
        case .linearCurrentDensity:
            return convertMagneticFieldIntensity(value, from: fromUnit, to: toUnit)
        case .surfaceCurrentDensity:
            return convertElectricCurrentDensity(value, from: fromUnit, to: toUnit)
        case .electricFieldStrength:
            return convertElectricFieldStrength(value, from: fromUnit, to: toUnit)
        case .electricPotential:
            return convertElectricPotential(value, from: fromUnit, to: toUnit)
        case .electricResistance:
            return convertElectricResistance(value, from: fromUnit, to: toUnit)
        case .electricResistivity:
            return convertElectricResistivity(value, from: fromUnit, to: toUnit)
        case .electricConductance:
            return convertElectricConductance(value, from: fromUnit, to: toUnit)
        case .electricConductivity:
            return convertElectricConductivity(value, from: fromUnit, to: toUnit)
        case .electrostaticCapacitance:
            return convertElectricCapacitance(value, from: fromUnit, to: toUnit)
        case .inductance:
            return convertElectricInductance(value, from: fromUnit, to: toUnit)
        }
    }
    
    private func convertElectricCharge(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let coulombValues: [String: Decimal] = [
            "coulomb": 1,
            "megacoulomb": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kilocoulomb": Decimal(sign: .plus, exponent: 3, significand: 1),
            "millicoulomb": Decimal(sign: .minus, exponent: 3, significand: 1),
            "microcoulomb": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nanocoulomb": Decimal(sign: .minus, exponent: 9, significand: 1),
            "picocoulomb": Decimal(sign: .minus, exponent: 12, significand: 1),
            "abcoulomb": 10,
            "EMU of charge": 10,
            "statcoulomb": Decimal(string: "3.335640951982e-10")!,
            "ESU of charge": Decimal(string: "3.335640951982e-10")!,
            "franklin": Decimal(string: "3.335640951982e-10")!,
            "ampere-hour": 3600,
            "ampere-minute": 60,
            "ampere-second": 1,
            "faraday (based on carbon 12)": Decimal(string: "96485.309000004")!,
            "Elementary charge": Decimal(string: "1.60217733e-19")!
        ]

        guard let fromValue = coulombValues[fromUnit.lowercased()], let toValue = coulombValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let coulombs = value * fromValue
        return coulombs / toValue
    }
    
    private func convertElectricChargeDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let coulombPerMeterValues: [String: Decimal] = [
            "coulomb/meter": 1,
            "coulomb/centimeter": 100,
            "coulomb/inch": Decimal(string: "39.3700787402")!,
            "abcoulomb/meter": 10,
            "abcoulomb/centimeter": 1000,
            "abcoulomb/inch": Decimal(string: "393.7007874016")!
        ]

        guard let fromValue = coulombPerMeterValues[fromUnit.lowercased()], let toValue = coulombPerMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let coulombsPerMeter = value * fromValue
        return coulombsPerMeter / toValue
    }
    
    private func convertSurfaceElectricChargeDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let coulombPerSquareMeterValues: [String: Decimal] = [
            "coulomb/square meter": 1,
            "coulomb/square centimeter": 10000,
            "coulomb/square inch": Decimal(string: "1550.0031000062")!,
            "abcoulomb/square meter": 10,
            "abcoulomb/square centimeter": 100000,
            "abcoulomb/square inch": Decimal(string: "15500.031000062")!
        ]
        
        guard let fromValue = coulombPerSquareMeterValues[fromUnit.lowercased()], let toValue = coulombPerSquareMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let coulombsPerSquareMeter = value * fromValue
        return coulombsPerSquareMeter / toValue
    }
    
    private func convertVolumetricElectricChargeDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let coulombPerCubicMeterValues: [String: Decimal] = [
            "coulomb/cubic meter": 1,
            "coulomb/cubic centimeter": Decimal(sign: .plus, exponent: 6, significand: 1),
            "coulomb/cubic inch": Decimal(string: "61023.744094732")!,
            "abcoulomb/cubic meter": 10,
            "abcoulomb/cubic centimeter": Decimal(sign: .plus, exponent: 7, significand: 1),
            "abcoulomb/cubic inch": Decimal(string: "610237.44094732")!
        ]
        
        guard let fromValue = coulombPerCubicMeterValues[fromUnit.lowercased()], let toValue = coulombPerCubicMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let coulombsPerCubicMeter = value * fromValue
        return coulombsPerCubicMeter / toValue
    }
    
    private func convertElectricCurrent(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let ampereValues: [String: Decimal] = [
            "ampere": 1,
            "kiloampere": Decimal(sign: .plus, exponent: 3, significand: 1),
            "milliampere": Decimal(sign: .minus, exponent: 3, significand: 1),
            "biot": 10,
            "abampere": 10,
            "EMU of current": 10,
            "statampere": Decimal(string: "3.335641e-10")!,
            "ESU of current": Decimal(string: "3.335641e-10")!,
            "CGS e.m. unit": 10,
            "CGS e.s. unit": Decimal(string: "3.335641e-10")!
        ]
        
        guard let fromValue = ampereValues[fromUnit.lowercased()], let toValue = ampereValues[toUnit.lowercased()] else {
            return value
        }
        
        let amperes = value * fromValue
        return amperes / toValue
    }
    
    private func convertMagneticFieldIntensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let amperePerMeterValues: [String: Decimal] = [
            "ampere/meter": 1,
            "ampere/centimeter": 100,
            "ampere/inch": Decimal(string: "39.3700787402")!,
            "abampere/meter": 10,
            "abampere/centimeter": 1000,
            "abampere/inch": Decimal(string: "393.7007874016")!,
            "oersted": Decimal(string: "79.5774715102")!,
            "gilbert/centimeter": Decimal(string: "79.5774715102")!
        ]
        
        guard let fromValue = amperePerMeterValues[fromUnit.lowercased()], let toValue = amperePerMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let amperesPerMeter = value * fromValue
        return amperesPerMeter / toValue
    }
    
    private func convertElectricCurrentDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let amperePerSquareMeterValues: [String: Decimal] = [
            "ampere/square meter": 1,
            "ampere/square centimeter": 10000,
            "ampere/square inch": Decimal(string: "1550.0031000062")!,
            "ampere/square mil": Decimal(string: "1550003100.0062")!,
            "ampere/circular mil": Decimal(string: "1973525240.9908")!,
            "abampere/square centimeter": 100000
        ]
        
        guard let fromValue = amperePerSquareMeterValues[fromUnit.lowercased()], let toValue = amperePerSquareMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let amperesPerSquareMeter = value * fromValue
        return amperesPerSquareMeter / toValue
    }
    
    private func convertElectricFieldStrength(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let voltPerMeterValues: [String: Decimal] = [
            "volt/meter": 1,
            "kilovolt/meter": 1000,
            "kilovolt/centimeter": 100000,
            "volt/centimeter": 100,
            "millivolt/meter": Decimal(sign: .minus, exponent: 3, significand: 1),
            "microvolt/meter": Decimal(sign: .minus, exponent: 6, significand: 1),
            "kilovolt/inch": Decimal(string: "39370.078740157")!,
            "volt/inch": Decimal(string: "39.3700787402")!,
            "volt/mil": Decimal(string: "39370.078740157")!,
            "abvolt/centimeter": Decimal(sign: .minus, exponent: 6, significand: 1),
            "statvolt/centimeter": Decimal(string: "29979.19999934")!,
            "statvolt/inch": Decimal(string: "11802.834645298")!,
            "newton/coulomb": 1
        ]
        
        guard let fromValue = voltPerMeterValues[fromUnit.lowercased()], let toValue = voltPerMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let voltsPerMeter = value * fromValue
        return voltsPerMeter / toValue
    }
    
    private func convertElectricPotential(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let voltValues: [String: Decimal] = [
            "volt": 1,
            "watt/ampere": 1,
            "abvolt": Decimal(sign: .minus, exponent: 8, significand: 1),
            "EMU of electric potential": Decimal(sign: .minus, exponent: 8, significand: 1),
            "statvolt": Decimal(string: "299.7925")!,
            "ESU of electric potential": Decimal(string: "299.7925")!
        ]
        
        guard let fromValue = voltValues[fromUnit.lowercased()], let toValue = voltValues[toUnit.lowercased()] else {
            return value
        }
        
        let volts = value * fromValue
        return volts / toValue
    }
    
    private func convertElectricResistance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let ohmValues: [String: Decimal] = [
            "ohm": 1,
            "megohm": Decimal(sign: .plus, exponent: 6, significand: 1),
            "microhm": Decimal(sign: .minus, exponent: 6, significand: 1),
            "volt/ampere": 1,
            "reciprocal siemens": 1,
            "abohm": Decimal(sign: .minus, exponent: 9, significand: 1),
            "EMU of resistance": Decimal(sign: .minus, exponent: 9, significand: 1),
            "statohm": Decimal(string: "898755200000")!,
            "ESU of resistance": Decimal(string: "898755200000")!,
            "Quantized Hall resistance": Decimal(string: "25812.8056")!
        ]
        
        guard let fromValue = ohmValues[fromUnit.lowercased()], let toValue = ohmValues[toUnit.lowercased()] else {
            return value
        }
        
        let ohms = value * fromValue
        return ohms / toValue
    }
    
    private func convertElectricResistivity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let ohmMeterValues: [String: Decimal] = [
            "ohm meter": 1,
            "ohm centimeter": Decimal(string: "0.01")!,
            "ohm inch": Decimal(string: "0.0254")!,
            "microhm centimeter": Decimal(sign: .minus, exponent: 8, significand: 1),
            "microhm inch": Decimal(string: "2.5400000000102e-8")!,
            "abohm centimeter": Decimal(sign: .minus, exponent: 11, significand: 1),
            "statohm centimeter": Decimal(string: "8987524324.0156")!,
            "circular mil ohm/foot": Decimal(string: "1.6624261130101e-9")!
        ]
        
        guard let fromValue = ohmMeterValues[fromUnit.lowercased()], let toValue = ohmMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let ohmMeters = value * fromValue
        return ohmMeters / toValue
    }
    
    private func convertElectricConductance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let siemensValues: [String: Decimal] = [
            "siemens": 1,
            "megasiemens": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kilosiemens": Decimal(sign: .plus, exponent: 3, significand: 1),
            "millisiemens": Decimal(sign: .minus, exponent: 3, significand: 1),
            "microsiemens": Decimal(sign: .minus, exponent: 6, significand: 1),
            "ampere/volt": 1,
            "mho": 1,
            "gemmho": Decimal(sign: .minus, exponent: 6, significand: 1),
            "micromho": Decimal(sign: .minus, exponent: 6, significand: 1),
            "abmho": Decimal(sign: .plus, exponent: 9, significand: 1),
            "statmho": Decimal(string: "1.1123470522803e-12")!,
            "Quantized Hall conductance": Decimal(string: "3.87405e-5")!
        ]
        
        guard let fromValue = siemensValues[fromUnit.lowercased()], let toValue = siemensValues[toUnit.lowercased()] else {
            return value
        }
        
        let siemens = value * fromValue
        return siemens / toValue
    }
    
    private func convertElectricConductivity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let siemensPerMeterValues: [String: Decimal] = [
            "siemens/meter": 1,
            "picosiemens/meter": Decimal(sign: .minus, exponent: 12, significand: 1),
            "mho/meter": 1,
            "mho/centimeter": 100,
            "abmho/meter": Decimal(sign: .plus, exponent: 9, significand: 1),
            "abmho/centimeter": Decimal(sign: .plus, exponent: 11, significand: 1),
            "statmho/meter": Decimal(string: "1.1126534560019e-12")!,
            "statmho/centimeter": Decimal(string: "1.1126534560019e-10")!
        ]
        
        guard let fromValue = siemensPerMeterValues[fromUnit.lowercased()], let toValue = siemensPerMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let siemensPerMeter = value * fromValue
        return siemensPerMeter / toValue
    }
    
    private func convertElectricCapacitance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let faradValues: [String: Decimal] = [
            "farad": 1,
            "exafarad": Decimal(sign: .plus, exponent: 18, significand: 1),
            "petafarad": Decimal(sign: .plus, exponent: 15, significand: 1),
            "terafarad": Decimal(sign: .plus, exponent: 12, significand: 1),
            "gigafarad": Decimal(sign: .plus, exponent: 9, significand: 1),
            "megafarad": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kilofarad": Decimal(sign: .plus, exponent: 3, significand: 1),
            "hectofarad": Decimal(sign: .plus, exponent: 2, significand: 1),
            "dekafarad": Decimal(sign: .plus, exponent: 1, significand: 1),
            "decifarad": Decimal(sign: .minus, exponent: 1, significand: 1),
            "centifarad": Decimal(sign: .minus, exponent: 2, significand: 1),
            "millifarad": Decimal(sign: .minus, exponent: 3, significand: 1),
            "microfarad": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nanofarad": Decimal(sign: .minus, exponent: 9, significand: 1),
            "picofarad": Decimal(sign: .minus, exponent: 12, significand: 1),
            "femtofarad": Decimal(sign: .minus, exponent: 15, significand: 1),
            "attofarad": Decimal(sign: .minus, exponent: 18, significand: 1),
            "coulomb/volt": 1,
            "abfarad": Decimal(sign: .plus, exponent: 9, significand: 1),
            "EMU of capacitance": Decimal(sign: .plus, exponent: 9, significand: 1),
            "statfarad": Decimal(string: "1.112650056054e-12")!,
            "ESU of capacitance": Decimal(string: "1.112650056054e-12")!
        ]
        
        guard let fromValue = faradValues[fromUnit.lowercased()], let toValue = faradValues[toUnit.lowercased()] else {
            return value
        }
        
        let farads = value * fromValue
        return farads / toValue
    }
    
    private func convertElectricInductance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let henryValues: [String: Decimal] = [
            "henry": 1,
            "exahenry": Decimal(sign: .plus, exponent: 18, significand: 1),
            "petahenry": Decimal(sign: .plus, exponent: 15, significand: 1),
            "terahenry": Decimal(sign: .plus, exponent: 12, significand: 1),
            "gigahenry": Decimal(sign: .plus, exponent: 9, significand: 1),
            "megahenry": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kilohenry": Decimal(sign: .plus, exponent: 3, significand: 1),
            "hectohenry": Decimal(sign: .plus, exponent: 2, significand: 1),
            "dekahenry": Decimal(sign: .plus, exponent: 1, significand: 1),
            "decihenry": Decimal(sign: .minus, exponent: 1, significand: 1),
            "centihenry": Decimal(sign: .minus, exponent: 2, significand: 1),
            "millihenry": Decimal(sign: .minus, exponent: 3, significand: 1),
            "microhenry": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nanohenry": Decimal(sign: .minus, exponent: 9, significand: 1),
            "picohenry": Decimal(sign: .minus, exponent: 12, significand: 1),
            "femtohenry": Decimal(sign: .minus, exponent: 15, significand: 1),
            "attohenry": Decimal(sign: .minus, exponent: 18, significand: 1),
            "weber/ampere": 1,
            "abhenry": Decimal(sign: .minus, exponent: 9, significand: 1),
            "EMU of inductance": Decimal(sign: .minus, exponent: 9, significand: 1),
            "stathenry": Decimal(string: "898755200000")!,
            "ESU of inductance": Decimal(string: "898755200000")!
        ]
        
        guard let fromValue = henryValues[fromUnit.lowercased()], let toValue = henryValues[toUnit.lowercased()] else {
            return value
        }
        
        let henries = value * fromValue
        return henries / toValue
    }
    
    var icon: String {
        switch self {
        case .charge:
            return "bolt.circle"
        case .current:
            return "wave.3.forward"
        case .electricConductance:
            return "dot.radiowaves.right"
        case .electricConductivity:
            return "antenna.radiowaves.left.and.right"
        case .electricFieldStrength:
            return "waveform.path.ecg"
        case .electricPotential:
            return "bolt"
        case .electricResistance:
            return "bolt.horizontal"
        case .electricResistivity:
            return "waveform.path.badge.minus"
        case .electrostaticCapacitance:
            return "capsule.portrait"
        case .inductance:
            return "waveform.path.badge.plus"
        case .linearChargeDensity:
            return "ruler"
        case .linearCurrentDensity:
            return "cable.connector.horizontal"
        case .surfaceChargeDensity:
            return "rectangle.grid.2x2"
        case .surfaceCurrentDensity:
            return "rectangle.grid.3x2"
        case .volumeChargeDensity:
            return "cube.box"
        }
    }
    
    var info: LocalizedStringKey {
        switch self {
        case .charge:
            return "ChargeInfo"
        case .current:
            return "CurrentInfo"
        case .electricConductance:
            return "ElectricConductanceInfo"
        case .electricConductivity:
            return "ElectricConductivityInfo"
        case .electricFieldStrength:
            return "ElectricFieldStrengthInfo"
        case .electricPotential:
            return "ElectricPotentialInfo"
        case .electricResistance:
            return "ElectricResistanceInfo"
        case .electricResistivity:
            return "ElectricResistivityInfo"
        case .electrostaticCapacitance:
            return "ElectrostaticCapacitanceInfo"
        case .inductance:
            return "InductanceInfo"
        case .linearChargeDensity:
            return "LinearChargeDensityInfo"
        case .linearCurrentDensity:
            return "LinearCurrentDensityInfo"
        case .surfaceChargeDensity:
            return "SurfaceChargeDensityInfo"
        case .surfaceCurrentDensity:
            return "SurfaceCurrentDensityInfo"
        case .volumeChargeDensity:
            return "VolumeChargeDensityInfo"
        }
    }
    
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .charge:
            return [
                ("C", "coulomb"),
                ("MC", "megacoulomb"),
                ("kC", "kilocoulomb"),
                ("mC", "millicoulomb"),
                ("µC", "microcoulomb"),
                ("nC", "nanocoulomb"),
                ("pC", "picocoulomb"),
                ("abC", "abcoulomb"),
                ("emuC", "EMU of charge"),
                ("statC", "statcoulomb"),
                ("esuC", "ESU of charge"),
                ("Fr", "franklin"),
                ("A·h", "ampere-hour"),
                ("A·min", "ampere-minute"),
                ("A·s", "ampere-second"),
                ("F", "faraday (based on carbon 12)"),
                ("e", "Elementary charge")
            ]
        case .linearChargeDensity:
            return [
                ("C/m", "coulomb/meter"),
                ("C/cm", "coulomb/centimeter"),
                ("C/in", "coulomb/inch"),
                ("abC/m", "abcoulomb/meter"),
                ("abC/cm", "abcoulomb/centimeter"),
                ("abC/in", "abcoulomb/inch")
            ]
        case .surfaceChargeDensity:
            return [
                ("C/m²", "coulomb/square meter"),
                ("C/cm²", "coulomb/square centimeter"),
                ("C/in²", "coulomb/square inch"),
                ("abC/m²", "abcoulomb/square meter"),
                ("abC/cm²", "abcoulomb/square centimeter"),
                ("abC/in²", "abcoulomb/square inch")
            ]
        case .volumeChargeDensity:
            return [
                ("C/m³", "coulomb/cubic meter"),
                ("C/cm³", "coulomb/cubic centimeter"),
                ("C/in³", "coulomb/cubic inch"),
                ("abC/m³", "abcoulomb/cubic meter"),
                ("abC/cm³", "abcoulomb/cubic centimeter"),
                ("abC/in³", "abcoulomb/cubic inch")
            ]
        case .current:
            return [
                ("A", "ampere"),
                ("kA", "kiloampere"),
                ("mA", "milliampere"),
                ("Bi", "biot"),
                ("abA", "abampere"),
                ("emuI", "EMU of current"),
                ("statA", "statampere"),
                ("esuI", "ESU of current"),
                ("CGSem", "CGS e.m. unit"),
                ("CGSes", "CGS e.s. unit")
            ]
        case .linearCurrentDensity:
            return [
                ("A/m", "ampere/meter"),
                ("A/cm", "ampere/centimeter"),
                ("A/in", "ampere/inch"),
                ("abA/m", "abampere/meter"),
                ("abA/cm", "abampere/centimeter"),
                ("abA/in", "abampere/inch"),
                ("Oe", "oersted"),
                ("Gb/cm", "gilbert/centimeter")
            ]
        case .surfaceCurrentDensity:
            return [
                ("A/m²", "ampere/square meter"),
                ("A/cm²", "ampere/square centimeter"),
                ("A/in²", "ampere/square inch"),
                ("A/mil²", "ampere/square mil"),
                ("A/cmil", "ampere/circular mil"),
                ("abA/cm²", "abampere/square centimeter")
            ]
        case .electricFieldStrength:
            return [
                ("V/m", "volt/meter"),
                ("kV/m", "kilovolt/meter"),
                ("kV/cm", "kilovolt/centimeter"),
                ("V/cm", "volt/centimeter"),
                ("mV/m", "millivolt/meter"),
                ("µV/m", "microvolt/meter"),
                ("kV/in", "kilovolt/inch"),
                ("V/in", "volt/inch"),
                ("V/mil", "volt/mil"),
                ("abV/cm", "abvolt/centimeter"),
                ("statV/cm", "statvolt/centimeter"),
                ("statV/in", "statvolt/inch"),
                ("N/C", "newton/coulomb")
            ]
        case .electricPotential:
            return [
                ("V", "volt"),
                ("W/A", "watt/ampere"),
                ("abV", "abvolt"),
                ("emuV", "EMU of electric potential"),
                ("statV", "statvolt"),
                ("esuV", "ESU of electric potential")
            ]
        case .electricResistance:
            return [
                ("Ω", "ohm"),
                ("MΩ", "megohm"),
                ("µΩ", "microhm"),
                ("V/A", "volt/ampere"),
                ("S⁻¹", "reciprocal siemens"),
                ("abΩ", "abohm"),
                ("emuR", "EMU of resistance"),
                ("statΩ", "statohm"),
                ("esuR", "ESU of resistance"),
                ("RH", "Quantized Hall resistance")
            ]
        case .electricResistivity:
            return [
                ("Ω·m", "ohm meter"),
                ("Ω·cm", "ohm centimeter"),
                ("Ω·in", "ohm inch"),
                ("µΩ·cm", "microhm centimeter"),
                ("µΩ·in", "microhm inch"),
                ("abΩ·cm", "abohm centimeter"),
                ("statΩ·cm", "statohm centimeter"),
                ("cmil·Ω/ft", "circular mil ohm/foot")
            ]
        case .electricConductance:
            return [
                ("S", "siemens"),
                ("MS", "megasiemens"),
                ("kS", "kilosiemens"),
                ("mS", "millisiemens"),
                ("µS", "microsiemens"),
                ("A/V", "ampere/volt"),
                ("℧", "mho"),
                ("g℧", "gemmho"),
                ("µ℧", "micromho"),
                ("ab℧", "abmho"),
                ("stat℧", "statmho"),
                ("G₀", "Quantized Hall conductance")
            ]
        case .electricConductivity:
            return [
                ("S/m", "siemens/meter"),
                ("pS/m", "picosiemens/meter"),
                ("℧/m", "mho/meter"),
                ("℧/cm", "mho/centimeter"),
                ("ab℧/m", "abmho/meter"),
                ("ab℧/cm", "abmho/centimeter"),
                ("stat℧/m", "statmho/meter"),
                ("stat℧/cm", "statmho/centimeter")
            ]
        case .electrostaticCapacitance:
            return [
                ("F", "farad"),
                ("EF", "exafarad"),
                ("PF", "petafarad"),
                ("TF", "terafarad"),
                ("GF", "gigafarad"),
                ("MF", "megafarad"),
                ("kF", "kilofarad"),
                ("hF", "hectofarad"),
                ("daF", "dekafarad"),
                ("dF", "decifarad"),
                ("cF", "centifarad"),
                ("mF", "millifarad"),
                ("µF", "microfarad"),
                ("nF", "nanofarad"),
                ("pF", "picofarad"),
                ("fF", "femtofarad"),
                ("aF", "attofarad"),
                ("C/V", "coulomb/volt"),
                ("abF", "abfarad"),
                ("emuC", "EMU of capacitance"),
                ("statF", "statfarad"),
                ("esuC", "ESU of capacitance")
            ]
        case .inductance:
            return [
                ("H", "henry"),
                ("EH", "exahenry"),
                ("PH", "petahenry"),
                ("TH", "terahenry"),
                ("GH", "gigahenry"),
                ("MH", "megahenry"),
                ("kH", "kilohenry"),
                ("hH", "hectohenry"),
                ("daH", "dekahenry"),
                ("dH", "decihenry"),
                ("cH", "centihenry"),
                ("mH", "millihenry"),
                ("µH", "microhenry"),
                ("nH", "nanohenry"),
                ("pH", "picohenry"),
                ("fH", "femtohenry"),
                ("aH", "attohenry"),
                ("Wb/A", "weber/ampere"),
                ("abH", "abhenry"),
                ("emuL", "EMU of inductance"),
                ("statH", "stathenry"),
                ("esuL", "ESU of inductance")
            ]
        }
    }}
