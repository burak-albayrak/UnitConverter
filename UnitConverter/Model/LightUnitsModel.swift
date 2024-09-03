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
    
    var availableUnits: [Dimension] {
        switch self {
        case .digitalImageResolution:
            return [
                UnitArea.squareMegameters,
                UnitArea.squareKilometers,
                UnitArea.squareMeters,
                UnitArea.squareCentimeters,
                UnitArea.squareMillimeters,
                UnitArea.squareNanometers,
                UnitArea.squareInches,
                UnitArea.squareFeet,
                UnitArea.squareYards,
                UnitArea.squareMiles,
                UnitArea.acres,
                UnitArea.ares,
                UnitArea.hectares
            ]
            
        case .frequencyWavelength:
            return [
                UnitLength.megameters,
                UnitLength.kilometers,
                UnitLength.hectometers,
                UnitLength.decameters,
                UnitLength.meters,
                UnitLength.decimeters,
                UnitLength.centimeters,
                UnitLength.millimeters,
                UnitLength.micrometers,
                UnitLength.nanometers,
                UnitLength.picometers,
                UnitLength.inches,
                UnitLength.feet,
                UnitLength.yards,
                UnitLength.miles,
                UnitLength.scandinavianMiles,
                UnitLength.lightyears,
                UnitLength.nauticalMiles,
                UnitLength.fathoms,
                UnitLength.astronomicalUnits,
                UnitLength.parsecs
            ]
            
        case .illumination:
            return [
                UnitPressure.newtonsPerMetersSquared,
                UnitPressure.gigapascals,
                UnitPressure.megapascals,
                UnitPressure.kilopascals,
                UnitPressure.hectopascals,
                UnitPressure.inchesOfMercury,
                UnitPressure.bars,
                UnitPressure.millibars,
                UnitPressure.millimetersOfMercury,
                UnitPressure.poundsForcePerSquareInch
            ]
            
        case .luminance:
            return [UnitTemperature.celsius,
                    UnitTemperature.fahrenheit,
                    UnitTemperature.kelvin]
            
        case .luminousIntensity:
            return [
                UnitVolume.megaliters,
                UnitVolume.kiloliters,
                UnitVolume.liters,
                UnitVolume.deciliters,
                UnitVolume.centiliters,
                UnitVolume.milliliters,
                UnitVolume.cubicKilometers,
                UnitVolume.cubicMeters,
                UnitVolume.cubicDecimeters,
                UnitVolume.cubicCentimeters,
                UnitVolume.cubicMillimeters,
                UnitVolume.cubicInches,
                UnitVolume.cubicFeet,
                UnitVolume.cubicYards,
                UnitVolume.cubicMiles,
                UnitVolume.acreFeet,
                UnitVolume.bushels,
                UnitVolume.teaspoons,
                UnitVolume.tablespoons,
                UnitVolume.fluidOunces,
                UnitVolume.cups,
                UnitVolume.pints,
                UnitVolume.quarts,
                UnitVolume.gallons,
                UnitVolume.imperialTeaspoons,
                UnitVolume.imperialTablespoons,
                UnitVolume.imperialFluidOunces,
                UnitVolume.imperialPints,
                UnitVolume.imperialQuarts,
                UnitVolume.imperialGallons,
                UnitVolume.metricCups
            ]
        }
    }
}

