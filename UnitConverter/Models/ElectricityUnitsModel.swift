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
            "C": 1,
            "MC": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kC": Decimal(sign: .plus, exponent: 3, significand: 1),
            "mC": Decimal(sign: .minus, exponent: 3, significand: 1),
            "µC": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nC": Decimal(sign: .minus, exponent: 9, significand: 1),
            "pC": Decimal(sign: .minus, exponent: 12, significand: 1),
            "abC": 10,
            "emuC": 10,
            "statC": Decimal(string: "3.335640951982e-10")!,
            "esuC": Decimal(string: "3.335640951982e-10")!,
            "Fr": Decimal(string: "3.335640951982e-10")!,
            "A·h": 3600,
            "A·min": 60,
            "A·s": 1,
            "F": Decimal(string: "96485.309000004")!,
            "e": Decimal(string: "1.60217733e-19")!
        ]

        guard let fromValue = coulombValues[fromUnit.lowercased()], let toValue = coulombValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let coulombs = value * fromValue
        return coulombs / toValue
    }
    
    private func convertElectricChargeDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let coulombPerMeterValues: [String: Decimal] = [
            "C/m": 1,
            "C/cm": 100,
            "C/in": Decimal(string: "39.3700787402")!,
            "abC/m": 10,
            "abC/cm": 1000,
            "abC/in": Decimal(string: "393.7007874016")!
        ]

        guard let fromValue = coulombPerMeterValues[fromUnit.lowercased()], let toValue = coulombPerMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let coulombsPerMeter = value * fromValue
        return coulombsPerMeter / toValue
    }
    
    private func convertSurfaceElectricChargeDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let coulombPerSquareMeterValues: [String: Decimal] = [
            "C/m²": 1,
            "C/cm²": 10000,
            "C/in²": Decimal(string: "1550.0031000062")!,
            "abC/m²": 10,
            "abC/cm²": 100000,
            "abC/in²": Decimal(string: "15500.031000062")!
        ]
        
        guard let fromValue = coulombPerSquareMeterValues[fromUnit.lowercased()], let toValue = coulombPerSquareMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let coulombsPerSquareMeter = value * fromValue
        return coulombsPerSquareMeter / toValue
    }
    
    private func convertVolumetricElectricChargeDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let coulombPerCubicMeterValues: [String: Decimal] = [
            "C/m³": 1,
            "C/cm³": Decimal(sign: .plus, exponent: 6, significand: 1),
            "C/in³": Decimal(string: "61023.744094732")!,
            "abC/m³": 10,
            "abC/cm³": Decimal(sign: .plus, exponent: 7, significand: 1),
            "abC/in³": Decimal(string: "610237.44094732")!
        ]
        
        guard let fromValue = coulombPerCubicMeterValues[fromUnit.lowercased()], let toValue = coulombPerCubicMeterValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let coulombsPerCubicMeter = value * fromValue
        return coulombsPerCubicMeter / toValue
    }
    
    private func convertElectricCurrent(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let ampereValues: [String: Decimal] = [
            "A": 1,
            "kA": Decimal(sign: .plus, exponent: 3, significand: 1),
            "mA": Decimal(sign: .minus, exponent: 3, significand: 1),
            "Bi": 10,
            "abA": 10,
            "emuI": 10,
            "statA": Decimal(string: "3.335641e-10")!,
            "esuI": Decimal(string: "3.335641e-10")!,
            "CGSem": 10,
            "CGSes": Decimal(string: "3.335641e-10")!
        ]
        
        guard let fromValue = ampereValues[fromUnit.lowercased()], let toValue = ampereValues[toUnit.lowercased()] else {
            return value
        }
        
        let amperes = value * fromValue
        return amperes / toValue
    }
    
    private func convertMagneticFieldIntensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let amperePerMeterValues: [String: Decimal] = [
            "A/m": 1,
            "A/cm": 100,
            "A/in": Decimal(string: "39.3700787402")!,
            "abA/m": 10,
            "abA/cm": 1000,
            "abA/in": Decimal(string: "393.7007874016")!,
            "Oe": Decimal(string: "79.5774715102")!,
            "Gb/cm": Decimal(string: "79.5774715102")!
        ]
        
        guard let fromValue = amperePerMeterValues[fromUnit.lowercased()], let toValue = amperePerMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let amperesPerMeter = value * fromValue
        return amperesPerMeter / toValue
    }
    
    private func convertElectricCurrentDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let amperePerSquareMeterValues: [String: Decimal] = [
            "A/m²": 1,
            "A/cm²": 10000,
            "A/in²": Decimal(string: "1550.0031000062")!,
            "A/mil²": Decimal(string: "1550003100.0062")!,
            "A/cmil": Decimal(string: "1973525240.9908")!,
            "abA/cm²": 100000
        ]
        
        guard let fromValue = amperePerSquareMeterValues[fromUnit.lowercased()], let toValue = amperePerSquareMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let amperesPerSquareMeter = value * fromValue
        return amperesPerSquareMeter / toValue
    }
    
    private func convertElectricFieldStrength(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let voltPerMeterValues: [String: Decimal] = [
            "V/m": 1,
            "kV/m": 1000,
            "kV/cm": 100000,
            "V/cm": 100,
            "mV/m": Decimal(sign: .minus, exponent: 3, significand: 1),
            "µV/m": Decimal(sign: .minus, exponent: 6, significand: 1),
            "kV/in": Decimal(string: "39370.078740157")!,
            "V/in": Decimal(string: "39.3700787402")!,
            "V/mil": Decimal(string: "39370.078740157")!,
            "abV/cm": Decimal(sign: .minus, exponent: 6, significand: 1),
            "statV/cm": Decimal(string: "29979.19999934")!,
            "statV/in": Decimal(string: "11802.834645298")!,
            "N/C": 1
        ]
        
        guard let fromValue = voltPerMeterValues[fromUnit.lowercased()], let toValue = voltPerMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let voltsPerMeter = value * fromValue
        return voltsPerMeter / toValue
    }
    
    private func convertElectricPotential(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let voltValues: [String: Decimal] = [
            "V": 1,
            "W/A": 1,
            "abV": Decimal(sign: .minus, exponent: 8, significand: 1),
            "emuV": Decimal(sign: .minus, exponent: 8, significand: 1),
            "statV": Decimal(string: "299.7925")!,
            "esuV": Decimal(string: "299.7925")!
        ]
        
        guard let fromValue = voltValues[fromUnit.lowercased()], let toValue = voltValues[toUnit.lowercased()] else {
            return value
        }
        
        let volts = value * fromValue
        return volts / toValue
    }
    
    private func convertElectricResistance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let ohmValues: [String: Decimal] = [
            "Ω": 1,
            "MΩ": Decimal(sign: .plus, exponent: 6, significand: 1),
            "µΩ": Decimal(sign: .minus, exponent: 6, significand: 1),
            "V/A": 1,
            "S⁻¹": 1,
            "abΩ": Decimal(sign: .minus, exponent: 9, significand: 1),
            "emuR": Decimal(sign: .minus, exponent: 9, significand: 1),
            "statΩ": Decimal(string: "898755200000")!,
            "esuR": Decimal(string: "898755200000")!,
            "RH": Decimal(string: "25812.8056")!
        ]
        
        guard let fromValue = ohmValues[fromUnit.lowercased()], let toValue = ohmValues[toUnit.lowercased()] else {
            return value
        }
        
        let ohms = value * fromValue
        return ohms / toValue
    }
    
    private func convertElectricResistivity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let ohmMeterValues: [String: Decimal] = [
            "Ω·m": 1,
            "Ω·cm": Decimal(string: "0.01")!,
            "Ω·in": Decimal(string: "0.0254")!,
            "µΩ·cm": Decimal(sign: .minus, exponent: 8, significand: 1),
            "µΩ·in": Decimal(string: "2.5400000000102e-8")!,
            "abΩ·cm": Decimal(sign: .minus, exponent: 11, significand: 1),
            "statΩ·cm": Decimal(string: "8987524324.0156")!,
            "cmil·Ω/ft": Decimal(string: "1.6624261130101e-9")!
        ]
        
        guard let fromValue = ohmMeterValues[fromUnit.lowercased()], let toValue = ohmMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let ohmMeters = value * fromValue
        return ohmMeters / toValue
    }
    
    private func convertElectricConductance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let siemensValues: [String: Decimal] = [
            "S": 1,
            "MS": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kS": Decimal(sign: .plus, exponent: 3, significand: 1),
            "mS": Decimal(sign: .minus, exponent: 3, significand: 1),
            "µS": Decimal(sign: .minus, exponent: 6, significand: 1),
            "A/V": 1,
            "℧": 1,
            "g℧": Decimal(sign: .minus, exponent: 6, significand: 1),
            "µ℧": Decimal(sign: .minus, exponent: 6, significand: 1),
            "ab℧": Decimal(sign: .plus, exponent: 9, significand: 1),
            "stat℧": Decimal(string: "1.1123470522803e-12")!,
            "G₀": Decimal(string: "3.87405e-5")!
        ]
        
        guard let fromValue = siemensValues[fromUnit.lowercased()], let toValue = siemensValues[toUnit.lowercased()] else {
            return value
        }
        
        let siemens = value * fromValue
        return siemens / toValue
    }
    
    private func convertElectricConductivity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let siemensPerMeterValues: [String: Decimal] = [
            "S/m": 1,
            "pS/m": Decimal(sign: .minus, exponent: 12, significand: 1),
            "℧/m": 1,
            "℧/cm": 100,
            "ab℧/m": Decimal(sign: .plus, exponent: 9, significand: 1),
            "ab℧/cm": Decimal(sign: .plus, exponent: 11, significand: 1),
            "stat℧/m": Decimal(string: "1.1126534560019e-12")!,
            "stat℧/cm": Decimal(string: "1.1126534560019e-10")!
        ]
        
        guard let fromValue = siemensPerMeterValues[fromUnit.lowercased()], let toValue = siemensPerMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let siemensPerMeter = value * fromValue
        return siemensPerMeter / toValue
    }
    
    private func convertElectricCapacitance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let faradValues: [String: Decimal] = [
            "F": 1,
            "EF": Decimal(sign: .plus, exponent: 18, significand: 1),
            "PF": Decimal(sign: .plus, exponent: 15, significand: 1),
            "TF": Decimal(sign: .plus, exponent: 12, significand: 1),
            "GF": Decimal(sign: .plus, exponent: 9, significand: 1),
            "MF": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kF": Decimal(sign: .plus, exponent: 3, significand: 1),
            "hF": Decimal(sign: .plus, exponent: 2, significand: 1),
            "daF": Decimal(sign: .plus, exponent: 1, significand: 1),
            "dF": Decimal(sign: .minus, exponent: 1, significand: 1),
            "cF": Decimal(sign: .minus, exponent: 2, significand: 1),
            "mF": Decimal(sign: .minus, exponent: 3, significand: 1),
            "µF": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nF": Decimal(sign: .minus, exponent: 9, significand: 1),
            "pF": Decimal(sign: .minus, exponent: 12, significand: 1),
            "fF": Decimal(sign: .minus, exponent: 15, significand: 1),
            "aF": Decimal(sign: .minus, exponent: 18, significand: 1),
            "C/V": 1,
            "abF": Decimal(sign: .plus, exponent: 9, significand: 1),
            "emuC": Decimal(sign: .plus, exponent: 9, significand: 1),
            "statF": Decimal(string: "1.112650056054e-12")!,
            "esuC": Decimal(string: "1.112650056054e-12")!
        ]
        
        guard let fromValue = faradValues[fromUnit.lowercased()], let toValue = faradValues[toUnit.lowercased()] else {
            return value
        }
        
        let farads = value * fromValue
        return farads / toValue
    }
    
    private func convertElectricInductance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let henryValues: [String: Decimal] = [
            "H": 1,
            "EH": Decimal(sign: .plus, exponent: 18, significand: 1),
            "PH": Decimal(sign: .plus, exponent: 15, significand: 1),
            "TH": Decimal(sign: .plus, exponent: 12, significand: 1),
            "GH": Decimal(sign: .plus, exponent: 9, significand: 1),
            "MH": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kH": Decimal(sign: .plus, exponent: 3, significand: 1),
            "hH": Decimal(sign: .plus, exponent: 2, significand: 1),
            "daH": Decimal(sign: .plus, exponent: 1, significand: 1),
            "dH": Decimal(sign: .minus, exponent: 1, significand: 1),
            "cH": Decimal(sign: .minus, exponent: 2, significand: 1),
            "mH": Decimal(sign: .minus, exponent: 3, significand: 1),
            "µH": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nH": Decimal(sign: .minus, exponent: 9, significand: 1),
            "pH": Decimal(sign: .minus, exponent: 12, significand: 1),
            "fH": Decimal(sign: .minus, exponent: 15, significand: 1),
            "aH": Decimal(sign: .minus, exponent: 18, significand: 1),
            "Wb/A": 1,
            "abH": Decimal(sign: .minus, exponent: 9, significand: 1),
            "emuL": Decimal(sign: .minus, exponent: 9, significand: 1),
            "statH": Decimal(string: "898755200000")!,
            "esuL": Decimal(string: "898755200000")!
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
                ("C", String(localized: "coulomb")),
                ("MC", String(localized: "megacoulomb")),
                ("kC", String(localized: "kilocoulomb")),
                ("mC", String(localized: "millicoulomb")),
                ("µC", String(localized: "microcoulomb")),
                ("nC", String(localized: "nanocoulomb")),
                ("pC", String(localized: "picocoulomb")),
                ("abC", String(localized: "abcoulomb")),
                ("emuC", String(localized: "EMU of charge")),
                ("statC", String(localized: "statcoulomb")),
                ("esuC", String(localized: "ESU of charge")),
                ("Fr", String(localized: "franklin")),
                ("A·h", String(localized: "ampere-hour")),
                ("A·min", String(localized: "ampere-minute")),
                ("A·s", String(localized: "ampere-second")),
                ("F", String(localized: "faraday (based on carbon 12)")),
                ("e", String(localized: "Elementary charge"))
            ]
        case .linearChargeDensity:
            return [
                ("C/m", String(localized: "coulomb/meter")),
                ("C/cm", String(localized: "coulomb/centimeter")),
                ("C/in", String(localized: "coulomb/inch")),
                ("abC/m", String(localized: "abcoulomb/meter")),
                ("abC/cm", String(localized: "abcoulomb/centimeter")),
                ("abC/in", String(localized: "abcoulomb/inch"))
            ]
        case .surfaceChargeDensity:
            return [
                ("C/m²", String(localized: "coulomb/square meter")),
                ("C/cm²", String(localized: "coulomb/square centimeter")),
                ("C/in²", String(localized: "coulomb/square inch")),
                ("abC/m²", String(localized: "abcoulomb/square meter")),
                ("abC/cm²", String(localized: "abcoulomb/square centimeter")),
                ("abC/in²", String(localized: "abcoulomb/square inch"))
            ]
        case .volumeChargeDensity:
            return [
                ("C/m³", String(localized: "coulomb/cubic meter")),
                ("C/cm³", String(localized: "coulomb/cubic centimeter")),
                ("C/in³", String(localized: "coulomb/cubic inch")),
                ("abC/m³", String(localized: "abcoulomb/cubic meter")),
                ("abC/cm³", String(localized: "abcoulomb/cubic centimeter")),
                ("abC/in³", String(localized: "abcoulomb/cubic inch"))
            ]
        case .current:
            return [
                ("A", String(localized: "ampere")),
                ("kA", String(localized: "kiloampere")),
                ("mA", String(localized: "milliampere")),
                ("Bi", String(localized: "biot")),
                ("abA", String(localized: "abampere")),
                ("emuI", String(localized: "EMU of current")),
                ("statA", String(localized: "statampere")),
                ("esuI", String(localized: "ESU of current")),
                ("CGSem", String(localized: "CGS e.m. unit")),
                ("CGSes", String(localized: "CGS e.s. unit"))
            ]
        case .linearCurrentDensity:
            return [
                ("A/m", String(localized: "ampere/meter")),
                ("A/cm", String(localized: "ampere/centimeter")),
                ("A/in", String(localized: "ampere/inch")),
                ("abA/m", String(localized: "abampere/meter")),
                ("abA/cm", String(localized: "abampere/centimeter")),
                ("abA/in", String(localized: "abampere/inch")),
                ("Oe", String(localized: "oersted")),
                ("Gb/cm", String(localized: "gilbert/centimeter"))
            ]
        case .surfaceCurrentDensity:
            return [
                ("A/m²", String(localized: "ampere/square meter")),
                ("A/cm²", String(localized: "ampere/square centimeter")),
                ("A/in²", String(localized: "ampere/square inch")),
                ("A/mil²", String(localized: "ampere/square mil")),
                ("A/cmil", String(localized: "ampere/circular mil")),
                ("abA/cm²", String(localized: "abampere/square centimeter"))
            ]
        case .electricFieldStrength:
            return [
                ("V/m", String(localized: "volt/meter")),
                ("kV/m", String(localized: "kilovolt/meter")),
                ("kV/cm", String(localized: "kilovolt/centimeter")),
                ("V/cm", String(localized: "volt/centimeter")),
                ("mV/m", String(localized: "millivolt/meter")),
                ("µV/m", String(localized: "microvolt/meter")),
                ("kV/in", String(localized: "kilovolt/inch")),
                ("V/in", String(localized: "volt/inch")),
                ("V/mil", String(localized: "volt/mil")),
                ("abV/cm", String(localized: "abvolt/centimeter")),
                ("statV/cm", String(localized: "statvolt/centimeter")),
                ("statV/in", String(localized: "statvolt/inch")),
                ("N/C", String(localized: "newton/coulomb"))
            ]
        case .electricPotential:
            return [
                ("V", String(localized: "volt")),
                ("W/A", String(localized: "watt/ampere")),
                ("abV", String(localized: "abvolt")),
                ("emuV", String(localized: "EMU of electric potential")),
                ("statV", String(localized: "statvolt")),
                ("esuV", String(localized: "ESU of electric potential"))
            ]
        case .electricResistance:
            return [
                ("Ω", String(localized: "ohm")),
                ("MΩ", String(localized: "megohm")),
                ("µΩ", String(localized: "microhm")),
                ("V/A", String(localized: "volt/ampere")),
                ("S⁻¹", String(localized: "reciprocal siemens")),
                ("abΩ", String(localized: "abohm")),
                ("emuR", String(localized: "EMU of resistance")),
                ("statΩ", String(localized: "statohm")),
                ("esuR", String(localized: "ESU of resistance")),
                ("RH", String(localized: "Quantized Hall resistance"))
            ]
        case .electricResistivity:
            return [
                ("Ω·m", String(localized: "ohm meter")),
                ("Ω·cm", String(localized: "ohm centimeter")),
                ("Ω·in", String(localized: "ohm inch")),
                ("µΩ·cm", String(localized: "microhm centimeter")),
                ("µΩ·in", String(localized: "microhm inch")),
                ("abΩ·cm", String(localized: "abohm centimeter")),
                ("statΩ·cm", String(localized: "statohm centimeter")),
                ("cmil·Ω/ft", String(localized: "circular mil ohm/foot"))
            ]
        case .electricConductance:
            return [
                ("S", String(localized: "siemens")),
                ("MS", String(localized: "megasiemens")),
                ("kS", String(localized: "kilosiemens")),
                ("mS", String(localized: "millisiemens")),
                ("µS", String(localized: "microsiemens")),
                ("A/V", String(localized: "ampere/volt")),
                ("℧", String(localized: "mho")),
                ("g℧", String(localized: "gemmho")),
                ("µ℧", String(localized: "micromho")),
                ("ab℧", String(localized: "abmho")),
                ("stat℧", String(localized: "statmho")),
                ("G₀", String(localized: "Quantized Hall conductance"))
            ]
        case .electricConductivity:
            return [
                ("S/m", String(localized: "siemens/meter")),
                ("pS/m", String(localized: "picosiemens/meter")),
                ("℧/m", String(localized: "mho/meter")),
                ("℧/cm", String(localized: "mho/centimeter")),
                ("ab℧/m", String(localized: "abmho/meter")),
                ("ab℧/cm", String(localized: "abmho/centimeter")),
                ("stat℧/m", String(localized: "statmho/meter")),
                ("stat℧/cm", String(localized: "statmho/centimeter"))
            ]
        case .electrostaticCapacitance:
            return [
                ("F", String(localized: "farad")),
                ("EF", String(localized: "exafarad")),
                ("PF", String(localized: "petafarad")),
                ("TF", String(localized: "terafarad")),
                ("GF", String(localized: "gigafarad")),
                ("MF", String(localized: "megafarad")),
                ("kF", String(localized: "kilofarad")),
                ("hF", String(localized: "hectofarad")),
                ("daF", String(localized: "dekafarad")),
                ("dF", String(localized: "decifarad")),
                ("cF", String(localized: "centifarad")),
                ("mF", String(localized: "millifarad")),
                ("µF", String(localized: "microfarad")),
                ("nF", String(localized: "nanofarad")),
                ("pF", String(localized: "picofarad")),
                ("fF", String(localized: "femtofarad")),
                ("aF", String(localized: "attofarad")),
                ("C/V", String(localized: "coulomb/volt")),
                ("abF", String(localized: "abfarad")),
                ("emuC", String(localized: "EMU of capacitance")),
                ("statF", String(localized: "statfarad")),
                ("esuC", String(localized: "ESU of capacitance"))
            ]
        case .inductance:
            return [
                ("H", String(localized: "henry")),
                ("EH", String(localized: "exahenry")),
                ("PH", String(localized: "petahenry")),
                ("TH", String(localized: "terahenry")),
                ("GH", String(localized: "gigahenry")),
                ("MH", String(localized: "megahenry")),
                ("kH", String(localized: "kilohenry")),
                ("hH", String(localized: "hectohenry")),
                ("daH", String(localized: "dekahenry")),
                ("dH", String(localized: "decihenry")),
                ("cH", String(localized: "centihenry")),
                ("mH", String(localized: "millihenry")),
                ("µH", String(localized: "microhenry")),
                ("nH", String(localized: "nanohenry")),
                ("pH", String(localized: "picohenry")),
                ("fH", String(localized: "femtohenry")),
                ("aH", String(localized: "attohenry")),
                ("Wb/A", String(localized: "weber/ampere")),
                ("abH", String(localized: "abhenry")),
                ("emuL", String(localized: "EMU of inductance")),
                ("statH", String(localized: "stathenry")),
                ("esuL", String(localized: "ESU of inductance"))
            ]
        }
    }}
