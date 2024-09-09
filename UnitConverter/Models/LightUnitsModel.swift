//
//  LightUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 3.09.2024.
//

import Foundation

enum LightUnitsCategory: String, CaseIterable, UnitCategory {
    case luminance = "Luminance"
    case luminousIntensity = "Luminous Intensity"
    case illumination = "Illumination"
    case digitalImageResolution = "Digital Image Resolution"
    case frequencyWavelength = "Frequency Wavelength"
    
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
    
    var info: String {
        switch self {
        case .digitalImageResolution:
            return """
                Digital image resolution refers to the detail an image holds, usually measured in pixels.
                
                It is defined by the number of pixels along the width and height of an image, such as 1920x1080 pixels.
                
                Higher resolution images have more pixels and thus contain more detail, resulting in sharper and clearer images.
                
                The resolution is a critical factor in determining the quality of digital images used in various applications, including photography, television, and computer displays.
                
                It affects the clarity and size of an image, influencing how it appears on screens and in print.
                
                Accurate understanding and management of digital image resolution are essential for creating high-quality visuals and ensuring they meet the necessary specifications for their intended use.
                """
        case .frequencyWavelength:
            return """
                Frequency wavelength describes the relationship between the frequency of a wave and its wavelength. It represents how the spatial length of one cycle of a wave is related to how often the wave cycles occur per second.
                
                The frequency of a wave is the number of cycles per second, measured in hertz (Hz), while the wavelength (λ) is the distance between successive crests or troughs, measured in meters (m).
                
                The two are inversely related by the equation λ = c / f, where c is the speed of the wave in a medium (e.g., the speed of light in a vacuum is approximately 3 × 10^8 meters per second).
                
                For example, radio waves with lower frequencies have longer wavelengths, while higher frequencies like X-rays have shorter wavelengths.
                
                Understanding the frequency-wavelength relationship is crucial in fields such as telecommunications, optics, and acoustics.
                """
        case .illumination:
            return """
                Illumination refers to the amount of light received on a surface area, typically measured in lux (lx) or foot-candles (fc). It describes how well-lit an area is, based on the intensity and distribution of light falling upon it.
                
                Illumination is crucial in various applications, including lighting design, photography, and architecture, as it affects visibility, aesthetics, and functionality.
                
                For instance, a well-lit workspace enhances productivity and reduces eye strain, while appropriate illumination in photography ensures accurate image capture.
                
                Understanding and measuring illumination helps in optimizing lighting conditions for different environments, ensuring that spaces are adequately lit for their intended use while minimizing energy consumption and improving overall lighting quality.
                """
        case .luminance:
            return """
                Luminance measures the amount of light emitted, transmitted, or reflected from a surface per unit area in a specific direction, and it indicates the brightness of that surface.
                
                The SI unit for luminance is the candela per square meter (cd/m²).
                
                It quantifies how much light is perceived by the human eye and is crucial in fields like photography, display technology, and lighting design.
                
                For example, a bright computer screen might have a luminance of 300 cd/m², making it more readable in various lighting conditions.
                
                Luminance is essential for understanding visual perception, optimizing display quality, and designing effective lighting systems.
                
                Accurate measurement of luminance ensures that visual displays and environments meet desired brightness levels for comfort and functionality.
                """
        case .luminousIntensity:
            return """
                Luminous intensity measures the amount of visible light emitted by a source per unit of solid angle, indicating how bright the source appears in a specific direction. It is quantified in candelas (cd), where one candela represents the luminous power emitted by a source in a particular direction.
                
                For example, a standard candle has a luminous intensity of about one candela.
                
                Luminous intensity is important in lighting design and photometry, helping to assess how effectively a light source illuminates an area or directs light.
                
                Accurate measurement of luminous intensity is crucial for creating effective lighting solutions, ensuring that light sources provide adequate brightness and meet specific requirements for various applications such as street lighting, stage lighting, and indoor illumination.
                """
        }
    }
    
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .luminance:
            return [
                ("cd/m²", "candela/square meter"),
                ("cd/cm²", "candela/square centimeter"),
                ("cd/ft²", "candela/square foot"),
                ("cd/in²", "candela/square inch"),
                ("kcd/m²", "kilocandela/square meter"),
                ("sb", "stilb"),
                ("lm/m²/sr", "lumen/sq. meter/steradian"),
                ("lm/cm²/sr", "lumen/sq. cm/steradian"),
                ("lm/ft²/sr", "lumen/square foot/steradian"),
                ("W/cm²/sr", "watt/sq. cm/steradian (at 555 nm)"),
                ("nt", "nit"),
                ("mnt", "millinit"),
                ("L", "lambert"),
                ("mL", "millilambert"),
                ("fL", "foot-lambert"),
                ("asb", "apostilb"),
                ("bl", "blondel"),
                ("bril", "bril"),
                ("sk", "skot")
            ]
        case .luminousIntensity:
            return [
                ("cd", "candle (international)"),
                ("cd (G)", "candle (German)"),
                ("cd (UK)", "candle (UK)"),
                ("dc", "decimal candle"),
                ("cp", "candle (pentane)"),
                ("10 cp", "pentane candle (10 candle power)"),
                ("HC", "hefner candle"),
                ("cu", "carcel unit"),
                ("bd", "bougie decimal"),
                ("lm/sr", "lumen/steradian")
            ]
        case .illumination:
            return [
                ("lx", "lux"),
                ("m·cd", "meter-candle"),
                ("cm·cd", "centimeter-candle"),
                ("fc", "foot-candle"),
                ("fl", "flame"),
                ("ph", "phot"),
                ("nx", "nox"),
                ("cd·sr/m²", "candela steradian/sq. meter"),
                ("lm/m²", "lumen/square meter"),
                ("lm/cm²", "lumen/square centimeter"),
                ("lm/ft²", "lumen/square foot"),
                ("W/cm²", "watt/sq. cm (at 555 nm)")
            ]
        case .digitalImageResolution:
            return [
                ("dpm", "dot/meter"),
                ("dpmm", "dot/millimeter"),
                ("dpi", "dot/inch"),
                ("ppi", "pixel/inch")
            ]
        case .frequencyWavelength:
            return [
                ("Hz", "hertz"),
                ("EHz", "exahertz"),
                ("PHz", "petahertz"),
                ("THz", "terahertz"),
                ("GHz", "gigahertz"),
                ("MHz", "megahertz"),
                ("kHz", "kilohertz"),
                ("hHz", "hectohertz"),
                ("daHz", "dekahertz"),
                ("dHz", "decihertz"),
                ("cHz", "centihertz"),
                ("mHz", "millihertz"),
                ("µHz", "microhertz"),
                ("nHz", "nanohertz"),
                ("pHz", "picohertz"),
                ("fHz", "femtohertz"),
                ("aHz", "attohertz"),
                ("c/s", "cycle/second"),
                ("λ Em", "wavelength in exametres"),
                ("λ Pm", "wavelength in petametres"),
                ("λ Tm", "wavelength in terametres"),
                ("λ Gm", "wavelength in gigametres"),
                ("λ Mm", "wavelength in megametres"),
                ("λ km", "wavelength in kilometres"),
                ("λ hm", "wavelength in hectometres"),
                ("λ dam", "wavelength in dekametres"),
                ("λ m", "wavelength in metres"),
                ("λ dm", "wavelength in decimetres"),
                ("λ cm", "wavelength in centimetres"),
                ("λ mm", "wavelength in millimetres"),
                ("λ µm", "wavelength in micrometres"),
                ("λ nm", "wavelength in nanometres"),
                ("λC,e", "Electron Compton wavelength"),
                ("λC,p", "Proton Compton wavelength"),
                ("λC,n", "Neutron Compton wavelength")
            ]
        }
    }
}