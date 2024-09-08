//
//  EngineeringUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import Foundation

enum EngineeringUnitsCategory: String, CaseIterable, UnitCategory {
    case length = "Length"
    case mass = "Weight and Mass"
    case volume = "Volume"
    case temperature = "Temperature"
    case area = "Area"
    case pressure = "Pressure"
    case angle = "Angle"
    case speed = "Speed"
    case duration = "Duration"
    case energy = "Energy"
    case power = "Power"
    case force = "Force"
    case fuelConsumption = "Fuel Consumption"
    case volumeDry = "Volume - Dry"
    case velocityAngular = "Velocity - Angular"
    case acceleration = "Acceleration"
    case accelerationAngular = "Acceleration - Angular"
    case density = "Density"
    case specificVolume = "Specific Volume"
    case momentOfInertia = "Moment of Inertia"
    case momentOfForce = "Moment of Force"
    case torque = "Torque"
    
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
        case .energy:
            return convertEnergy(value, from: fromUnit, to: toUnit)
        case .power:
            return convertPower(value, from: fromUnit, to: toUnit)
        case .force:
            return convertForce(value, from: fromUnit, to: toUnit)
        case .duration:
            return convertDuration(value, from: fromUnit, to: toUnit)
        case .speed:
            return convertSpeed(value, from: fromUnit, to: toUnit)
        case .angle:
            return convertAngle(value, from: fromUnit, to: toUnit)
        case .fuelConsumption:
            return convertFuelConsumption(value, from: fromUnit, to: toUnit)
        case .volumeDry:
            return convertVolumeDry(value, from: fromUnit, to: toUnit)
        case .velocityAngular:
            return convertAngularVelocity(value, from: fromUnit, to: toUnit)
        case .acceleration:
            return convertAcceleration(value, from: fromUnit, to: toUnit)
        case .accelerationAngular:
            return convertAngularAcceleration(value, from: fromUnit, to: toUnit)
        case .density:
            return convertDensity(value, from: fromUnit, to: toUnit)
        case .specificVolume:
            return convertSpecificVolume(value, from: fromUnit, to: toUnit)
        case .momentOfInertia:
            return convertMomentOfInertia(value, from: fromUnit, to: toUnit)
        case .momentOfForce:
            return convertMomentOfForce(value, from: fromUnit, to: toUnit)
        case .torque:
            return convertTorque(value, from: fromUnit, to: toUnit)
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
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
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
            "decigram": 1e-4,
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
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let kilograms = value * fromValue
        return kilograms / toValue
    }
    
    private func convertVolume(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let cubicMeterValues: [String: Double] = [
            "cubic meter": 1,
            "cubic kilometer": 1000000000,
            "cubic centimeter": 1.0E-6,
            "cubic millimeter": 1.0E-9,
            "liter": 0.001,
            "milliliter": 1.0E-6,
            "gallon (US)": 0.0037854118,
            "quart (US)": 0.0009463529,
            "pint (US)": 0.0004731765,
            "cup (US)": 0.0002365882,
            "tablespoon (US)": 1.47868E-5,
            "teaspoon (US)": 4.92892159375E-6,
            "cubic mile": 4168181825.4406,
            "cubic yard": 0.764554858,
            "cubic foot": 0.0283168466,
            "cubic inch": 1.63871E-5,
            "cubic decimeter": 0.001,
            "exaliter": 1.0E+15,
            "petaliter": 1000000000000,
            "teraliter": 1000000000,
            "gigaliter": 1000000,
            "megaliter": 1000,
            "kiloliter": 1,
            "hectoliter": 0.1,
            "dekaliter": 0.01,
            "deciliter": 0.0001,
            "centiliter": 1.0E-5,
            "microliter": 1.0E-9,
            "nanoliter": 1.0E-12,
            "picoliter": 1.0E-15,
            "femtoliter": 1.0E-18,
            "attoliter": 1.0E-21,
            "cc": 1.0E-6,
            "drop": 5.0E-8,
            "barrel (oil)": 0.1589872949,
            "barrel (US)": 0.1192404712,
            "barrel (UK)": 0.16365924,
            "gallon (UK)": 0.00454609,
            "quart (UK)": 0.0011365225,
            "pint (UK)": 0.0005682613,
            "cup (metric)": 0.00025,
            "cup (UK)": 0.0002841306,
            "fluid ounce (US)": 2.95735E-5,
            "fluid ounce (UK)": 2.84131E-5,
            "tablespoon (metric)": 1.5E-5,
            "tablespoon (UK)": 1.77582E-5,
            "dessertspoon (US)": 9.8578431875E-6,
            "dessertspoon (UK)": 1.18388E-5,
            "teaspoon (metric)": 5.0E-6,
            "teaspoon (UK)": 5.9193880208333E-6,
            "gill (US)": 0.0001182941,
            "gill (UK)": 0.0001420653,
            "minim (US)": 6.1611519921875E-8,
            "minim (UK)": 5.9193880208333E-8,
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
            "dram": 3.6966911953125E-6,
            "cor (Biblical)": 0.22,
            "homer (Biblical)": 0.22,
            "bath (Biblical)": 0.022,
            "hin (Biblical)": 0.0036666667,
            "cab (Biblical)": 0.0012222222,
            "log (Biblical)": 0.0003055556,
            "Taza (Spanish)": 0.0002365882,
            "Earth's volume": 1.083E+21
        ]
        
        guard let fromValue = cubicMeterValues[fromUnit.lowercased()], let toValue = cubicMeterValues[toUnit.lowercased()] else {
            return value
        }
        
        let cubicMeter = value * fromValue
        return cubicMeter / toValue
    }
    
    private func convertTemperature(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        // Önce giriş değerini Kelvin'e çevirelim
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
            return value // Bilinmeyen birim, orijinal değeri döndür
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
            return kelvin / 273.16
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
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
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
    
    private func convertEnergy(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let jouleValues: [String: Double] = [
            "joule": 1,
            "kilojoule": 1000,
            "kilowatt-hour": 3600000,
            "watt-hour": 3600,
            "calorie (nutritional)": 4186.8,
            "horsepower (metric) hour": 2647795.5,
            "Btu (IT)": 1055.05585262,
            "Btu (th)": 1054.3499999744,
            "gigajoule": 1e9,
            "megajoule": 1e6,
            "millijoule": 0.001,
            "microjoule": 1e-6,
            "nanojoule": 1e-9,
            "attojoule": 1e-18,
            "megaelectron-volt": 1.6021766339999e-13,
            "kiloelectron-volt": 1.6021766339999e-16,
            "electron-volt": 1.6021766339999e-19,
            "erg": 1e-7,
            "gigawatt-hour": 3.6e12,
            "megawatt-hour": 3.6e9,
            "kilowatt-second": 1000,
            "watt-second": 1,
            "newton meter": 1,
            "horsepower hour": 2684519.5368856,
            "kilocalorie (IT)": 4186.8,
            "kilocalorie (th)": 4184,
            "calorie (IT)": 4.1868,
            "calorie (th)": 4.184,
            "mega Btu (IT)": 1055055852.62,
            "ton-hour (refrigeration)": 12660670.23144,
            "fuel oil equivalent @kiloliter": 40197627984.822,
            "fuel oil equivalent @barrel (US)": 6383087908.3509,
            "gigaton": 4.184e18,
            "megaton": 4.184e15,
            "kiloton": 4.184e12,
            "ton (explosives)": 4.184e9,
            "dyne centimeter": 1e-7,
            "gram-force meter": 0.00980665,
            "gram-force centimeter": 9.80665e-5,
            "kilogram-force centimeter": 0.0980665,
            "kilogram-force meter": 9.8066499997,
            "kilopond meter": 9.8066499997,
            "pound-force foot": 1.3558179483,
            "pound-force inch": 0.112984829,
            "ounce-force inch": 0.0070615518,
            "foot-pound": 1.3558179483,
            "inch-pound": 0.112984829,
            "inch-ounce": 0.0070615518,
            "poundal foot": 0.04214011,
            "therm": 105505600,
            "therm (EC)": 105505600,
            "therm (US)": 105480400,
            "Hartree energy": 4.3597482e-18,
            "Rydberg constant": 2.1798741e-18
        ]
        
        guard let fromValue = jouleValues[fromUnit.lowercased()], let toValue = jouleValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let joules = value * fromValue
        return joules / toValue
    }
    
    private func convertPower(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let wattValues: [String: Double] = [
            "watt": 1,
            "exawatt": 1e18,
            "petawatt": 1e15,
            "terawatt": 1e12,
            "gigawatt": 1e9,
            "megawatt": 1e6,
            "kilowatt": 1e3,
            "hectowatt": 1e2,
            "dekawatt": 1e1,
            "deciwatt": 1e-1,
            "centiwatt": 1e-2,
            "milliwatt": 1e-3,
            "microwatt": 1e-6,
            "nanowatt": 1e-9,
            "picowatt": 1e-12,
            "femtowatt": 1e-15,
            "attowatt": 1e-18,
            "horsepower": 745.6998715823,
            "horsepower (550 ft*lbf/s)": 745.6998715823,
            "horsepower (metric)": 735.49875,
            "horsepower (boiler)": 9809.5000000002,
            "horsepower (electric)": 746,
            "horsepower (water)": 746.043,
            "pferdestarke (ps)": 735.49875,
            "Btu (IT)/hour": 0.2930710702,
            "Btu (IT)/minute": 17.5842642103,
            "Btu (IT)/second": 1055.05585262,
            "Btu (th)/hour": 0.292875,
            "Btu (th)/minute": 17.5724999996,
            "Btu (th)/second": 1054.3499999744,
            "MBtu (IT)/hour": 293071.07017222,
            "MBH": 293.0710701722,
            "ton (refrigeration)": 3516.8528420667,
            "kilocalorie (IT)/hour": 1.163,
            "kilocalorie (IT)/minute": 69.78,
            "kilocalorie (IT)/second": 4186.8,
            "kilocalorie (th)/hour": 1.1622222222,
            "kilocalorie (th)/minute": 69.7333333333,
            "kilocalorie (th)/second": 4184,
            "calorie (IT)/hour": 0.001163,
            "calorie (IT)/minute": 0.06978,
            "calorie (IT)/second": 4.1868,
            "calorie (th)/hour": 0.0011622222,
            "calorie (th)/minute": 0.0697333333,
            "calorie (th)/second": 4.184,
            "foot pound-force/hour": 0.0003766161,
            "foot pound-force/minute": 0.0225969658,
            "foot pound-force/second": 1.3558179483,
            "pound-foot/hour": 0.0003766161,
            "pound-foot/minute": 0.0225969658,
            "pound-foot/second": 1.3558179483,
            "erg/second": 1e-7,
            "kilovolt ampere": 1000,
            "volt ampere": 1,
            "newton meter/second": 1,
            "joule/second": 1,
            "exajoule/second": 1e18,
            "petajoule/second": 1e15,
            "terajoule/second": 1e12,
            "gigajoule/second": 1e9,
            "megajoule/second": 1e6,
            "kilojoule/second": 1e3,
            "hectojoule/second": 1e2,
            "dekajoule/second": 1e1,
            "decijoule/second": 1e-1,
            "centijoule/second": 1e-2,
            "millijoule/second": 1e-3,
            "microjoule/second": 1e-6,
            "nanojoule/second": 1e-9,
            "picojoule/second": 1e-12,
            "femtojoule/second": 1e-15,
            "attojoule/second": 1e-18,
            "joule/hour": 0.0002777778,
            "joule/minute": 0.0166666667,
            "kilojoule/hour": 0.2777777778,
            "kilojoule/minute": 16.6666666667
        ]
        
        guard let fromValue = wattValues[fromUnit.lowercased()], let toValue = wattValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let watts = value * fromValue
        return watts / toValue
    }
    
    private func convertForce(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let newtonValues: [String: Double] = [
            "newton": 1,
            "kilonewton": 1000,
            "gram-force": 0.00980665,
            "kilogram-force": 9.80665,
            "ton-force (metric)": 9806.65,
            "exanewton": 1e18,
            "petanewton": 1e15,
            "teranewton": 1e12,
            "giganewton": 1e9,
            "meganewton": 1e6,
            "hectonewton": 100,
            "dekanewton": 10,
            "decinewton": 0.1,
            "centinewton": 0.01,
            "millinewton": 0.001,
            "micronewton": 1e-6,
            "nanonewton": 1e-9,
            "piconewton": 1e-12,
            "femtonewton": 1e-15,
            "attonewton": 1e-18,
            "dyne": 1e-5,
            "joule/meter": 1,
            "joule/centimeter": 0.01,
            "ton-force (short)": 8896.443230521,
            "ton-force (long)": 9964.0164181707,
            "kip-force": 4448.2216152548,
            "kilopound-force": 4448.2216152548,
            "pound-force": 4.4482216153,
            "ounce-force": 0.278013851,
            "poundal": 0.1382549544,
            "pound foot/square second": 0.1382549544,
            "pond": 0.00980665,
            "kilopond": 9.80665
        ]
        
        guard let fromValue = newtonValues[fromUnit.lowercased()], let toValue = newtonValues[toUnit.lowercased()] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let newtons = value * fromValue
        return newtons / toValue
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
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let seconds = value * fromValue
        return seconds / toValue
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
        
        guard let fromValue = meterPerSecondValues[fromUnit], let toValue = meterPerSecondValues[toUnit] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let meterPerSecond = value * fromValue
        return meterPerSecond / toValue
    }
    
    private func convertAngle(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let degreeValues: [String: Double] = [
            "degree": 1,
            "radian": 57.2957795131,
            "grad": 0.9,
            "minute": 0.0166666667,
            "second": 0.0002777778,
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
    
    private func convertFuelConsumption(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let meterPerLiterValues: [String: Double] = [
            "meter/liter": 1,
            "exameter/liter": 1e18,
            "petameter/liter": 1e15,
            "terameter/liter": 1e12,
            "gigameter/liter": 1e9,
            "megameter/liter": 1e6,
            "kilometer/liter": 1000,
            "hectometer/liter": 100,
            "dekameter/liter": 10,
            "centimeter/liter": 0.01,
            "mile (US)/liter": 1609.344,
            "nautical mile/liter": 1853.24496,
            "nautical mile/gallon (US)": 489.5755247,
            "kilometer/gallon (US)": 264.1720524,
            "meter/gallon (US)": 0.2641720524,
            "meter/gallon (UK)": 0.2199687986,
            "mile/gallon (US)": 425.1437075,
            "mile/gallon (UK)": 354.00619,
            "meter/cubic meter": 0.001,
            "meter/cubic centimeter": 1000,
            "meter/cubic yard": 0.0013079506,
            "meter/cubic foot": 0.0353146667,
            "meter/cubic inch": 61.02374409,
            "meter/quart (US)": 1.056688209,
            "meter/quart (UK)": 0.8798751948,
            "meter/pint (US)": 2.113376419,
            "meter/pint (UK)": 1.759750389,
            "meter/cup (US)": 4.226752838,
            "meter/cup (UK)": 3.519500777,
            "meter/fluid ounce (US)": 33.8140227,
            "meter/fluid ounce (UK)": 35.19500777,
            "liter/meter": 1,
            "liter/100 km": 100000,
            "gallon (US)/mile": 425.1437074976,
            "gallon (US)/100 mi": 42514.370749763,
            "gallon (UK)/mile": 354.0061899559,
            "gallon (UK)/100 mi": 35400.618995592
        ]
        
        guard let fromValue = meterPerLiterValues[fromUnit], let toValue = meterPerLiterValues[toUnit] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let meterPerLiter = value * fromValue
        return meterPerLiter / toValue
    }
    
    private func convertVolumeDry(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let literValues: [String: Double] = [
            "liter": 1,
            "barrel dry (US)": 115.6271236039,
            "pint dry (US)": 0.5506104714,
            "quart dry (US)": 1.1012209428,
            "peck (US)": 8.8097675424,
            "peck (UK)": 9.09218,
            "bushel (US)": 35.2390701696,
            "bushel (UK)": 36.36872,
            "cor (Biblical)": 219.9999892918,
            "homer (Biblical)": 219.9999892918,
            "ephah (Biblical)": 21.9999989292,
            "seah (Biblical)": 7.3333329764,
            "omer (Biblical)": 2.1999998929,
            "cab (Biblical)": 1.2222221627,
            "log (Biblical)": 0.3055555407
        ]
        
        guard let fromValue = literValues[fromUnit], let toValue = literValues[toUnit] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let liters = value * fromValue
        return liters / toValue
    }
    
    private func convertAngularVelocity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let radianPerSecondValues: [String: Double] = [
            "radian/second": 1,
            "radian/day": 1.15741E-5,
            "radian/hour": 0.0002777778,
            "radian/minute": 0.0166666667,
            "degree/day": 2.0200570046231E-7,
            "degree/hour": 4.8481368110954E-6,
            "degree/minute": 0.0002908882,
            "degree/second": 0.0174532925,
            "revolution/day": 7.27221E-5,
            "revolution/hour": 0.0017453293,
            "revolution/minute": 0.1047197551,
            "revolution/second": 6.2831853072
        ]
        
        guard let fromValue = radianPerSecondValues[fromUnit], let toValue = radianPerSecondValues[toUnit] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let radianPerSecond = value * fromValue
        return radianPerSecond / toValue
    }
    
    private func convertAcceleration(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let meterPerSquareSecondValues: [String: Double] = [
            "meter/square second": 1,
            "decimeter/square second": 0.1,
            "kilometer/square second": 1000,
            "hectometer/square second": 100,
            "dekameter/square second": 10,
            "centimeter/square second": 0.01,
            "millimeter/square second": 0.001,
            "micrometer/square second": 1e-6,
            "nanometer/square second": 1e-9,
            "picometer/square second": 1e-12,
            "femtometer/square second": 1e-15,
            "attometer/square second": 1e-18,
            "gal": 0.01,
            "galileo": 0.01,
            "mile/square second": 1609.344,
            "yard/square second": 0.9144,
            "foot/square second": 0.3048,
            "inch/square second": 0.0254,
            "Acceleration of gravity": 9.80665
        ]
        
        guard let fromValue = meterPerSquareSecondValues[fromUnit], let toValue = meterPerSquareSecondValues[toUnit] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let meterPerSquareSecond = value * fromValue
        return meterPerSquareSecond / toValue
    }
    
    private func convertAngularAcceleration(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let radianPerSquareSecondValues: [String: Double] = [
            "radian/square second": 1,
            "radian/square minute": 0.0002777778,
            "revolution/square second": 6.2831853069,
            "revolution/minute/second": 0.1047197551,
            "revolution/square minute": 0.0017453293
        ]
        
        guard let fromValue = radianPerSquareSecondValues[fromUnit], let toValue = radianPerSquareSecondValues[toUnit] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let radianPerSquareSecond = value * fromValue
        return radianPerSquareSecond / toValue
    }
    
    private func convertDensity(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let kilogramPerCubicMeterValues: [String: Double] = [
            "kilogram/cubic meter": 1,
            "gram/cubic centimeter": 1000,
            "kilogram/cubic centimeter": 1000000,
            "gram/cubic meter": 0.001,
            "gram/cubic millimeter": 1000000,
            "milligram/cubic meter": 1e-6,
            "milligram/cubic centimeter": 1,
            "milligram/cubic millimeter": 1000,
            "exagram/liter": 1e18,
            "petagram/liter": 1e15,
            "teragram/liter": 1e12,
            "gigagram/liter": 1e9,
            "megagram/liter": 1e6,
            "kilogram/liter": 1000,
            "hectogram/liter": 100,
            "dekagram/liter": 10,
            "gram/liter": 1,
            "decigram/liter": 0.1,
            "centigram/liter": 0.01,
            "milligram/liter": 0.001,
            "microgram/liter": 1e-6,
            "nanogram/liter": 1e-9,
            "picogram/liter": 1e-12,
            "femtogram/liter": 1e-15,
            "attogram/liter": 1e-18,
            "pound/cubic inch": 27679.904710191,
            "pound/cubic foot": 16.018463374,
            "pound/cubic yard": 0.5932764213,
            "pound/gallon (US)": 119.8264273167,
            "pound/gallon (UK)": 99.7763726631,
            "ounce/cubic inch": 1729.9940443869,
            "ounce/cubic foot": 1.0011539609,
            "ounce/gallon (US)": 7.4891517073,
            "ounce/gallon (UK)": 6.2360232914,
            "grain/gallon (US)": 0.017118061,
            "grain/gallon (UK)": 0.0142537675,
            "grain/cubic foot": 0.0022883519,
            "ton (short)/cubic yard": 1186.552842515,
            "ton (long)/cubic yard": 1328.9391836174,
            "slug/cubic foot": 515.3788183932,
            "psi/1000 feet": 2.3066587258,
            "Earth's density (mean)": 5517.9999999999
        ]
        
        guard let fromValue = kilogramPerCubicMeterValues[fromUnit], let toValue = kilogramPerCubicMeterValues[toUnit] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let kilogramPerCubicMeter = value * fromValue
        return kilogramPerCubicMeter / toValue
    }
    
    private func convertSpecificVolume(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let cubicMeterPerKilogramValues: [String: Double] = [
            "cubic meter/kilogram": 1,
            "cubic centimeter/gram": 0.001,
            "liter/kilogram": 0.001,
            "liter/gram": 1,
            "cubic foot/kilogram": 0.0283168466,
            "cubic foot/pound": 0.06242796,
            "gallon (US)/pound": 0.0083454039,
            "gallon (UK)/pound": 0.0100224128
        ]
        
        guard let fromValue = cubicMeterPerKilogramValues[fromUnit], let toValue = cubicMeterPerKilogramValues[toUnit] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let cubicMeterPerKilogram = value * fromValue
        return cubicMeterPerKilogram / toValue
    }
    
    private func convertMomentOfInertia(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let kilogramSquareMeterValues: [String: Double] = [
            "kilogram square meter": 1,
            "kilogram square centimeter": 0.0001,
            "kilogram square millimeter": 1e-6,
            "gram square centimeter": 1e-7,
            "gram square millimeter": 1e-9,
            "kilogram-force meter square second": 9.8066499998,
            "kilogram-force centimeter square second": 0.0980665,
            "ounce square inch": 1.829e-5,
            "ounce-force inch sq. second": 0.0070615519,
            "pound square foot": 0.0421401101,
            "pound-force foot sq. second": 1.3558179619,
            "pound square inch": 0.0002926397,
            "pound-force inch sq. second": 0.1129848302,
            "slug square foot": 1.3558179619
        ]
        
        guard let fromValue = kilogramSquareMeterValues[fromUnit], let toValue = kilogramSquareMeterValues[toUnit] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let kilogramSquareMeter = value * fromValue
        return kilogramSquareMeter / toValue
    }
    
    private func convertMomentOfForce(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let newtonMeterValues: [String: Double] = [
            "newton meter": 1,
            "kilonewton meter": 1000,
            "millinewton meter": 0.001,
            "micronewton meter": 1e-6,
            "ton-force (short) meter": 8896.4400000035,
            "ton-force (long) meter": 9964.0200000047,
            "ton-force (metric) meter": 9806.6499999993,
            "kilogram-force meter": 9.80665,
            "gram-force centimeter": 9.80665e-5,
            "pound-force foot": 1.35582,
            "poundal foot": 0.0421401,
            "poundal inch": 0.003511675
        ]
        
        guard let fromValue = newtonMeterValues[fromUnit], let toValue = newtonMeterValues[toUnit] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let newtonMeter = value * fromValue
        return newtonMeter / toValue
    }
    
    private func convertTorque(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        let newtonMeterValues: [String: Double] = [
            "newton meter": 1,
            "newton centimeter": 0.01,
            "newton millimeter": 0.001,
            "kilonewton meter": 1000,
            "dyne meter": 1e-5,
            "dyne centimeter": 1e-7,
            "dyne millimeter": 1e-8,
            "kilogram-force meter": 9.80665,
            "kilogram-force centimeter": 0.0980665,
            "kilogram-force millimeter": 0.00980665,
            "gram-force meter": 0.00980665,
            "gram-force centimeter": 9.80665e-5,
            "gram-force millimeter": 9.80665e-6,
            "ounce-force foot": 0.084738624,
            "ounce-force inch": 0.007061552,
            "pound-force foot": 1.355818,
            "pound-force inch": 0.1129848333,
            // Önceki birimler
            "millinewton meter": 0.001,
            "micronewton meter": 1e-6,
            "ton-force (short) meter": 8896.4400000035,
            "ton-force (long) meter": 9964.0200000047,
            "ton-force (metric) meter": 9806.6499999993,
            "poundal foot": 0.0421401,
            "poundal inch": 0.003511675
        ]
        
        guard let fromValue = newtonMeterValues[fromUnit], let toValue = newtonMeterValues[toUnit] else {
            return value // Eğer birim bulunamazsa, orijinal değeri döndür
        }
        
        let newtonMeter = value * fromValue
        return newtonMeter / toValue
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
        case .energy:
            return "bolt"
        case .power:
            return "power" // TODO: daha iyisini bul
        case .force:
            return "arrow.left.arrow.right" // TODO: daha iyisini bul
        case .fuelConsumption:
            return "fuelpump"
        case .volumeDry:
            return "speaker.wave.2"
        case .velocityAngular:
            return "arrow.clockwise"
        case .acceleration:
            return "gauge.open.with.lines.needle.84percent.exclamation" // TODO: daha iyisini bul
        case .accelerationAngular:
            return "digitalcrown.arrow.clockwise" // TODO: daha iyisini bul
        case .density:
            return "circle.dotted.and.circle" // TODO: daha iyisini bul
        case .specificVolume:
            return "cube"
        case .momentOfInertia:
            return "arrow.right.arrow.left" // TODO: daha iyisini bul
        case .momentOfForce:
            return "circle" // TODO: daha iyisini bul
        case .torque:
            return "gearshape" // TODO: daha iyisini bul
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
        case .energy:
            return """
                Energy is a fundamental physical quantity representing the ability to perform work or cause change. It exists in various forms, such as kinetic, potential, thermal, and chemical.
                
                The SI unit for energy is the joule (J), which is defined as the amount of work done when a force of one newton displaces an object by one meter.
                
                Other units include calories (cal) and kilowatt-hours (kWh). For example, one kilowatt-hour equals 3.6 million joules.
                
                Energy is a central concept in physics, chemistry, and engineering, essential for understanding processes like heat transfer, mechanical work, and power generation.
                
                Accurate energy measurement is vital for optimizing efficiency and managing resources in both everyday applications and advanced technologies.
                """
        case .power:
            return """
                Power measures the rate at which work is done or energy is transferred over time. It quantifies how quickly energy is used or produced and is a key concept in both physics and engineering.
                
                The SI unit for power is the watt (W), defined as one joule per second (J/s). For instance, a 100-watt light bulb consumes 100 joules of energy every second it is operating.
                
                Other units of power include horsepower (hp), where one horsepower is approximately 745.7 watts. Power is crucial in various applications, from electrical systems and mechanical engines to energy management and renewable resources.
                
                Understanding power helps in designing efficient systems and optimizing performance in both industrial and everyday contexts.
                """
        case .force:
            return """
                Force is an interaction that changes the motion of an object or causes it to accelerate. It is a vector quantity, meaning it has both magnitude and direction.
                
                The SI unit for force is the newton (N), which is defined as the amount of force required to accelerate a one-kilogram mass by one meter per second squared.
                
                For example, one newton is the force needed to lift a small apple against Earth's gravity. Force is a fundamental concept in mechanics and physics, essential for understanding phenomena such as gravity, friction, and tension.
                
                Accurate measurement of force is crucial for designing structures, machinery, and various systems where precise control and stability are required.
                """
        case .fuelConsumption:
            return """
                Fuel consumption measures the amount of fuel used by a vehicle or machine over a specific distance or period. It is an important metric for assessing efficiency and environmental impact.
                
                The SI unit for fuel consumption is liters per 100 kilometers (L/100 km), indicating how many liters of fuel are needed to travel 100 kilometers.
                
                Another common unit is miles per gallon (mpg), used primarily in the United States, where a higher mpg value signifies better fuel efficiency.
                
                Fuel consumption is crucial for evaluating the performance of engines, optimizing operational costs, and reducing emissions.
                
                Accurate measurement and management of fuel consumption are essential for both economic and environmental reasons.
                """
        case .volumeDry:
            return """
                Dry volume measures the amount of space occupied by a solid substance or dry material, typically in agricultural, culinary, and scientific contexts.
                
                Unlike liquid volume, which deals with fluids, dry volume quantifies the space taken up by non-liquid substances.
                
                Common units for dry volume include cubic meters (m³), liters (L), and bushels. For example, a bushel is often used in agriculture to measure grains and fruits, where one bushel is equivalent to about 35.24 liters.
                
                Accurate measurement of dry volume is crucial for tasks such as portion control in cooking, inventory management, and agricultural yield estimation.
                
                Understanding dry volume helps in efficient material handling and precise measurement in various fields.
                """
        case .velocityAngular:
            return """
                Angular velocity measures the rate at which an object rotates around an axis. It quantifies how quickly an angle changes with respect to time and is a key concept in rotational motion.
                
                The SI unit for angular velocity is radians per second (rad/s). One radian represents the angle subtended when the arc length of a circle equals the radius.
                
                For example, an angular velocity of 2 rad/s means the angle of rotation increases by 2 radians every second. Angular velocity is essential in fields such as physics, engineering, and astronomy for analyzing rotational dynamics, machinery performance, and celestial movements.
                
                Accurate measurement of angular velocity is crucial for designing rotating systems and understanding rotational behavior.
                """
        case .acceleration:
            return """
                Acceleration measures the rate at which an object's velocity changes over time. It is a fundamental concept in mechanics and physics, describing how quickly an object speeds up or slows down.
                
                The SI unit for acceleration is meters per second squared (m/s²), indicating the change in velocity (in meters per second) that occurs each second.
                
                For example, an acceleration of 9.8 m/s² represents the acceleration due to Earth's gravity, causing objects to speed up by 9.8 meters per second each second when falling freely.
                
                Acceleration is crucial for understanding motion dynamics, designing vehicles, and analyzing forces in various applications.
                
                Accurate measurement of acceleration helps in predicting and controlling the movement of objects and systems.
                """
        case .accelerationAngular:
            return """
                Angular acceleration measures the rate at which an object's angular velocity changes over time. It describes how quickly an object speeds up or slows down its rotation around an axis.
                
                The SI unit for angular acceleration is radians per second squared (rad/s²), which represents the change in angular velocity (in radians per second) that occurs each second.
                
                For example, if an object's angular velocity increases by 2 rad/s every second, its angular acceleration is 2 rad/s².
                
                Angular acceleration is crucial in rotational dynamics, affecting the performance of rotating machinery, the motion of celestial bodies, and the behavior of various mechanical systems.
                
                Accurate measurement of angular acceleration helps in designing and analyzing rotational systems and understanding rotational motion.
                """
        case .density:
            return """
                Density is a measure of how much mass is contained in a given volume. It is an important property in physics and engineering that helps in understanding the distribution of mass within a substance.
                
                The SI unit for density is kilograms per cubic meter (kg/m³).
                
                For example, the density of water is approximately 1,000 kg/m³, meaning one cubic meter of water has a mass of 1,000 kilograms.
                
                Density can also be expressed in other units, such as grams per cubic centimeter (g/cm³), where 1 g/cm³ equals 1,000 kg/m³.
                
                Density is used to identify materials, determine buoyancy, and analyze the behavior of substances under various conditions.
                
                Accurate density measurement is crucial for material science, fluid dynamics, and engineering applications.
                """
        case .specificVolume:
            return """
                Specific volume is a property that measures the volume occupied by a unit mass of a substance. It is the reciprocal of density and provides insights into the space a given mass occupies.
                
                The SI unit for specific volume is cubic meters per kilogram (m³/kg).
                
                For example, if a substance has a density of 2 kg/m³, its specific volume would be 0.5 m³/kg, meaning one kilogram of the substance occupies 0.5 cubic meters.
                
                Specific volume is crucial in thermodynamics and fluid mechanics for analyzing the behavior of gases and liquids, especially in processes involving changes in pressure and temperature.
                
                Accurate measurement of specific volume helps in designing systems like compressors, engines, and various other equipment where precise volume and mass relationships are important.
                """
        case .momentOfInertia:
            return """
                Moment of inertia, also known as the rotational inertia, measures an object's resistance to changes in its rotational motion about an axis. It depends on the mass distribution relative to the axis of rotation.
                
                The SI unit for moment of inertia is kilogram square meters (kg·m²).
                
                For example, a solid cylinder rotating about its central axis has a different moment of inertia compared to a hollow cylinder with the same mass and radius.
                
                The moment of inertia is crucial in rotational dynamics and is used to calculate angular acceleration, torque, and kinetic energy in rotating systems.
                
                Accurate determination of moment of inertia is essential for designing and analyzing mechanical systems, including wheels, gears, and flywheels, where rotational motion plays a significant role.
                """
        case .momentOfForce:
            return """
                The moment of force, also known as torque, measures the rotational effect produced by a force applied at a distance from a pivot point or axis. It quantifies how much a force tends to rotate an object around an axis.
                
                The SI unit for moment of force is the newton meter (N·m).
                
                For example, applying a force of 10 newtons at a distance of 2 meters from the pivot generates a moment of force of 20 N·m. The moment of force is crucial in mechanics for analyzing rotational motion, balancing forces, and designing mechanical systems such as engines and levers.
                
                Accurate calculation of torque helps ensure the proper functioning and stability of structures and machinery under rotational loads.
                """
        case .torque:
            return """
                Torque, also known as the moment of force, measures the tendency of a force to rotate an object around an axis or pivot point. It is a crucial concept in rotational dynamics and engineering.
                
                The SI unit for torque is the newton meter (N·m), representing the force applied at a perpendicular distance from the axis of rotation.
                
                For example, tightening a bolt with a wrench involves applying a force at a certain distance from the bolt, generating torque that secures the bolt in place.
                
                Torque is essential for understanding mechanical systems, including engines, gears, and various machinery.
                
                Accurate torque measurement ensures proper operation and efficiency of rotating equipment and helps in balancing and controlling rotational forces.
                """
        }
    }
    
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .length:
            return [
                ("m", "meter"),
                ("km", "kilometer"),
                ("dm", "decimeter"),
                ("cm", "centimeter"),
                ("mm", "millimeter"),
                ("µm", "micrometer"),
                ("nm", "nanometer"),
                ("mi", "mile"),
                ("yd", "yard"),
                ("ft", "foot"),
                ("in", "inch"),
                ("ly", "light year"),
                ("Em", "exameter"),
                ("Pm", "petameter"),
                ("Tm", "terameter"),
                ("Gm", "gigameter"),
                ("Mm", "megameter"),
                ("hm", "hectometer"),
                ("dam", "dekameter"),
                ("µ", "micron"),
                ("pm", "picometer"),
                ("fm", "femtometer"),
                ("am", "attometer"),
                ("Mpc", "megaparsec"),
                ("kpc", "kiloparsec"),
                ("pc", "parsec"),
                ("au", "astronomical unit"),
                ("lea", "league"),
                ("nlea(UK)", "nautical league (UK)"),
                ("nlea(int)", "nautical league (int.)"),
                ("lea(st)", "league (statute)"),
                ("nmi(UK)", "nautical mile (UK)"),
                ("nmi(int)", "nautical mile (international)"),
                ("mi(st)", "mile (statute)"),
                ("mi(US)", "mile (US survey)"),
                ("mi(Rom)", "mile (Roman)"),
                ("kyd", "kiloyard"),
                ("fur", "furlong"),
                ("fur(US)", "furlong (US survey)"),
                ("ch", "chain"),
                ("ch(US)", "chain (US survey)"),
                ("rope", "rope"),
                ("rod", "rod"),
                ("rod(US)", "rod (US survey)"),
                ("per", "perch"),
                ("pole", "pole"),
                ("fth", "fathom"),
                ("fth(US)", "fathom (US survey)"),
                ("ell", "ell"),
                ("ft(US)", "foot (US survey)"),
                ("link", "link"),
                ("link(US)", "link (US survey)"),
                ("cubit(UK)", "cubit (UK)"),
                ("hand", "hand"),
                ("span", "span (cloth)"),
                ("finger", "finger (cloth)"),
                ("nail", "nail (cloth)"),
                ("in(US)", "inch (US survey)"),
                ("barleycorn", "barleycorn"),
                ("mil", "mil"),
                ("µin", "microinch"),
                ("Å", "angstrom"),
                ("au(l)", "a.u. of length"),
                ("X", "X-unit"),
                ("F", "fermi"),
                ("arpent", "arpent"),
                ("pica", "pica"),
                ("point", "point"),
                ("twip", "twip"),
                ("aln", "aln"),
                ("famn", "famn"),
                ("cal", "caliber"),
                ("cin", "centiinch"),
                ("ken", "ken"),
                ("archin", "Russian archin"),
                ("actus", "Roman actus"),
                ("vara(t)", "vara de tarea"),
                ("vara(c)", "vara conuquera"),
                ("vara(cas)", "vara castellana"),
                ("cubit(Gr)", "cubit (Greek)"),
                ("lreed", "long reed"),
                ("reed", "reed"),
                ("lcubit", "long cubit"),
                ("hb", "handbreadth"),
                ("fb", "fingerbreadth"),
                ("lP", "Planck length"),
                ("re", "Electron radius (classical)"),
                ("a0", "Bohr radius"),
                ("REq", "Earth's equatorial radius"),
                ("RPol", "Earth's polar radius"),
                ("AU", "Earth's distance from sun"),
                ("RS", "Sun's radius")
            ]
        case .mass:
            return [
                ("kg", "kilogram"),
                ("g", "gram"),
                ("mg", "milligram"),
                ("t", "ton (metric)"),
                ("lb", "pound"),
                ("oz", "ounce"),
                ("ct", "carat"),
                ("ton(sh)", "ton (short)"),
                ("ton(l)", "ton (long)"),
                ("u", "Atomic mass unit"),
                ("Eg", "exagram"),
                ("Pg", "petagram"),
                ("Tg", "teragram"),
                ("Gg", "gigagram"),
                ("Mg", "megagram"),
                ("hg", "hectogram"),
                ("dag", "dekagram"),
                ("dg", "decigram"),
                ("cg", "centigram"),
                ("µg", "microgram"),
                ("ng", "nanogram"),
                ("pg", "picogram"),
                ("fg", "femtogram"),
                ("ag", "attogram"),
                ("Da", "dalton"),
                ("kgf·s²/m", "kilogram-force square second/meter"),
                ("klb", "kilopound"),
                ("kip", "kip"),
                ("slug", "slug"),
                ("lbf·s²/ft", "pound-force square second/foot"),
                ("lb(t)", "pound (troy or apothecary)"),
                ("pdl", "poundal"),
                ("ton(a,US)", "ton (assay) (US)"),
                ("ton(a,UK)", "ton (assay) (UK)"),
                ("kt", "kiloton (metric)"),
                ("q", "quintal (metric)"),
                ("cwt(US)", "hundredweight (US)"),
                ("cwt(UK)", "hundredweight (UK)"),
                ("qr(US)", "quarter (US)"),
                ("qr(UK)", "quarter (UK)"),
                ("stone(US)", "stone (US)"),
                ("stone(UK)", "stone (UK)"),
                ("t", "tonne"),
                ("dwt", "pennyweight"),
                ("s(ap)", "scruple (apothecary)"),
                ("gr", "grain"),
                ("γ", "gamma"),
                ("talent(BH)", "talent (Biblical Hebrew)"),
                ("mina(BH)", "mina (Biblical Hebrew)"),
                ("shekel(BH)", "shekel (Biblical Hebrew)"),
                ("bekan(BH)", "bekan (Biblical Hebrew)"),
                ("gerah(BH)", "gerah (Biblical Hebrew)"),
                ("talent(BG)", "talent (Biblical Greek)"),
                ("mina(BG)", "mina (Biblical Greek)"),
                ("tetradrachma(BG)", "tetradrachma (Biblical Greek)"),
                ("didrachma(BG)", "didrachma (Biblical Greek)"),
                ("drachma(BG)", "drachma (Biblical Greek)"),
                ("denarius(BR)", "denarius (Biblical Roman)"),
                ("assarion(BR)", "assarion (Biblical Roman)"),
                ("quadrans(BR)", "quadrans (Biblical Roman)"),
                ("lepton(BR)", "lepton (Biblical Roman)"),
                ("mP", "Planck mass"),
                ("me", "Electron mass (rest)"),
                ("mµ", "Muon mass"),
                ("mp", "Proton mass"),
                ("mn", "Neutron mass"),
                ("md", "Deuteron mass"),
                ("ME", "Earth's mass"),
                ("MS", "Sun's mass")
            ]
        case .volume:
            return [
                ("m³", "cubic meter"),
                ("km³", "cubic kilometer"),
                ("cm³", "cubic centimeter"),
                ("mm³", "cubic millimeter"),
                ("L", "liter"),
                ("mL", "milliliter"),
                ("gal(US)", "gallon (US)"),
                ("qt(US)", "quart (US)"),
                ("pt(US)", "pint (US)"),
                ("cup(US)", "cup (US)"),
                ("tbsp(US)", "tablespoon (US)"),
                ("tsp(US)", "teaspoon (US)"),
                ("mi³", "cubic mile"),
                ("yd³", "cubic yard"),
                ("ft³", "cubic foot"),
                ("in³", "cubic inch"),
                ("dm³", "cubic decimeter"),
                ("EL", "exaliter"),
                ("PL", "petaliter"),
                ("TL", "teraliter"),
                ("GL", "gigaliter"),
                ("ML", "megaliter"),
                ("kL", "kiloliter"),
                ("hL", "hectoliter"),
                ("daL", "dekaliter"),
                ("dL", "deciliter"),
                ("cL", "centiliter"),
                ("µL", "microliter"),
                ("nL", "nanoliter"),
                ("pL", "picoliter"),
                ("fL", "femtoliter"),
                ("aL", "attoliter"),
                ("cc", "cc"),
                ("drop", "drop"),
                ("bbl(oil)", "barrel (oil)"),
                ("bbl(US)", "barrel (US)"),
                ("bbl(UK)", "barrel (UK)"),
                ("gal(UK)", "gallon (UK)"),
                ("qt(UK)", "quart (UK)"),
                ("pt(UK)", "pint (UK)"),
                ("cup(m)", "cup (metric)"),
                ("cup(UK)", "cup (UK)"),
                ("fl oz(US)", "fluid ounce (US)"),
                ("fl oz(UK)", "fluid ounce (UK)"),
                ("tbsp(m)", "tablespoon (metric)"),
                ("tbsp(UK)", "tablespoon (UK)"),
                ("dsp(US)", "dessertspoon (US)"),
                ("dsp(UK)", "dessertspoon (UK)"),
                ("tsp(m)", "teaspoon (metric)"),
                ("tsp(UK)", "teaspoon (UK)"),
                ("gill(US)", "gill (US)"),
                ("gill(UK)", "gill (UK)"),
                ("min(US)", "minim (US)"),
                ("min(UK)", "minim (UK)"),
                ("reg ton", "ton register"),
                ("ccf", "ccf"),
                ("hcf", "hundred-cubic foot"),
                ("ac·ft", "acre-foot"),
                ("ac·ft(US)", "acre-foot (US survey)"),
                ("ac·in", "acre-inch"),
                ("das", "dekastere"),
                ("s", "stere"),
                ("ds", "decistere"),
                ("cord", "cord"),
                ("tun", "tun"),
                ("hhd", "hogshead"),
                ("bf", "board foot"),
                ("dr", "dram"),
                ("cor(B)", "cor (Biblical)"),
                ("homer(B)", "homer (Biblical)"),
                ("bath(B)", "bath (Biblical)"),
                ("hin(B)", "hin (Biblical)"),
                ("cab(B)", "cab (Biblical)"),
                ("log(B)", "log (Biblical)"),
                ("taza", "Taza (Spanish)"),
                ("VE", "Earth's volume")
            ]
        case .temperature:
            return [
                ("K", "Kelvin"),
                ("°C", "Celsius"),
                ("°F", "Fahrenheit"),
                ("°R", "Rankine"),
                ("°Ré", "Reaumur"),
                ("Tw", "Triple point of water")
            ]
        case .area:
            return [
                ("m²", "square meter"),
                ("km²", "square kilometer"),
                ("cm²", "square centimeter"),
                ("mm²", "square millimeter"),
                ("µm²", "square micrometer"),
                ("ha", "hectare"),
                ("ac", "acre"),
                ("mi²", "square mile"),
                ("yd²", "square yard"),
                ("ft²", "square foot"),
                ("in²", "square inch"),
                ("hm²", "square hectometer"),
                ("dam²", "square dekameter"),
                ("dm²", "square decimeter"),
                ("nm²", "square nanometer"),
                ("a", "are"),
                ("b", "barn"),
                ("mi²(US)", "square mile (US survey)"),
                ("ft²(US)", "square foot (US survey)"),
                ("cir in", "circular inch"),
                ("twp", "township"),
                ("sec", "section"),
                ("ac(US)", "acre (US survey)"),
                ("rood", "rood"),
                ("ch²", "square chain"),
                ("rod²", "square rod"),
                ("rod²(US)", "square rod (US survey)"),
                ("per²", "square perch"),
                ("pole²", "square pole"),
                ("mil²", "square mil"),
                ("cir mil", "circular mil"),
                ("homestead", "homestead"),
                ("sabin", "sabin"),
                ("arpent", "arpent"),
                ("cuerda", "cuerda"),
                ("plaza", "plaza"),
                ("var²(cas)", "varas castellanas cuad"),
                ("var²(con)", "varas conuqueras cuad"),
                ("σe", "Electron cross section")
            ]
        case .pressure:
            return [
                ("Pa", "pascal"),
                ("kPa", "kilopascal"),
                ("bar", "bar"),
                ("psi", "psi"),
                ("ksi", "ksi"),
                ("atm", "Standard atmosphere"),
                ("EPa", "exapascal"),
                ("PPa", "petapascal"),
                ("TPa", "terapascal"),
                ("GPa", "gigapascal"),
                ("MPa", "megapascal"),
                ("hPa", "hectopascal"),
                ("daPa", "dekapascal"),
                ("dPa", "decipascal"),
                ("cPa", "centipascal"),
                ("mPa", "millipascal"),
                ("µPa", "micropascal"),
                ("nPa", "nanopascal"),
                ("pPa", "picopascal"),
                ("fPa", "femtopascal"),
                ("aPa", "attopascal"),
                ("N/m²", "newton/square meter"),
                ("N/cm²", "newton/square centimeter"),
                ("N/mm²", "newton/square millimeter"),
                ("kN/m²", "kilonewton/square meter"),
                ("mbar", "millibar"),
                ("µbar", "microbar"),
                ("dyn/cm²", "dyne/square centimeter"),
                ("kgf/m²", "kilogram-force/square meter"),
                ("kgf/cm²", "kilogram-force/sq. cm"),
                ("kgf/mm²", "kilogram-force/sq. millimeter"),
                ("gf/cm²", "gram-force/sq. centimeter"),
                ("tonf(sh)/ft²", "ton-force (short)/sq. foot"),
                ("tonf(sh)/in²", "ton-force (short)/sq. inch"),
                ("tonf(l)/ft²", "ton-force (long)/square foot"),
                ("tonf(l)/in²", "ton-force (long)/square inch"),
                ("kipf/in²", "kip-force/square inch"),
                ("lbf/ft²", "pound-force/square foot"),
                ("lbf/in²", "pound-force/square inch"),
                ("pdl/ft²", "poundal/square foot"),
                ("Torr", "torr"),
                ("cmHg", "centimeter mercury (0°C)"),
                ("mmHg", "millimeter mercury (0°C)"),
                ("inHg", "inch mercury (32°F)"),
                ("inHg(60°F)", "inch mercury (60°F)"),
                ("cmH2O", "centimeter water (4°C)"),
                ("mmH2O", "millimeter water (4°C)"),
                ("inH2O", "inch water (4°C)"),
                ("ftH2O", "foot water (4°C)"),
                ("inH2O(60°F)", "inch water (60°F)"),
                ("ftH2O(60°F)", "foot water (60°F)"),
                ("at", "atmosphere technical")
            ]
        case .energy:
            return [
                ("J", "joule"),
                ("kJ", "kilojoule"),
                ("kWh", "kilowatt-hour"),
                ("Wh", "watt-hour"),
                ("Cal", "calorie (nutritional)"),
                ("hp·h", "horsepower (metric) hour"),
                ("Btu(IT)", "Btu (IT)"),
                ("Btu(th)", "Btu (th)"),
                ("GJ", "gigajoule"),
                ("MJ", "megajoule"),
                ("mJ", "millijoule"),
                ("µJ", "microjoule"),
                ("nJ", "nanojoule"),
                ("aJ", "attojoule"),
                ("MeV", "megaelectron-volt"),
                ("keV", "kiloelectron-volt"),
                ("eV", "electron-volt"),
                ("erg", "erg"),
                ("GWh", "gigawatt-hour"),
                ("MWh", "megawatt-hour"),
                ("kW·s", "kilowatt-second"),
                ("W·s", "watt-second"),
                ("N·m", "newton meter"),
                ("hp·h", "horsepower hour"),
                ("kcal(IT)", "kilocalorie (IT)"),
                ("kcal(th)", "kilocalorie (th)"),
                ("cal(IT)", "calorie (IT)"),
                ("cal(th)", "calorie (th)"),
                ("MBtu(IT)", "mega Btu (IT)"),
                ("ton·h", "ton-hour (refrigeration)"),
                ("FOE(kL)", "fuel oil equivalent @kiloliter"),
                ("FOE(bbl)", "fuel oil equivalent @barrel (US)"),
                ("Gt", "gigaton"),
                ("Mt", "megaton"),
                ("kt", "kiloton"),
                ("t(TNT)", "ton (explosives)"),
                ("dyn·cm", "dyne centimeter"),
                ("gf·m", "gram-force meter"),
                ("gf·cm", "gram-force centimeter"),
                ("kgf·cm", "kilogram-force centimeter"),
                ("kgf·m", "kilogram-force meter"),
                ("kp·m", "kilopond meter"),
                ("lbf·ft", "pound-force foot"),
                ("lbf·in", "pound-force inch"),
                ("ozf·in", "ounce-force inch"),
                ("ft·lb", "foot-pound"),
                ("in·lb", "inch-pound"),
                ("in·oz", "inch-ounce"),
                ("pdl·ft", "poundal foot"),
                ("th", "therm"),
                ("th(EC)", "therm (EC)"),
                ("th(US)", "therm (US)"),
                ("Eh", "Hartree energy"),
                ("Ry", "Rydberg constant")
            ]
        case .power:
            return [
                ("W", "watt"),
                ("EW", "exawatt"),
                ("PW", "petawatt"),
                ("TW", "terawatt"),
                ("GW", "gigawatt"),
                ("MW", "megawatt"),
                ("kW", "kilowatt"),
                ("hW", "hectowatt"),
                ("daW", "dekawatt"),
                ("dW", "deciwatt"),
                ("cW", "centiwatt"),
                ("mW", "milliwatt"),
                ("µW", "microwatt"),
                ("nW", "nanowatt"),
                ("pW", "picowatt"),
                ("fW", "femtowatt"),
                ("aW", "attowatt"),
                ("hp", "horsepower"),
                ("hp(550)", "horsepower (550 ft*lbf/s)"),
                ("hp(m)", "horsepower (metric)"),
                ("hp(b)", "horsepower (boiler)"),
                ("hp(e)", "horsepower (electric)"),
                ("hp(w)", "horsepower (water)"),
                ("PS", "pferdestarke (ps)"),
                ("Btu(IT)/h", "Btu (IT)/hour"),
                ("Btu(IT)/min", "Btu (IT)/minute"),
                ("Btu(IT)/s", "Btu (IT)/second"),
                ("Btu(th)/h", "Btu (th)/hour"),
                ("Btu(th)/min", "Btu (th)/minute"),
                ("Btu(th)/s", "Btu (th)/second"),
                ("MBtu(IT)/h", "MBtu (IT)/hour"),
                ("MBH", "MBH"),
                ("ton(ref)", "ton (refrigeration)"),
                ("kcal(IT)/h", "kilocalorie (IT)/hour"),
                ("kcal(IT)/min", "kilocalorie (IT)/minute"),
                ("kcal(IT)/s", "kilocalorie (IT)/second"),
                ("kcal(th)/h", "kilocalorie (th)/hour"),
                ("kcal(th)/min", "kilocalorie (th)/minute"),
                ("kcal(th)/s", "kilocalorie (th)/second"),
                ("cal(IT)/h", "calorie (IT)/hour"),
                ("cal(IT)/min", "calorie (IT)/minute"),
                ("cal(IT)/s", "calorie (IT)/second"),
                ("cal(th)/h", "calorie (th)/hour"),
                ("cal(th)/min", "calorie (th)/minute"),
                ("cal(th)/s", "calorie (th)/second"),
                ("ft·lbf/h", "foot pound-force/hour"),
                ("ft·lbf/min", "foot pound-force/minute"),
                ("ft·lbf/s", "foot pound-force/second"),
                ("lb·ft/h", "pound-foot/hour"),
                ("lb·ft/min", "pound-foot/minute"),
                ("lb·ft/s", "pound-foot/second"),
                ("erg/s", "erg/second"),
                ("kVA", "kilovolt ampere"),
                ("VA", "volt ampere"),
                ("N·m/s", "newton meter/second"),
                ("J/s", "joule/second"),
                ("EJ/s", "exajoule/second"),
                ("PJ/s", "petajoule/second"),
                ("TJ/s", "terajoule/second"),
                ("GJ/s", "gigajoule/second"),
                ("MJ/s", "megajoule/second"),
                ("kJ/s", "kilojoule/second"),
                ("hJ/s", "hectojoule/second"),
                ("daJ/s", "dekajoule/second"),
                ("dJ/s", "decijoule/second"),
                ("cJ/s", "centijoule/second"),
                ("mJ/s", "millijoule/second"),
                ("µJ/s", "microjoule/second"),
                ("nJ/s", "nanojoule/second"),
                ("pJ/s", "picojoule/second"),
                ("fJ/s", "femtojoule/second"),
                ("aJ/s", "attojoule/second"),
                ("J/h", "joule/hour"),
                ("J/min", "joule/minute"),
                ("kJ/h", "kilojoule/hour"),
                ("kJ/min", "kilojoule/minute")
            ]
        case .force:
            return [
                ("N", "newton"),
                ("kN", "kilonewton"),
                ("gf", "gram-force"),
                ("kgf", "kilogram-force"),
                ("tf", "ton-force (metric)"),
                ("EN", "exanewton"),
                ("PN", "petanewton"),
                ("TN", "teranewton"),
                ("GN", "giganewton"),
                ("MN", "meganewton"),
                ("hN", "hectonewton"),
                ("daN", "dekanewton"),
                ("dN", "decinewton"),
                ("cN", "centinewton"),
                ("mN", "millinewton"),
                ("µN", "micronewton"),
                ("nN", "nanonewton"),
                ("pN", "piconewton"),
                ("fN", "femtonewton"),
                ("aN", "attonewton"),
                ("dyn", "dyne"),
                ("J/m", "joule/meter"),
                ("J/cm", "joule/centimeter"),
                ("tf(sh)", "ton-force (short)"),
                ("tf(l)", "ton-force (long)"),
                ("kipf", "kip-force"),
                ("klbf", "kilopound-force"),
                ("lbf", "pound-force"),
                ("ozf", "ounce-force"),
                ("pdl", "poundal"),
                ("lb·ft/s²", "pound foot/square second"),
                ("p", "pond"),
                ("kp", "kilopond")
            ]
        case .duration:
            return [
                ("s", "second"),
                ("ms", "millisecond"),
                ("min", "minute"),
                ("h", "hour"),
                ("d", "day"),
                ("wk", "week"),
                ("mo", "month"),
                ("yr", "year"),
                ("dec", "decade"),
                ("c", "century"),
                ("mill", "millennium"),
                ("µs", "microsecond"),
                ("ns", "nanosecond"),
                ("ps", "picosecond"),
                ("fs", "femtosecond"),
                ("as", "attosecond"),
                ("shake", "shake"),
                ("mo(syn)", "month (synodic)"),
                ("yr(J)", "year (Julian)"),
                ("yr(leap)", "year (leap)"),
                ("yr(t)", "year (tropical)"),
                ("yr(s)", "year (sidereal)"),
                ("d(s)", "day (sidereal)"),
                ("h(s)", "hour (sidereal)"),
                ("min(s)", "minute (sidereal)"),
                ("s(s)", "second (sidereal)"),
                ("fn", "fortnight"),
                ("septennial", "septennial"),
                ("octennial", "octennial"),
                ("novennial", "novennial"),
                ("quindecennial", "quindecennial"),
                ("quinquennial", "quinquennial"),
                ("tP", "Planck time")
            ]
        case .speed:
            return [
                ("m/s", "meter/second"),
                ("km/h", "kilometer/hour"),
                ("mi/h", "mile/hour"),
                ("m/h", "meter/hour"),
                ("m/min", "meter/minute"),
                ("km/min", "kilometer/minute"),
                ("km/s", "kilometer/second"),
                ("cm/h", "centimeter/hour"),
                ("cm/min", "centimeter/minute"),
                ("cm/s", "centimeter/second"),
                ("mm/h", "millimeter/hour"),
                ("mm/min", "millimeter/minute"),
                ("mm/s", "millimeter/second"),
                ("ft/h", "foot/hour"),
                ("ft/min", "foot/minute"),
                ("ft/s", "foot/second"),
                ("yd/h", "yard/hour"),
                ("yd/min", "yard/minute"),
                ("yd/s", "yard/second"),
                ("mi/min", "mile/minute"),
                ("mi/s", "mile/second"),
                ("kn", "knot"),
                ("kn(UK)", "knot (UK)"),
                ("c", "Velocity of light in vacuum"),
                ("v1", "Cosmic velocity - first"),
                ("v2", "Cosmic velocity - second"),
                ("v3", "Cosmic velocity - third"),
                ("vE", "Earth's velocity"),
                ("vs(w)", "Velocity of sound in pure water"),
                ("vs(sw)", "Velocity of sound in sea water (20°C, 10 meter deep)"),
                ("M", "Mach (20°C, 1 atm)"),
                ("M(SI)", "Mach (SI standard)")
            ]
        case .angle:
            return [
                ("°", "degree"),
                ("rad", "radian"),
                ("grad", "grad"),
                ("'", "minute"),
                ("\"", "second"),
                ("gon", "gon"),
                ("sign", "sign"),
                ("mil", "mil"),
                ("rev", "revolution"),
                ("⊙", "circle"),
                ("tr", "turn"),
                ("quad", "quadrant"),
                ("right angle", "right angle"),
                ("sextant", "sextant")
            ]
        case .fuelConsumption:
            return [
                ("m/L", "meter/liter"),
                ("Em/L", "exameter/liter"),
                ("Pm/L", "petameter/liter"),
                ("Tm/L", "terameter/liter"),
                ("Gm/L", "gigameter/liter"),
                ("Mm/L", "megameter/liter"),
                ("km/L", "kilometer/liter"),
                ("hm/L", "hectometer/liter"),
                ("dam/L", "dekameter/liter"),
                ("cm/L", "centimeter/liter"),
                ("mi(US)/L", "mile (US)/liter"),
                ("nmi/L", "nautical mile/liter"),
                ("nmi/gal(US)", "nautical mile/gallon (US)"),
                ("km/gal(US)", "kilometer/gallon (US)"),
                ("m/gal(US)", "meter/gallon (US)"),
                ("m/gal(UK)", "meter/gallon (UK)"),
                ("mi/gal(US)", "mile/gallon (US)"),
                ("mi/gal(UK)", "mile/gallon (UK)"),
                ("m/m³", "meter/cubic meter"),
                ("m/cm³", "meter/cubic centimeter"),
                ("m/yd³", "meter/cubic yard"),
                ("m/ft³", "meter/cubic foot"),
                ("m/in³", "meter/cubic inch"),
                ("m/qt(US)", "meter/quart (US)"),
                ("m/qt(UK)", "meter/quart (UK)"),
                ("m/pt(US)", "meter/pint (US)"),
                ("m/pt(UK)", "meter/pint (UK)"),
                ("m/cup(US)", "meter/cup (US)"),
                ("m/cup(UK)", "meter/cup (UK)"),
                ("m/fl oz(US)", "meter/fluid ounce (US)"),
                ("m/fl oz(UK)", "meter/fluid ounce (UK)"),
                ("L/m", "liter/meter"),
                ("L/100km", "liter/100 km"),
                ("gal(US)/mi", "gallon (US)/mile"),
                ("gal(US)/100mi", "gallon (US)/100 mi"),
                ("gal(UK)/mi", "gallon (UK)/mile"),
                ("gal(UK)/100mi", "gallon (UK)/100 mi")
            ]
        case .volumeDry:
            return [
                ("L", "liter"),
                ("bbl(d,US)", "barrel dry (US)"),
                ("pt(d,US)", "pint dry (US)"),
                ("qt(d,US)", "quart dry (US)"),
                ("pk(US)", "peck (US)"),
                ("pk(UK)", "peck (UK)"),
                ("bu(US)", "bushel (US)"),
                ("bu(UK)", "bushel (UK)"),
                ("cor(B)", "cor (Biblical)"),
                ("homer(B)", "homer (Biblical)"),
                ("ephah(B)", "ephah (Biblical)"),
                ("seah(B)", "seah (Biblical)"),
                ("omer(B)", "omer (Biblical)"),
                ("cab(B)", "cab (Biblical)"),
                ("log(B)", "log (Biblical)")
            ]
        case .velocityAngular:
            return [
                ("rad/s", "radian/second"),
                ("rad/d", "radian/day"),
                ("rad/h", "radian/hour"),
                ("rad/min", "radian/minute"),
                ("°/d", "degree/day"),
                ("°/h", "degree/hour"),
                ("°/min", "degree/minute"),
                ("°/s", "degree/second"),
                ("rev/d", "revolution/day"),
                ("rev/h", "revolution/hour"),
                ("rev/min", "revolution/minute"),
                ("rev/s", "revolution/second")
            ]
        case .acceleration:
            return [
                ("m/s²", "meter/square second"),
                ("dm/s²", "decimeter/square second"),
                ("km/s²", "kilometer/square second"),
                ("hm/s²", "hectometer/square second"),
                ("dam/s²", "dekameter/square second"),
                ("cm/s²", "centimeter/square second"),
                ("mm/s²", "millimeter/square second"),
                ("µm/s²", "micrometer/square second"),
                ("nm/s²", "nanometer/square second"),
                ("pm/s²", "picometer/square second"),
                ("fm/s²", "femtometer/square second"),
                ("am/s²", "attometer/square second"),
                ("Gal", "gal"),
                ("Gal", "galileo"),
                ("mi/s²", "mile/square second"),
                ("yd/s²", "yard/square second"),
                ("ft/s²", "foot/square second"),
                ("in/s²", "inch/square second"),
                ("g", "Acceleration of gravity")
            ]
        case .accelerationAngular:
            return [
                ("rad/s²", "radian/square second"),
                ("rad/min²", "radian/square minute"),
                ("rev/s²", "revolution/square second"),
                ("rev/min/s", "revolution/minute/second"),
                ("rev/min²", "revolution/square minute")
            ]
        case .density:
            return [
                ("kg/m³", "kilogram/cubic meter"),
                ("g/cm³", "gram/cubic centimeter"),
                ("kg/cm³", "kilogram/cubic centimeter"),
                ("g/m³", "gram/cubic meter"),
                ("g/mm³", "gram/cubic millimeter"),
                ("mg/m³", "milligram/cubic meter"),
                ("mg/cm³", "milligram/cubic centimeter"),
                ("mg/mm³", "milligram/cubic millimeter"),
                ("Eg/L", "exagram/liter"),
                ("Pg/L", "petagram/liter"),
                ("Tg/L", "teragram/liter"),
                ("Gg/L", "gigagram/liter"),
                ("Mg/L", "megagram/liter"),
                ("kg/L", "kilogram/liter"),
                ("hg/L", "hectogram/liter"),
                ("dag/L", "dekagram/liter"),
                ("g/L", "gram/liter"),
                ("dg/L", "decigram/liter"),
                ("cg/L", "centigram/liter"),
                ("mg/L", "milligram/liter"),
                ("µg/L", "microgram/liter"),
                ("ng/L", "nanogram/liter"),
                ("pg/L", "picogram/liter"),
                ("fg/L", "femtogram/liter"),
                ("ag/L", "attogram/liter"),
                ("lb/in³", "pound/cubic inch"),
                ("lb/ft³", "pound/cubic foot"),
                ("lb/yd³", "pound/cubic yard"),
                ("lb/gal(US)", "pound/gallon (US)"),
                ("lb/gal(UK)", "pound/gallon (UK)"),
                ("oz/in³", "ounce/cubic inch"),
                ("oz/ft³", "ounce/cubic foot"),
                ("oz/gal(US)", "ounce/gallon (US)"),
                ("oz/gal(UK)", "ounce/gallon (UK)"),
                ("gr/gal(US)", "grain/gallon (US)"),
                ("gr/gal(UK)", "grain/gallon (UK)"),
                ("gr/ft³", "grain/cubic foot"),
                ("ton(sh)/yd³", "ton (short)/cubic yard"),
                ("ton(l)/yd³", "ton (long)/cubic yard"),
                ("slug/ft³", "slug/cubic foot"),
                ("psi/1000ft", "psi/1000 feet"),
                ("ρE", "Earth's density (mean)")
            ]
        case .specificVolume:
            return [
                ("m³/kg", "cubic meter/kilogram"),
                ("cm³/g", "cubic centimeter/gram"),
                ("L/kg", "liter/kilogram"),
                ("L/g", "liter/gram"),
                ("ft³/kg", "cubic foot/kilogram"),
                ("ft³/lb", "cubic foot/pound"),
                ("gal(US)/lb", "gallon (US)/pound"),
                ("gal(UK)/lb", "gallon (UK)/pound")
            ]
        case .momentOfInertia:
            return [
                ("kg·m²", "kilogram square meter"),
                ("kg·cm²", "kilogram square centimeter"),
                ("kg·mm²", "kilogram square millimeter"),
                ("g·cm²", "gram square centimeter"),
                ("g·mm²", "gram square millimeter"),
                ("kgf·m·s²", "kilogram-force meter square second"),
                ("kgf·cm·s²", "kilogram-force centimeter square second"),
                ("oz·in²", "ounce square inch"),
                ("ozf·in·s²", "ounce-force inch sq. second"),
                ("lb·ft²", "pound square foot"),
                ("lbf·ft·s²", "pound-force foot sq. second"),
                ("lb·in²", "pound square inch"),
                ("lbf·in·s²", "pound-force inch sq. second"),
                ("slug·ft²", "slug square foot")
            ]
        case .momentOfForce:
            return [
                ("N·m", "newton meter"),
                ("kN·m", "kilonewton meter"),
                ("mN·m", "millinewton meter"),
                ("µN·m", "micronewton meter"),
                ("tonf(sh)·m", "ton-force (short) meter"),
                ("tonf(l)·m", "ton-force (long) meter"),
                ("tonf(m)·m", "ton-force (metric) meter"),
                ("kgf·m", "kilogram-force meter"),
                ("gf·cm", "gram-force centimeter"),
                ("lbf·ft", "pound-force foot"),
                ("pdl·ft", "poundal foot"),
                ("pdl·in", "poundal inch")
            ]
        case .torque:
            return [
                ("N·m", "newton meter"),
                ("N·cm", "newton centimeter"),
                ("N·mm", "newton millimeter"),
                ("kN·m", "kilonewton meter"),
                ("dyn·m", "dyne meter"),
                ("dyn·cm", "dyne centimeter"),
                ("dyn·mm", "dyne millimeter"),
                ("kgf·m", "kilogram-force meter"),
                ("kgf·cm", "kilogram-force centimeter"),
                ("kgf·mm", "kilogram-force millimeter"),
                ("gf·m", "gram-force meter"),
                ("gf·cm", "gram-force centimeter"),
                ("gf·mm", "gram-force millimeter"),
                ("ozf·ft", "ounce-force foot"),
                ("ozf·in", "ounce-force inch"),
                ("lbf·ft", "pound-force foot"),
                ("lbf·in", "pound-force inch"),
                ("mN·m", "millinewton meter"),
                ("µN·m", "micronewton meter"),
                ("tonf(sh)·m", "ton-force (short) meter"),
                ("tonf(l)·m", "ton-force (long) meter"),
                ("tonf(m)·m", "ton-force (metric) meter"),
                ("pdl·ft", "poundal foot"),
                ("pdl·in", "poundal inch")
            ]
        }
    }
}
