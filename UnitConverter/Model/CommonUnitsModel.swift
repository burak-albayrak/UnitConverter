//
//  UnitModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import Foundation

enum CommonUnitsCategory: String, CaseIterable, UnitCategory {
    case length = "Length"
    case mass = "Weight and Mass"
    case volume = "Volume"
    case temperature = "Temperature"
    case area = "Area"
    case pressure = "Pressure"
    case angle = "Angle"
    case speed = "Speed"
    case duration = "Duration"
    
    func convert(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
            switch self {
            case .length:
                return convertLength(value, from: fromUnit, to: toUnit)
            case .mass:
                return convertMass(value, from: fromUnit, to: toUnit)
            case .volume:
                return convertVolume(value, from: fromUnit, to: toUnit)
            case .temperature:
                return convertTemperature(value, from: fromUnit, to: toUnit)
            case .area:
                return convertArea(value, from: fromUnit, to: toUnit)
            case .pressure:
                return convertPressure(value, from: fromUnit, to: toUnit)
            case .angle:
                return convertAngle(value, from: fromUnit, to: toUnit)
            case .speed:
                return convertSpeed(value, from: fromUnit, to: toUnit)
            case .duration:
                return convertDuration(value, from: fromUnit, to: toUnit)
                
            }
        }

    private func convertLength(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let meterValues: [String: Double] = [
            "meter": 1,
            "kilometer": 1000,
            "decimeter": 0.1,
            "centimeter": 0.01,
            "millimeter": 0.001,
            "micrometer": 1e-6,
            "nanometer": 1e-9,
            "mile": 1609.344,
            "yard": 0.9144,
            "foot": 0.3048,
            "inch": 0.0254,
            "light year": 9.46073047258e15,
            "exameter": 1e18,
            "petameter": 1e15,
            "terameter": 1e12,
            "gigameter": 1e9,
            "megameter": 1e6,
            "hectometer": 100,
            "dekameter": 10,
            "micron": 1e-6,
            "picometer": 1e-12,
            "femtometer": 1e-15,
            "attometer": 1e-18,
            "megaparsec": 3.08567758128e22,
            "kiloparsec": 3.08567758128e19,
            "parsec": 3.08567758128e16,
            "astronomical unit": 149597870691,
            "league": 4828.032,
            "nautical league (UK)": 5559.552,
            "nautical league (int.)": 5556,
            "league (statute)": 4828.0416560833,
            "nautical mile (UK)": 1853.184,
            "nautical mile (international)": 1852,
            "mile (statute)": 1609.3472186944,
            "mile (US survey)": 1609.3472186944,
            "mile (Roman)": 1479.804,
            "kiloyard": 914.4,
            "furlong": 201.168,
            "furlong (US survey)": 201.1684023368,
            "chain": 20.1168,
            "chain (US survey)": 20.1168402337,
            "rope": 6.096,
            "rod": 5.0292,
            "rod (US survey)": 5.0292100584,
            "perch": 5.0292,
            "pole": 5.0292,
            "fathom": 1.8288,
            "fathom (US survey)": 1.8288036576,
            "ell": 1.143,
            "foot (US survey)": 0.3048006096,
            "link": 0.201168,
            "link (US survey)": 0.2011684023,
            "cubit (UK)": 0.4572,
            "hand": 0.1016,
            "span (cloth)": 0.2286,
            "finger (cloth)": 0.1143,
            "nail (cloth)": 0.05715,
            "inch (US survey)": 0.0254000508,
            "barleycorn": 0.0084666667,
            "mil": 2.54e-5,
            "microinch": 2.54e-8,
            "angstrom": 1e-10,
            "a.u. of length": 5.2917724900001e-11,
            "X-unit": 1.00208e-13,
            "fermi": 1e-15,
            "arpent": 58.5216,
            "pica": 0.0042333333,
            "point": 0.0003527778,
            "twip": 1.76389e-5,
            "aln": 0.5937777778,
            "famn": 1.7813333333,
            "caliber": 0.000254,
            "centiinch": 0.000254,
            "ken": 2.11836,
            "Russian archin": 0.7112,
            "Roman actus": 35.47872,
            "vara de tarea": 2.505456,
            "vara conuquera": 2.505456,
            "vara castellana": 0.835152,
            "cubit (Greek)": 0.462788,
            "long reed": 3.2004,
            "reed": 2.7432,
            "long cubit": 0.5334,
            "handbreadth": 0.0762,
            "fingerbreadth": 0.01905,
            "Planck length": 1.61605e-35,
            "Electron radius (classical)": 2.81794092e-15,
            "Bohr radius": 5.2917724900001e-11,
            "Earth's equatorial radius": 6378160,
            "Earth's polar radius": 6356776.9999999,
            "Earth's distance from sun": 149600000000,
            "Sun's radius": 696000000
        ]

        guard let fromValue = meterValues[fromUnit.lowercased()], let toValue = meterValues[toUnit.lowercased()] else {
            return value
        }

        let meters = value * fromValue
        return meters / toValue
    }
    
    private func convertMass(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let kilogramValues: [String: Double] = [
            "kilogram": 1,
            "gram": 0.001,
            "milligram": 1e-6,
            "ton (metric)": 1000,
            "pound": 0.45359237,
            "ounce": 0.0283495231,
            "carat": 0.0002,
            "ton (short)": 907.18474,
            "ton (long)": 1016.0469088,
            "Atomic mass unit": 1.6605402e-27,
            "exagram": 1e15,
            "petagram": 1e12,
            "teragram": 1e9,
            "gigagram": 1e6,
            "megagram": 1000,
            "hectogram": 0.1,
            "dekagram": 0.01,
            "decigram": 0.0001,
            "centigram": 1e-5,
            "microgram": 1e-9,
            "nanogram": 1e-12,
            "picogram": 1e-15,
            "femtogram": 1e-18,
            "attogram": 1e-21,
            "dalton": 1.6605300000013e-27,
            "kilogram-force square second/meter": 9.80665,
            "kilopound": 453.59237,
            "kip": 453.59237,
            "slug": 14.5939029372,
            "pound-force square second/foot": 14.5939029372,
            "pound (troy or apothecary)": 0.3732417216,
            "poundal": 0.0140867196,
            "ton (assay) (US)": 0.02916667,
            "ton (assay) (UK)": 0.0326666667,
            "kiloton (metric)": 1e6,
            "quintal (metric)": 100,
            "hundredweight (US)": 45.359237,
            "hundredweight (UK)": 50.80234544,
            "quarter (US)": 11.33980925,
            "quarter (UK)": 12.70058636,
            "stone (US)": 5.669904625,
            "stone (UK)": 6.35029318,
            "tonne": 1000,
            "pennyweight": 0.0015551738,
            "scruple (apothecary)": 0.0012959782,
            "grain": 6.47989e-5,
            "gamma": 1e-9,
            "talent (Biblical Hebrew)": 34.2,
            "mina (Biblical Hebrew)": 0.57,
            "shekel (Biblical Hebrew)": 0.0114,
            "bekan (Biblical Hebrew)": 0.0057,
            "gerah (Biblical Hebrew)": 0.00057,
            "talent (Biblical Greek)": 20.4,
            "mina (Biblical Greek)": 0.34,
            "tetradrachma (Biblical Greek)": 0.0136,
            "didrachma (Biblical Greek)": 0.0068,
            "drachma (Biblical Greek)": 0.0034,
            "denarius (Biblical Roman)": 0.00385,
            "assarion (Biblical Roman)": 0.000240625,
            "quadrans (Biblical Roman)": 6.01563e-5,
            "lepton (Biblical Roman)": 3.00781e-5,
            "Planck mass": 2.17671e-8,
            "Electron mass (rest)": 9.1093897e-31,
            "Muon mass": 1.8835327e-28,
            "Proton mass": 1.6726231e-27,
            "Neutron mass": 1.6749286e-27,
            "Deuteron mass": 3.343586e-27,
            "Earth's mass": 5.9760000000002e24,
            "Sun's mass": 2e30
        ]

        guard let fromValue = kilogramValues[fromUnit.lowercased()], let toValue = kilogramValues[toUnit.lowercased()] else {
            return value
        }

        let kilograms = value * fromValue
        return kilograms / toValue
    }
    
    private func convertVolume(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let cubicMeterValues: [String: Double] = [
            "cubic meter": 1,
            "cubic kilometer": 1e9,
            "cubic centimeter": 1e-6,
            "cubic millimeter": 1e-9,
            "liter": 0.001,
            "milliliter": 1e-6,
            "gallon (US)": 0.0037854118,
            "quart (US)": 0.0009463529,
            "pint (US)": 0.0004731765,
            "cup (US)": 0.0002365882,
            "tablespoon (US)": 1.47868e-5,
            "teaspoon (US)": 4.92892159375e-6,
            "cubic mile": 4168181825.4406,
            "cubic yard": 0.764554858,
            "cubic foot": 0.0283168466,
            "cubic inch": 1.63871e-5,
            "cubic decimeter": 0.001,
            "exaliter": 1e15,
            "petaliter": 1e12,
            "teraliter": 1e9,
            "gigaliter": 1e6,
            "megaliter": 1000,
            "kiloliter": 1,
            "hectoliter": 0.1,
            "dekaliter": 0.01,
            "deciliter": 0.0001,
            "centiliter": 1e-5,
            "microliter": 1e-9,
            "nanoliter": 1e-12,
            "picoliter": 1e-15,
            "femtoliter": 1e-18,
            "attoliter": 1e-21,
            "cc": 1e-6,
            "drop": 5e-8,
            "barrel (oil)": 0.1589872949,
            "barrel (US)": 0.1192404712,
            "barrel (UK)": 0.16365924,
            "gallon (UK)": 0.00454609,
            "quart (UK)": 0.0011365225,
            "pint (UK)": 0.0005682613,
            "cup (metric)": 0.00025,
            "cup (UK)": 0.0002841306,
            "fluid ounce (US)": 2.95735e-5,
            "fluid ounce (UK)": 2.84131e-5,
            "tablespoon (metric)": 1.5e-5,
            "tablespoon (UK)": 1.77582e-5,
            "dessertspoon (US)": 9.8578431875e-6,
            "dessertspoon (UK)": 1.18388e-5,
            "teaspoon (metric)": 5e-6,
            "teaspoon (UK)": 5.9193880208333e-6,
            "gill (US)": 0.0001182941,
            "gill (UK)": 0.0001420653,
            "minim (US)": 6.1611519921875e-8,
            "minim (UK)": 5.9193880208333e-8,
            "ton register": 2.8316846592,
            "ccf": 2.8316846592,
            "hundred-cubic foot": 2.8316846592,
            "acre-foot": 1233.4818375475,
            "acre-foot (US survey)": 1233.4892384682,
            "acre-inch": 102.790153129,
            "dekastere": 10,
            "stere": 1,
            "decistere": 0.1,
            "cord": 3.6245563638,
            "tun": 0.9539237696,
            "hogshead": 0.2384809424,
            "board foot": 0.0023597372,
            "dram": 3.6966911953125e-6,
            "cor (Biblical)": 0.22,
            "homer (Biblical)": 0.22,
            "bath (Biblical)": 0.022,
            "hin (Biblical)": 0.0036666667,
            "cab (Biblical)": 0.0012222222,
            "log (Biblical)": 0.0003055556,
            "Taza (Spanish)": 0.0002365882,
            "Earth's volume": 1.083e21
        ]

        guard let fromValue = cubicMeterValues[fromUnit.lowercased()], let toValue = cubicMeterValues[toUnit.lowercased()] else {
            return value
        }

        let cubicMeters = value * fromValue
        return cubicMeters / toValue
    }
    
    private func convertTemperature(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
            // Önce her birimi Kelvin'e çevirelim
            let kelvin: Double
            switch fromUnit.lowercased() {
            case "kelvin", "k":
                kelvin = value
            case "celsius", "°c":
                kelvin = value + 273.15
            case "fahrenheit", "°f":
                kelvin = (value - 32) * 5/9 + 273.15
            case "rankine", "°r":
                kelvin = value * 5/9
            case "reaumur", "°re":
                kelvin = value * 5/4 + 273.15
            case "triple point of water":
                kelvin = 273.16
            default:
                return value
            }
        
        // Şimdi Kelvin'i hedef birime çevirelim
        switch toUnit.lowercased() {
        case "kelvin", "k":
            return kelvin
        case "celsius", "°c":
            return kelvin - 273.15
        case "fahrenheit", "°f":
            return (kelvin - 273.15) * 9/5 + 32
        case "rankine", "°r":
            return kelvin * 9/5
        case "reaumur", "°re":
            return (kelvin - 273.15) * 4/5
        case "triple point of water":
            return 273.16
        default:
            return value // Bilinmeyen birim, orijinal değeri döndür
        }
    }
    
    private func convertArea(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let squareMeterValues: [String: Double] = [
            "square meter": 1,
            "square kilometer": 1e6,
            "square centimeter": 1e-4,
            "square millimeter": 1e-6,
            "square micrometer": 1e-12,
            "hectare": 1e4,
            "acre": 4046.8564224,
            "square mile": 2589988.110336,
            "square yard": 0.83612736,
            "square foot": 0.09290304,
            "square inch": 0.00064516,
            "square hectometer": 1e4,
            "square dekameter": 100,
            "square decimeter": 0.01,
            "square nanometer": 1e-18,
            "are": 100,
            "barn": 1e-28,
            "square mile (US survey)": 2589998.4703195,
            "square foot (US survey)": 0.0929034116,
            "circular inch": 0.0005067075,
            "township": 93239571.972096,
            "section": 2589988.110336,
            "acre (US survey)": 4046.8726098743,
            "rood": 1011.7141056,
            "square chain": 404.68564224,
            "square rod": 25.29285264,
            "square rod (US survey)": 25.2929538117,
            "square perch": 25.29285264,
            "square pole": 25.29285264,
            "square mil": 6.4516e-10,
            "circular mil": 5.067074790975e-10,
            "homestead": 647497.027584,
            "sabin": 0.09290304,
            "arpent": 3418.8929236669,
            "cuerda": 3930.395625,
            "plaza": 6400,
            "varas castellanas cuad": 0.698737,
            "varas conuqueras cuad": 6.288633,
            "Electron cross section": 6.6524615999999e-29
        ]

        guard let fromValue = squareMeterValues[fromUnit.lowercased()], let toValue = squareMeterValues[toUnit.lowercased()] else {
            return value
        }

        let squareMeters = value * fromValue
        return squareMeters / toValue
    }
    
    private func convertPressure(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let pascalValues: [String: Double] = [
            "pascal": 1,
            "kilopascal": 1000,
            "bar": 100000,
            "psi": 6894.7572931783,
            "ksi": 6894757.2931783,
            "Standard atmosphere": 101325,
            "exapascal": 1e18,
            "petapascal": 1e15,
            "terapascal": 1e12,
            "gigapascal": 1e9,
            "megapascal": 1e6,
            "hectopascal": 100,
            "dekapascal": 10,
            "decipascal": 0.1,
            "centipascal": 0.01,
            "millipascal": 0.001,
            "micropascal": 1e-6,
            "nanopascal": 1e-9,
            "picopascal": 1e-12,
            "femtopascal": 1e-15,
            "attopascal": 1e-18,
            "newton/square meter": 1,
            "newton/square centimeter": 10000,
            "newton/square millimeter": 1000000,
            "kilonewton/square meter": 1000,
            "millibar": 100,
            "microbar": 0.1,
            "dyne/square centimeter": 0.1,
            "kilogram-force/square meter": 9.80665,
            "kilogram-force/sq. cm": 98066.5,
            "kilogram-force/sq. millimeter": 9806650,
            "gram-force/sq. centimeter": 98.0665,
            "ton-force (short)/sq. foot": 95760.517960678,
            "ton-force (short)/sq. inch": 13789514.586338,
            "ton-force (long)/square foot": 107251.78011595,
            "ton-force (long)/square inch": 15444256.336697,
            "kip-force/square inch": 6894757.2931783,
            "pound-force/square foot": 47.8802589804,
            "pound-force/square inch": 6894.7572931783,
            "poundal/square foot": 1.4881639436,
            "torr": 133.3223684211,
            "centimeter mercury (0°C)": 1333.22,
            "millimeter mercury (0°C)": 133.322,
            "inch mercury (32°F)": 3386.38,
            "inch mercury (60°F)": 3376.85,
            "centimeter water (4°C)": 98.0638,
            "millimeter water (4°C)": 9.80638,
            "inch water (4°C)": 249.082,
            "foot water (4°C)": 2988.98,
            "inch water (60°F)": 248.843,
            "foot water (60°F)": 2986.116,
            "atmosphere technical": 98066.500000003
        ]

        guard let fromValue = pascalValues[fromUnit.lowercased()], let toValue = pascalValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let pascals = value * fromValue
        return pascals / toValue
    }
    
    private func convertAngle(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let degreeValues: [String: Double] = [
            "degree": 1,
            "radian": 57.2957795131,
            "grad": 0.9,
            "minute": 1/60,
            "second": 1/3600,
            "gon": 0.9,
            "sign": 30,
            "mil": 0.05625,
            "revolution": 360,
            "circle": 360,
            "turn": 360,
            "quadrant": 90,
            "right angle": 90,
            "sextant": 60
        ]

        guard let fromValue = degreeValues[fromUnit.lowercased()], let toValue = degreeValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }

        let degrees = value * fromValue
        return degrees / toValue
    }
    
    private func convertSpeed(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let meterPerSecondValues: [String: Double] = [
            "meter/second": 1,
            "kilometer/hour": 0.2777777778,
            "mile/hour": 0.44704,
            "meter/hour": 0.0002777778,
            "meter/minute": 0.0166666667,
            "kilometer/minute": 16.6666666667,
            "kilometer/second": 1000,
            "centimeter/hour": 2.7777777777778E-6,
            "centimeter/minute": 0.0001666667,
            "centimeter/second": 0.01,
            "millimeter/hour": 2.7777777777778E-7,
            "millimeter/minute": 1.66667E-5,
            "millimeter/second": 0.001,
            "foot/hour": 8.46667E-5,
            "foot/minute": 0.00508,
            "foot/second": 0.3048,
            "yard/hour": 0.000254,
            "yard/minute": 0.01524,
            "yard/second": 0.9144,
            "mile/minute": 26.8224,
            "mile/second": 1609.344,
            "knot": 0.5144444444,
            "knot (UK)": 0.5147733333,
            "Velocity of light in vacuum": 299792458,
            "Cosmic velocity - first": 7899.9999999999,
            "Cosmic velocity - second": 11200,
            "Cosmic velocity - third": 16670,
            "Earth's velocity": 29765,
            "Velocity of sound in pure water": 1482.6999999998,
            "Velocity of sound in sea water (20°C, 10 meter deep)": 1521.6,
            "Mach (20°C, 1 atm)": 343.6,
            "Mach (SI standard)": 295.0464000003
        ]
        
        guard let fromValue = meterPerSecondValues[fromUnit.lowercased()], let toValue = meterPerSecondValues[toUnit.lowercased()] else {
            return value
        }

        let meterPerSecond = value * fromValue
        return meterPerSecond / toValue
    }
        
    private func convertDuration(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let secondValues: [String: Double] = [
            "second": 1,
            "millisecond": 0.001,
            "minute": 60,
            "hour": 3600,
            "day": 86400,
            "week": 604800,
            "month": 2628000,
            "year": 31557600,
            "decade": 315576000,
            "century": 3155760000,
            "millennium": 31557600000,
            "microsecond": 1e-6,
            "nanosecond": 1e-9,
            "picosecond": 1e-12,
            "femtosecond": 1e-15,
            "attosecond": 1e-18,
            "shake": 1e-8,
            "month (synodic)": 2551443.84,
            "year (Julian)": 31557600,
            "year (leap)": 31622400,
            "year (tropical)": 31556930,
            "year (sidereal)": 31558149.54,
            "day (sidereal)": 86164.09,
            "hour (sidereal)": 3590.1704166667,
            "minute (sidereal)": 59.8361736111,
            "second (sidereal)": 0.9972695602,
            "fortnight": 1209600,
            "septennial": 220752000,
            "octennial": 252288000,
            "novennial": 283824000,
            "quindecennial": 473040000,
            "quinquennial": 157680000,
            "Planck time": 5.39056e-44
        ]
        
        guard let fromValue = secondValues[fromUnit.lowercased()], let toValue = secondValues[toUnit.lowercased()] else {
            return value 
        }

        let seconds = value * fromValue
        return seconds / toValue
    }
    
    var icon: String {
        switch self {
        case .mass:
            return "scalemass"
        case .length:
            return "ruler"
        case .area:
            return "skew"
        case .volume:
            return "pyramid"
        case .pressure:
            return "barometer"
        case .temperature:
            return "thermometer"
        case .angle:
            return "angle"
        case .speed:
            return "gauge.with.dots.needle.67percent"
        case .duration:
            return "stopwatch"
        }
    }

    
    var info: String {
        switch self {
        case .mass:
            return """
            Mass measures the amount of matter in an object, and its SI unit is the kilogram (kg). It is a fundamental property of physical objects and remains constant regardless of location. 
            
            Mass is used to quantify the resistance of an object to acceleration when a force is applied.

            Weight, on the other hand, is the force exerted by gravity on an object’s mass. Its SI unit is the newton (N), defined as the force needed to accelerate a one-kilogram mass by one meter per second squared.
            
            Weight varies depending on the gravitational field strength of the location. For example, an object weighs less on the Moon than on Earth due to the Moon’s weaker gravity. 
            
            Both weight and mass are crucial in physics and engineering, but they measure different properties of matter.
            """
        case .length:
            return """
                Length is a measure of how long an object is from one end to the other. It is one of the fundamental dimensions in physics and engineering. 
                
                In the International System of Units (SI), the base unit for length is the meter (m).
                
                Length can be measured in various units, such as kilometers (km), centimeters (cm), and millimeters (mm), each of which is a derived unit based on the meter.
                
                For example, one kilometer equals 1,000 meters, and one centimeter equals 0.01 meters. These units are used in everyday life, scientific research, and engineering to quantify the size or extent of objects and distances.
                """
        case .area:
            return """
            Area measures the extent of a two-dimensional surface or shape. It quantifies the amount of space within a boundary and is a key concept in geometry, architecture, and various scientific fields.
            
            The SI unit for area is the square meter (m²), which represents the area of a square with sides of one meter. 
            
            Other commonly used units include square kilometers (km²), square centimeters (cm²), and square millimeters (mm²). For instance, one square kilometer equals one million square meters.
            
            Area is used to determine the size of land plots, the surface of objects, and the amount of material needed for coverage. Accurate area calculations are essential in tasks ranging from land surveying to designing floor plans.
            """
        case .volume:
            return """
                Volume refers to the amount of three-dimensional space an object or substance occupies. It is a critical measurement in various scientific and practical applications, including fluid dynamics, engineering, and everyday life.
                
                The SI unit for volume is the cubic meter (m³), which represents the space occupied by a cube with sides of one meter in length.
                
                Other common units include liters (L), where one liter equals one cubic decimeter (dm³), and milliliters (mL), where one milliliter equals one cubic centimeter (cm³). 
                
                Volume measurements are essential for determining quantities in cooking, filling containers, and calculating capacities in engineering tasks. Understanding volume is fundamental for working with liquids, gases, and solids.
                """
        case .pressure:
            return """
                Pressure is the force exerted per unit area on the surface of an object. It is a fundamental concept in physics and engineering, relevant to gases, liquids, and solids.
                
                The SI unit of pressure is the pascal (Pa), defined as one newton per square meter (N/m²).
                
                Pressure can also be measured in other units, such as atmospheres (atm), where one atmosphere equals 101,325 pascals, and bar, where one bar is equal to 100,000 pascals. 
                
                Pressure is crucial in various applications, including fluid dynamics, meteorology, and engineering.
                
                It helps in understanding phenomena like weather patterns, hydraulic systems, and gas laws, and is essential for designing equipment that operates under different pressure conditions.
                """
        case .temperature:
            return """
                Temperature measures the thermal energy or heat within a substance, indicating how hot or cold it is. It is a fundamental physical quantity used in various scientific and everyday contexts.
                
                The SI unit for temperature is the kelvin (K), where zero kelvin (0 K) represents absolute zero, the point at which atomic motion ceases.
                
                Temperature is also commonly measured in degrees Celsius (°C) and degrees Fahrenheit (°F). In the Celsius scale, water freezes at 0°C and boils at 100°C under standard atmospheric conditions. In Fahrenheit, water freezes at 32°F and boils at 212°F.
                
                Accurate temperature measurement is vital for processes ranging from weather forecasting to chemical reactions and everyday temperature control.
                """
        case .angle:
            return """
                An angle represents the space between two intersecting lines or surfaces, measured in degrees or radians. It is a fundamental concept in geometry and trigonometry.
                
                The SI unit for angles is the radian (rad), where one radian is the angle formed when the arc length of a circle is equal to the radius.
                
                Another common unit is the degree (°), where a full circle is divided into 360 degrees. For example, a right angle is 90°, and a full circle is 360°.
                
                Angles are essential in various fields such as navigation, engineering, and physics, helping to describe rotations, slopes, and the orientation of objects. Accurate angle measurement is crucial for precise calculations and designs.
                """
        case .speed:
            return """
                Speed measures the rate at which an object moves or changes its position over time. It is a fundamental concept in physics and everyday life, describing how quickly something travels. 
                
                The SI unit for speed is meters per second (m/s), representing the distance covered in meters within one second.
                
                Other common units include kilometers per hour (km/h) and miles per hour (mph). For example, a car traveling at 60 km/h covers 60 kilometers in one hour.
                
                Speed is essential in various applications, from vehicle performance and sports to scientific experiments and navigation. 
                
                Understanding speed is crucial for analyzing motion, optimizing performance, and ensuring safety in different contexts.
                """
        case .duration:
            return """
                Duration refers to the total time interval during which an event or activity occurs. It measures how long something lasts, from its start to its end.
                
                Duration is a fundamental concept in timekeeping and planning, used to quantify the length of various activities, from short tasks to long-term projects.
                
                The SI unit for duration is the second (s), but it is often expressed in larger units such as minutes, hours, days, or even years.
                
                For instance, an event lasting 5 minutes is measured as 300 seconds.
                
                Accurate duration measurement is crucial for scheduling, project management, and time-based calculations in diverse fields including science, engineering, and daily life.
                """
        }
    }
    
    var availableUnits: [String] {
        switch self {
        case .length:
            return [
                "meter", "kilometer", "decimeter", "centimeter", "millimeter", "micrometer", "nanometer",
                "mile", "yard", "foot", "inch", "light year", "exameter", "petameter", "terameter",
                "gigameter", "megameter", "hectometer", "dekameter", "micron", "picometer", "femtometer",
                "attometer", "megaparsec", "kiloparsec", "parsec", "astronomical unit", "league",
                "nautical league (UK)", "nautical league (int.)", "league (statute)", "nautical mile (UK)",
                "nautical mile (international)", "mile (statute)", "mile (US survey)", "mile (Roman)",
                "kiloyard", "furlong", "furlong (US survey)", "chain", "chain (US survey)", "rope",
                "rod", "rod (US survey)", "perch", "pole", "fathom", "fathom (US survey)", "ell",
                "foot (US survey)", "link", "link (US survey)", "cubit (UK)", "hand", "span (cloth)",
                "finger (cloth)", "nail (cloth)", "inch (US survey)", "barleycorn", "mil", "microinch",
                "angstrom", "a.u. of length", "X-unit", "fermi", "arpent", "pica", "point", "twip",
                "aln", "famn", "caliber", "centiinch", "ken", "Russian archin", "Roman actus",
                "vara de tarea", "vara conuquera", "vara castellana", "cubit (Greek)", "long reed",
                "reed", "long cubit", "handbreadth", "fingerbreadth", "Planck length",
                "Electron radius (classical)", "Bohr radius", "Earth's equatorial radius",
                "Earth's polar radius", "Earth's distance from sun", "Sun's radius"
            ]
        case .mass:
            return [
                "kilogram", "gram", "milligram", "ton (metric)", "pound", "ounce", "carat",
                "ton (short)", "ton (long)", "Atomic mass unit", "exagram", "petagram", "teragram",
                "gigagram", "megagram", "hectogram", "dekagram", "decigram", "centigram", "microgram",
                "nanogram", "picogram", "femtogram", "attogram", "dalton",
                "kilogram-force square second/meter", "kilopound", "kip", "slug",
                "pound-force square second/foot", "pound (troy or apothecary)", "poundal",
                "ton (assay) (US)", "ton (assay) (UK)", "kiloton (metric)", "quintal (metric)",
                "hundredweight (US)", "hundredweight (UK)", "quarter (US)", "quarter (UK)",
                "stone (US)", "stone (UK)", "tonne", "pennyweight", "scruple (apothecary)", "grain",
                "gamma", "talent (Biblical Hebrew)", "mina (Biblical Hebrew)", "shekel (Biblical Hebrew)",
                "bekan (Biblical Hebrew)", "gerah (Biblical Hebrew)", "talent (Biblical Greek)",
                "mina (Biblical Greek)", "tetradrachma (Biblical Greek)", "didrachma (Biblical Greek)",
                "drachma (Biblical Greek)", "denarius (Biblical Roman)", "assarion (Biblical Roman)",
                "quadrans (Biblical Roman)", "lepton (Biblical Roman)", "Planck mass",
                "Electron mass (rest)", "Muon mass", "Proton mass", "Neutron mass", "Deuteron mass",
                "Earth's mass", "Sun's mass"
            ]
        case .volume:
            return [
                "cubic meter", "cubic kilometer", "cubic centimeter", "cubic millimeter", "liter",
                "milliliter", "gallon (US)", "quart (US)", "pint (US)", "cup (US)", "tablespoon (US)",
                "teaspoon (US)", "cubic mile", "cubic yard", "cubic foot", "cubic inch", "cubic decimeter",
                "exaliter", "petaliter", "teraliter", "gigaliter", "megaliter", "kiloliter", "hectoliter",
                "dekaliter", "deciliter", "centiliter", "microliter", "nanoliter", "picoliter", "femtoliter",
                "attoliter", "cc", "drop", "barrel (oil)", "barrel (US)", "barrel (UK)", "gallon (UK)",
                "quart (UK)", "pint (UK)", "cup (metric)", "cup (UK)", "fluid ounce (US)", "fluid ounce (UK)",
                "tablespoon (metric)", "tablespoon (UK)", "dessertspoon (US)", "dessertspoon (UK)",
                "teaspoon (metric)", "teaspoon (UK)", "gill (US)", "gill (UK)", "minim (US)", "minim (UK)",
                "ton register", "ccf", "hundred-cubic foot", "acre-foot", "acre-foot (US survey)", "acre-inch",
                "dekastere", "stere", "decistere", "cord", "tun", "hogshead", "board foot", "dram",
                "cor (Biblical)", "homer (Biblical)", "bath (Biblical)", "hin (Biblical)", "cab (Biblical)",
                "log (Biblical)", "Taza (Spanish)", "Earth's volume"
            ]
        case .temperature:
            return ["Kelvin", "Celsius", "Fahrenheit", "Rankine", "Reaumur", "Triple point of water"]
        case .area:
            return [
                "square meter", "square kilometer", "square centimeter", "square millimeter",
                "square micrometer", "hectare", "acre", "square mile", "square yard", "square foot",
                "square inch", "square hectometer", "square dekameter", "square decimeter",
                "square nanometer", "are", "barn", "square mile (US survey)", "square foot (US survey)",
                "circular inch", "township", "section", "acre (US survey)", "rood", "square chain",
                "square rod", "square rod (US survey)", "square perch", "square pole", "square mil",
                "circular mil", "homestead", "sabin", "arpent", "cuerda", "plaza",
                "varas castellanas cuad", "varas conuqueras cuad", "Electron cross section"
            ]
        case .pressure:
            return [
                "pascal", "kilopascal", "bar", "psi", "ksi", "Standard atmosphere", "exapascal",
                "petapascal", "terapascal", "gigapascal", "megapascal", "hectopascal", "dekapascal",
                "decipascal", "centipascal", "millipascal", "micropascal", "nanopascal", "picopascal",
                "femtopascal", "attopascal", "newton/square meter", "newton/square centimeter",
                "newton/square millimeter", "kilonewton/square meter", "millibar", "microbar",
                "dyne/square centimeter", "kilogram-force/square meter", "kilogram-force/sq. cm",
                "kilogram-force/sq. millimeter", "gram-force/sq. centimeter", "ton-force (short)/sq. foot",
                "ton-force (short)/sq. inch", "ton-force (long)/square foot", "ton-force (long)/square inch",
                "kip-force/square inch", "pound-force/square foot", "pound-force/square inch",
                "poundal/square foot", "torr", "centimeter mercury (0°C)", "millimeter mercury (0°C)",
                "inch mercury (32°F)", "inch mercury (60°F)", "centimeter water (4°C)", "millimeter water (4°C)",
                "inch water (4°C)", "foot water (4°C)", "inch water (60°F)", "foot water (60°F)",
                "atmosphere technical"
            ]
        case .angle:
            return [
                "degree", "radian", "grad", "minute", "second", "gon", "sign", "mil",
                "revolution", "circle", "turn", "quadrant", "right angle", "sextant"
            ]
        case .speed:
            return [
                "meter/second", "kilometer/hour", "mile/hour", "meter/hour", "meter/minute",
                "kilometer/minute", "kilometer/second", "centimeter/hour", "centimeter/minute",
                "centimeter/second", "millimeter/hour", "millimeter/minute", "millimeter/second",
                "foot/hour", "foot/minute", "foot/second", "yard/hour", "yard/minute", "yard/second",
                "mile/minute", "mile/second", "knot", "knot (UK)", "Velocity of light in vacuum",
                "Cosmic velocity - first", "Cosmic velocity - second", "Cosmic velocity - third",
                "Earth's velocity", "Velocity of sound in pure water",
                "Velocity of sound in sea water (20°C, 10 meter deep)", "Mach (20°C, 1 atm)",
                "Mach (SI standard)"
            ]
        case .duration:
            return [
                "second", "millisecond", "minute", "hour", "day", "week", "month", "year",
                "decade", "century", "millennium", "microsecond", "nanosecond", "picosecond",
                "femtosecond", "attosecond", "shake", "month (synodic)", "year (Julian)",
                "year (leap)", "year (tropical)", "year (sidereal)", "day (sidereal)",
                "hour (sidereal)", "minute (sidereal)", "second (sidereal)", "fortnight",
                "septennial", "octennial", "novennial", "quindecennial", "quinquennial",
                "Planck time"
            ]
        }
    }
}
