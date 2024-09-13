//
//  LightUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation
import SwiftUI

enum LightUnitsCategory: String, CaseIterable, UnitCategory {
    case luminance = "Luminance"
    case luminousIntensity = "Luminous Intensity"
    case illumination = "Illumination"
    case digitalImageResolution = "Digital Image Resolution"
    case frequencyWavelength = "Frequency Wavelength"
    
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
    
    func convert(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        switch self {
        case .luminance:
            return convertLuminance(value, from: fromUnit, to: toUnit)
        case .luminousIntensity:
            return convertLuminousIntensity(value, from: fromUnit, to: toUnit)
        case .illumination:
            return convertIlluminance(value, from: fromUnit, to: toUnit)
        case .digitalImageResolution:
            return convertResolution(value, from: fromUnit, to: toUnit)
        case .frequencyWavelength:
            return convertFrequency(value, from: fromUnit, to: toUnit)
        }
    }
    
    private func convertLuminance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let candelaPerSquareMeterValues: [String: Decimal] = [
            "cd/m²": 1,
            "cd/cm²": 10000,
            "cd/ft²": Decimal(string: "10.7639104167")!,
            "cd/in²": Decimal(string: "1550.0031000062")!,
            "kcd/m²": 1000,
            "sb": 10000,
            "lm/m²/sr": 1,
            "lm/cm²/sr": 10000,
            "lm/ft²/sr": Decimal(string: "10.7639104167")!,
            "W/cm²/sr": 6830000,
            "nt": 1,
            "mnt": Decimal(string: "0.001")!,
            "L": Decimal(string: "3183.0988618379")!,
            "mL": Decimal(string: "3.1830988618")!,
            "fL": Decimal(string: "3.4262590996")!,
            "asb": Decimal(string: "0.3183098862")!,
            "bl": Decimal(string: "0.3183098862")!,
            "bril": Decimal(string: "3.1830988618379e-8")!,
            "sk": Decimal(string: "0.0003183099")!
        ]
        
        guard let fromValue = candelaPerSquareMeterValues[fromUnit], let toValue = candelaPerSquareMeterValues[toUnit] else {
            return value
        }
        
        let candelaPerSquareMeter = value * fromValue
        return candelaPerSquareMeter / toValue
    }
    
    private func convertLuminousIntensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let candleInternationalValues: [String: Decimal] = [
            "cd": 1,
            "cd (G)": Decimal(string: "1.0526315789")!,
            "cd (UK)": Decimal(string: "1.0416666667")!,
            "dc": 1,
            "cp": 1,
            "10 cp": 10,
            "HC": Decimal(string: "0.9000000001")!,
            "cu": Decimal(string: "9.610000003")!,
            "bd": 1,
            "lm/sr": 1
        ]
        
        guard let fromValue = candleInternationalValues[fromUnit], let toValue = candleInternationalValues[toUnit] else {
            return value
        }
        
        let candleInternational = value * fromValue
        return candleInternational / toValue
    }
    
    private func convertIlluminance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let luxValues: [String: Decimal] = [
            "lx": 1,
            "m·cd": 1,
            "cm·cd": 10000,
            "fc": Decimal(string: "10.7639104167")!,
            "fl": Decimal(string: "43.0556416668")!,
            "ph": 10000,
            "nx": Decimal(string: "0.001")!,
            "cd·sr/m²": 1,
            "lm/m²": 1,
            "lm/cm²": 10000,
            "lm/ft²": Decimal(string: "10.7639104167")!,
            "W/cm²": 6830000
        ]
        
        guard let fromValue = luxValues[fromUnit], let toValue = luxValues[toUnit] else {
            return value
        }
        
        let lux = value * fromValue
        return lux / toValue
    }
    
    private func convertResolution(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let dotPerMeterValues: [String: Decimal] = [
            "dpm": 1,
            "dpmm": 1000,
            "dpi": Decimal(string: "39.3700787402")!,
            "ppi": Decimal(string: "39.3700787402")!
        ]
        
        guard let fromValue = dotPerMeterValues[fromUnit], let toValue = dotPerMeterValues[toUnit] else {
            return value
        }
        
        let dotPerMeter = value * fromValue
        return dotPerMeter / toValue
    }
    
    private func convertFrequency(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let hertzValues: [String: Decimal] = [
            "Hz": 1,
            "EHz": Decimal(sign: .plus, exponent: 18, significand: 1),
            "PHz": Decimal(sign: .plus, exponent: 15, significand: 1),
            "THz": Decimal(sign: .plus, exponent: 12, significand: 1),
            "GHz": Decimal(sign: .plus, exponent: 9, significand: 1),
            "MHz": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kHz": Decimal(sign: .plus, exponent: 3, significand: 1),
            "hHz": Decimal(sign: .plus, exponent: 2, significand: 1),
            "daHz": Decimal(sign: .plus, exponent: 1, significand: 1),
            "dHz": Decimal(sign: .plus, exponent: -1, significand: 1),
            "cHz": Decimal(sign: .plus, exponent: -2, significand: 1),
            "mHz": Decimal(sign: .plus, exponent: -3, significand: 1),
            "µHz": Decimal(sign: .plus, exponent: -6, significand: 1),
            "nHz": Decimal(sign: .plus, exponent: -9, significand: 1),
            "pHz": Decimal(sign: .plus, exponent: -12, significand: 1),
            "fHz": Decimal(sign: .plus, exponent: -15, significand: 1),
            "aHz": Decimal(sign: .plus, exponent: -18, significand: 1),
            "c/s": 1
        ]
        
        let wavelengthValues: [String: Decimal] = [
            "λ Em": Decimal(string: "1e-18")!,
            "λ Pm": Decimal(string: "1e-15")!,
            "λ Tm": Decimal(string: "1e-12")!,
            "λ Gm": Decimal(string: "1e-9")!,
            "λ Mm": Decimal(string: "1e-6")!,
            "λ km": Decimal(string: "1e-3")!,
            "λ hm": Decimal(string: "1e-2")!,
            "λ dam": Decimal(string: "1e-1")!,
            "λ m": 1,
            "λ dm": 10,
            "λ cm": 100,
            "λ mm": 1000,
            "λ µm": Decimal(string: "1e6")!,
            "λ nm": Decimal(string: "1e9")!,
            "λC,e": Decimal(string: "2.42631023867e-12")!,
            "λC,p": Decimal(string: "1.32141e-15")!,
            "λC,n": Decimal(string: "1.31959e-15")!
        ]
        
        let c = Decimal(299792458) // Speed of light in m/s
        
        func toHz(_ value: Decimal, from unit: String) -> Decimal {
            if let hertzMultiplier = hertzValues[unit] {
                return value * hertzMultiplier
            } else if let wavelengthMultiplier = wavelengthValues[unit] {
                let wavelengthInMeters = value * wavelengthMultiplier
                return c / wavelengthInMeters
            }
            return value // Default case if unit is not recognized
        }
        
        func fromHz(_ value: Decimal, to unit: String) -> Decimal {
            if let hertzDivisor = hertzValues[unit] {
                return value / hertzDivisor
            } else if let wavelengthDivisor = wavelengthValues[unit] {
                let wavelengthInMeters = c / value
                return wavelengthInMeters / wavelengthDivisor
            }
            return value // Default case if unit is not recognized
        }
        
        let hertz = toHz(value, from: fromUnit)
        return fromHz(hertz, to: toUnit)
    }
    
    var icon: String {
        switch self {
        case .digitalImageResolution:
            return "photo"
        case .frequencyWavelength:
            return "waveform.path"
        case .illumination:
            return "lightbulb"
        case .luminance:
            return "sun.max"
        case .luminousIntensity:
            return "light.max"
        }
    }
    
    var info: LocalizedStringKey {
        switch self {
        case .digitalImageResolution:
            return "DigitalImageResolutionInfo"
        case .frequencyWavelength:
            return "FrequencyWaveLengthInfo"
        case .illumination:
            return "IlluminationInfo"
        case .luminance:
            return "LuminanceInfo"
        case .luminousIntensity:
            return "LuminousIntensityInfo"
        }
    }
    
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .luminance:
            return [
                ("cd/m²", String(localized: "candela/square meter")),
                ("cd/cm²", String(localized: "candela/square centimeter")),
                ("cd/ft²", String(localized: "candela/square foot")),
                ("cd/in²", String(localized: "candela/square inch")),
                ("kcd/m²", String(localized: "kilocandela/square meter")),
                ("sb", String(localized: "stilb")),
                ("lm/m²/sr", String(localized: "lumen/sq. meter/steradian")),
                ("lm/cm²/sr", String(localized: "lumen/sq. cm/steradian")),
                ("lm/ft²/sr", String(localized: "lumen/square foot/steradian")),
                ("W/cm²/sr", String(localized: "watt/sq. cm/steradian (at 555 nm)")),
                ("nt", String(localized: "nit")),
                ("mnt", String(localized: "millinit")),
                ("L", String(localized: "lambert")),
                ("mL", String(localized: "millilambert")),
                ("fL", String(localized: "foot-lambert")),
                ("asb", String(localized: "apostilb")),
                ("bl", String(localized: "blondel")),
                ("bril", String(localized: "bril")),
                ("sk", String(localized: "skot"))
            ]
        case .luminousIntensity:
            return [
                ("cd", String(localized: "candle (international)")),
                ("cd (G)", String(localized: "candle (German)")),
                ("cd (UK)", String(localized: "candle (UK)")),
                ("dc", String(localized: "decimal candle")),
                ("cp", String(localized: "candle (pentane)")),
                ("10 cp", String(localized: "pentane candle (10 candle power)")),
                ("HC", String(localized: "hefner candle")),
                ("cu", String(localized: "carcel unit")),
                ("bd", String(localized: "bougie decimal")),
                ("lm/sr", String(localized: "lumen/steradian"))
            ]
        case .illumination:
            return [
                ("lx", String(localized: "lux")),
                ("m·cd", String(localized: "meter-candle")),
                ("cm·cd", String(localized: "centimeter-candle")),
                ("fc", String(localized: "foot-candle")),
                ("fl", String(localized: "flame")),
                ("ph", String(localized: "phot")),
                ("nx", String(localized: "nox")),
                ("cd·sr/m²", String(localized: "candela steradian/sq. meter")),
                ("lm/m²", String(localized: "lumen/square meter")),
                ("lm/cm²", String(localized: "lumen/square centimeter")),
                ("lm/ft²", String(localized: "lumen/square foot")),
                ("W/cm²", String(localized: "watt/sq. cm (at 555 nm)"))
            ]
        case .digitalImageResolution:
            return [
                ("dpm", String(localized: "dot/meter")),
                ("dpmm", String(localized: "dot/millimeter")),
                ("dpi", String(localized: "dot/inch")),
                ("ppi", String(localized: "pixel/inch"))
            ]
        case .frequencyWavelength:
            return [
                ("Hz", String(localized: "hertz")),
                ("EHz", String(localized: "exahertz")),
                ("PHz", String(localized: "petahertz")),
                ("THz", String(localized: "terahertz")),
                ("GHz", String(localized: "gigahertz")),
                ("MHz", String(localized: "megahertz")),
                ("kHz", String(localized: "kilohertz")),
                ("hHz", String(localized: "hectohertz")),
                ("daHz", String(localized: "dekahertz")),
                ("dHz", String(localized: "decihertz")),
                ("cHz", String(localized: "centihertz")),
                ("mHz", String(localized: "millihertz")),
                ("µHz", String(localized: "microhertz")),
                ("nHz", String(localized: "nanohertz")),
                ("pHz", String(localized: "picohertz")),
                ("fHz", String(localized: "femtohertz")),
                ("aHz", String(localized: "attohertz")),
                ("c/s", String(localized: "cycle/second")),
                ("λ Em", String(localized: "wavelength in exametres")),
                ("λ Pm", String(localized: "wavelength in petametres")),
                ("λ Tm", String(localized: "wavelength in terametres")),
                ("λ Gm", String(localized: "wavelength in gigametres")),
                ("λ Mm", String(localized: "wavelength in megametres")),
                ("λ km", String(localized: "wavelength in kilometres")),
                ("λ hm", String(localized: "wavelength in hectometres")),
                ("λ dam", String(localized: "wavelength in dekametres")),
                ("λ m", String(localized: "wavelength in metres")),
                ("λ dm", String(localized: "wavelength in decimetres")),
                ("λ cm", String(localized: "wavelength in centimetres")),
                ("λ mm", String(localized: "wavelength in millimetres")),
                ("λ µm", String(localized: "wavelength in micrometres")),
                ("λ nm", String(localized: "wavelength in nanometres")),
                ("λC,e", String(localized: "Electron Compton wavelength")),
                ("λC,p", String(localized: "Proton Compton wavelength")),
                ("λC,n", String(localized: "Neutron Compton wavelength"))
            ]
        }
    }
}
