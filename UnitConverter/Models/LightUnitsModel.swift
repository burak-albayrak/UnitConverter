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
            "candela/square meter": 1,
            "candela/square centimeter": 10000,
            "candela/square foot": Decimal(string: "10.7639104167")!,
            "candela/square inch": Decimal(string: "1550.0031000062")!,
            "kilocandela/square meter": 1000,
            "stilb": 10000,
            "lumen/sq. meter/steradian": 1,
            "lumen/sq. cm/steradian": 10000,
            "lumen/square foot/steradian": Decimal(string: "10.7639104167")!,
            "watt/sq. cm/steradian (at 555 nm)": 6830000,
            "nit": 1,
            "millinit": Decimal(string: "0.001")!,
            "lambert": Decimal(string: "3183.0988618379")!,
            "millilambert": Decimal(string: "3.1830988618")!,
            "foot-lambert": Decimal(string: "3.4262590996")!,
            "apostilb": Decimal(string: "0.3183098862")!,
            "blondel": Decimal(string: "0.3183098862")!,
            "bril": Decimal(string: "3.1830988618379e-8")!,
            "skot": Decimal(string: "0.0003183099")!
        ]
        
        guard let fromValue = candelaPerSquareMeterValues[fromUnit.lowercased()], let toValue = candelaPerSquareMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let candelaPerSquareMeter = value * fromValue
        return candelaPerSquareMeter / toValue
    }
    
    private func convertLuminousIntensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let candleInternationalValues: [String: Decimal] = [
            "candle (international)": 1,
            "candle (German)": Decimal(string: "1.0526315789")!,
            "candle (UK)": Decimal(string: "1.0416666667")!,
            "decimal candle": 1,
            "candle (pentane)": 1,
            "pentane candle (10 candle power)": 10,
            "hefner candle": Decimal(string: "0.9000000001")!,
            "carcel unit": Decimal(string: "9.610000003")!,
            "bougie decimal": 1,
            "lumen/steradian": 1
        ]
        
        guard let fromValue = candleInternationalValues[fromUnit.lowercased()], let toValue = candleInternationalValues[toUnit.lowercased()] else {
            return value
        }
        
        let candleInternational = value * fromValue
        return candleInternational / toValue
    }
    
    private func convertIlluminance(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let luxValues: [String: Decimal] = [
            "lux": 1,
            "meter-candle": 1,
            "centimeter-candle": 10000,
            "foot-candle": Decimal(string: "10.7639104167")!,
            "flame": Decimal(string: "43.0556416668")!,
            "phot": 10000,
            "nox": Decimal(string: "0.001")!,
            "candela steradian/sq. meter": 1,
            "lumen/square meter": 1,
            "lumen/square centimeter": 10000,
            "lumen/square foot": Decimal(string: "10.7639104167")!,
            "watt/sq. cm (at 555 nm)": 6830000
        ]
        
        guard let fromValue = luxValues[fromUnit.lowercased()], let toValue = luxValues[toUnit.lowercased()] else {
            return value
        }
        
        let lux = value * fromValue
        return lux / toValue
    }
    
    private func convertResolution(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let dotPerMeterValues: [String: Decimal] = [
            "dot/meter": 1,
            "dot/millimeter": 1000,
            "dot/inch": Decimal(string: "39.3700787402")!,
            "pixel/inch": Decimal(string: "39.3700787402")!
        ]
        
        guard let fromValue = dotPerMeterValues[fromUnit.lowercased()], let toValue = dotPerMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let dotPerMeter = value * fromValue
        return dotPerMeter / toValue
    }
    
    private func convertFrequency(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let hertzValues: [String: Decimal] = [
            "hertz": 1,
            "exahertz": Decimal(sign: .plus, exponent: 18, significand: 1),
            "petahertz": Decimal(sign: .plus, exponent: 15, significand: 1),
            "terahertz": Decimal(sign: .plus, exponent: 12, significand: 1),
            "gigahertz": Decimal(sign: .plus, exponent: 9, significand: 1),
            "megahertz": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kilohertz": Decimal(sign: .plus, exponent: 3, significand: 1),
            "hectohertz": Decimal(sign: .plus, exponent: 2, significand: 1),
            "dekahertz": Decimal(sign: .plus, exponent: 1, significand: 1),
            "decihertz": Decimal(sign: .minus, exponent: 1, significand: 1),
            "centihertz": Decimal(sign: .minus, exponent: 2, significand: 1),
            "millihertz": Decimal(sign: .minus, exponent: 3, significand: 1),
            "microhertz": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nanohertz": Decimal(sign: .minus, exponent: 9, significand: 1),
            "picohertz": Decimal(sign: .minus, exponent: 12, significand: 1),
            "femtohertz": Decimal(sign: .minus, exponent: 15, significand: 1),
            "attohertz": Decimal(sign: .minus, exponent: 18, significand: 1),
            "cycle/second": 1,
            "wavelength in exametres": Decimal(string: "2.99792458e-10")!,
            "wavelength in petametres": Decimal(string: "2.99792458e-7")!,
            "wavelength in terametres": Decimal(string: "0.0002997925")!,
            "wavelength in gigametres": Decimal(string: "0.299792458")!,
            "wavelength in megametres": Decimal(string: "299.792458")!,
            "wavelength in kilometres": Decimal(string: "299792.458")!,
            "wavelength in hectometres": Decimal(string: "2997924.58")!,
            "wavelength in dekametres": Decimal(string: "29979245.8")!,
            "wavelength in metres": 299792458,
            "wavelength in decimetres": 2997924580,
            "wavelength in centimetres": 29979245800,
            "wavelength in millimetres": 299792458000,
            "wavelength in micrometres": Decimal(string: "2.99792458e14")!,
            "wavelength in nanometres": Decimal(string: "2.99792458e17")!,
            "Electron Compton wavelength": Decimal(string: "1.235589789993e20")!,
            "Proton Compton wavelength": Decimal(string: "2.2687315327002e23")!,
            "Neutron Compton wavelength": Decimal(string: "2.2718587447278e23")!
        ]
        
        guard let fromValue = hertzValues[fromUnit.lowercased()], let toValue = hertzValues[toUnit.lowercased()] else {
            return value
        }
        
        let hertz = value * fromValue
        return hertz / toValue
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
