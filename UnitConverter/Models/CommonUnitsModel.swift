//
//  UnitModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import Foundation
import SwiftUI

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
    
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
    
    func convert(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
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

    private func convertLength(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let meterValues: [String: Decimal] = [
            "meter": 1,
            "kilometer": 1000,
            "decimeter": Decimal(string: "0.1")!,
            "centimeter": Decimal(string: "0.01")!,
            "millimeter": Decimal(string: "0.001")!,
            "micrometer": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nanometer": Decimal(sign: .minus, exponent: 9, significand: 1),
            "mile": Decimal(string: "1609.344")!,
            "yard": Decimal(string: "0.9144")!,
            "foot": Decimal(string: "0.3048")!,
            "inch": Decimal(string: "0.0254")!,
            "light year": Decimal(string: "9.46073047258e15")!,
            "exameter": Decimal(sign: .plus, exponent: 18, significand: 1),
            "petameter": Decimal(sign: .plus, exponent: 15, significand: 1),
            "terameter": Decimal(sign: .plus, exponent: 12, significand: 1),
            "gigameter": Decimal(sign: .plus, exponent: 9, significand: 1),
            "megameter": Decimal(sign: .plus, exponent: 6, significand: 1),
            "hectometer": 100,
            "dekameter": 10,
            "micron": Decimal(sign: .minus, exponent: 6, significand: 1),
            "picometer": Decimal(sign: .minus, exponent: 12, significand: 1),
            "femtometer": Decimal(sign: .minus, exponent: 15, significand: 1),
            "attometer": Decimal(sign: .minus, exponent: 18, significand: 1),
            "megaparsec": Decimal(string: "3.08567758128e22")!,
            "kiloparsec": Decimal(string: "3.08567758128e19")!,
            "parsec": Decimal(string: "3.08567758128e16")!,
            "astronomical unit": 149597870691,
            "league": Decimal(string: "4828.032")!,
            "nautical league (UK)": Decimal(string: "5559.552")!,
            "nautical league (int.)": 5556,
            "league (statute)": Decimal(string: "4828.0416560833")!,
            "nautical mile (UK)": Decimal(string: "1853.184")!,
            "nautical mile (international)": 1852,
            "mile (statute)": Decimal(string: "1609.3472186944")!,
            "mile (US survey)": Decimal(string: "1609.3472186944")!,
            "mile (Roman)": Decimal(string: "1479.804")!,
            "kiloyard": Decimal(string: "914.4")!,
            "furlong": Decimal(string: "201.168")!,
            "furlong (US survey)": Decimal(string: "201.1684023368")!,
            "chain": Decimal(string: "20.1168")!,
            "chain (US survey)": Decimal(string: "20.1168402337")!,
            "rope": Decimal(string: "6.096")!,
            "rod": Decimal(string: "5.0292")!,
            "rod (US survey)": Decimal(string: "5.0292100584")!,
            "perch": Decimal(string: "5.0292")!,
            "pole": Decimal(string: "5.0292")!,
            "fathom": Decimal(string: "1.8288")!,
            "fathom (US survey)": Decimal(string: "1.8288036576")!,
            "ell": Decimal(string: "1.143")!,
            "foot (US survey)": Decimal(string: "0.3048006096")!,
            "link": Decimal(string: "0.201168")!,
            "link (US survey)": Decimal(string: "0.2011684023")!,
            "cubit (UK)": Decimal(string: "0.4572")!,
            "hand": Decimal(string: "0.1016")!,
            "span (cloth)": Decimal(string: "0.2286")!,
            "finger (cloth)": Decimal(string: "0.1143")!,
            "nail (cloth)": Decimal(string: "0.05715")!,
            "inch (US survey)": Decimal(string: "0.0254000508")!,
            "barleycorn": Decimal(string: "0.0084666667")!,
            "mil": Decimal(string: "2.54e-5")!,
            "microinch": Decimal(string: "2.54e-8")!,
            "angstrom": Decimal(sign: .minus, exponent: 10, significand: 1),
            "a.u. of length": Decimal(string: "5.2917724900001e-11")!,
            "X-unit": Decimal(string: "1.00208e-13")!,
            "fermi": Decimal(sign: .minus, exponent: 15, significand: 1),
            "arpent": Decimal(string: "58.5216")!,
            "pica": Decimal(string: "0.0042333333")!,
            "point": Decimal(string: "0.0003527778")!,
            "twip": Decimal(string: "1.76389e-5")!,
            "aln": Decimal(string: "0.5937777778")!,
            "famn": Decimal(string: "1.7813333333")!,
            "caliber": Decimal(string: "0.000254")!,
            "centiinch": Decimal(string: "0.000254")!,
            "ken": Decimal(string: "2.11836")!,
            "Russian archin": Decimal(string: "0.7112")!,
            "Roman actus": Decimal(string: "35.47872")!,
            "vara de tarea": Decimal(string: "2.505456")!,
            "vara conuquera": Decimal(string: "2.505456")!,
            "vara castellana": Decimal(string: "0.835152")!,
            "cubit (Greek)": Decimal(string: "0.462788")!,
            "long reed": Decimal(string: "3.2004")!,
            "reed": Decimal(string: "2.7432")!,
            "long cubit": Decimal(string: "0.5334")!,
            "handbreadth": Decimal(string: "0.0762")!,
            "fingerbreadth": Decimal(string: "0.01905")!,
            "Planck length": Decimal(string: "1.61605e-35")!,
            "Electron radius (classical)": Decimal(string: "2.81794092e-15")!,
            "Bohr radius": Decimal(string: "5.2917724900001e-11")!,
            "Earth's equatorial radius": 6378160,
            "Earth's polar radius": Decimal(string: "6356776.9999999")!,
            "Earth's distance from sun": 149600000000,
            "Sun's radius": 696000000
        ]

        guard let fromValue = meterValues[fromUnit.lowercased()], let toValue = meterValues[toUnit.lowercased()] else {
            return value
        }

        let meters = value * fromValue
        return meters / toValue
    }
    
    private func convertMass(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kilogramValues: [String: Decimal] = [
            "kilogram": 1,
            "gram": Decimal(string: "0.001")!,
            "milligram": Decimal(sign: .minus, exponent: 6, significand: 1),
            "ton (metric)": 1000,
            "pound": Decimal(string: "0.45359237")!,
            "ounce": Decimal(string: "0.0283495231")!,
            "carat": Decimal(string: "0.0002")!,
            "ton (short)": Decimal(string: "907.18474")!,
            "ton (long)": Decimal(string: "1016.0469088")!,
            "Atomic mass unit": Decimal(string: "1.6605402e-27")!,
            "exagram": Decimal(sign: .plus, exponent: 15, significand: 1),
            "petagram": Decimal(sign: .plus, exponent: 12, significand: 1),
            "teragram": Decimal(sign: .plus, exponent: 9, significand: 1),
            "gigagram": Decimal(sign: .plus, exponent: 6, significand: 1),
            "megagram": 1000,
            "hectogram": Decimal(string: "0.1")!,
            "dekagram": Decimal(string: "0.01")!,
            "decigram": Decimal(string: "0.0001")!,
            "centigram": Decimal(sign: .minus, exponent: 5, significand: 1),
            "microgram": Decimal(sign: .minus, exponent: 9, significand: 1),
            "nanogram": Decimal(sign: .minus, exponent: 12, significand: 1),
            "picogram": Decimal(sign: .minus, exponent: 15, significand: 1),
            "femtogram": Decimal(sign: .minus, exponent: 18, significand: 1),
            "attogram": Decimal(sign: .minus, exponent: 21, significand: 1),
            "dalton": Decimal(string: "1.6605300000013e-27")!,
            "kilogram-force square second/meter": Decimal(string: "9.80665")!,
            "kilopound": Decimal(string: "453.59237")!,
            "kip": Decimal(string: "453.59237")!,
            "slug": Decimal(string: "14.5939029372")!,
            "pound-force square second/foot": Decimal(string: "14.5939029372")!,
            "pound (troy or apothecary)": Decimal(string: "0.3732417216")!,
            "poundal": Decimal(string: "0.0140867196")!,
            "ton (assay) (US)": Decimal(string: "0.02916667")!,
            "ton (assay) (UK)": Decimal(string: "0.0326666667")!,
            "kiloton (metric)": Decimal(sign: .plus, exponent: 6, significand: 1),
            "quintal (metric)": 100,
            "hundredweight (US)": Decimal(string: "45.359237")!,
            "hundredweight (UK)": Decimal(string: "50.80234544")!,
            "quarter (US)": Decimal(string: "11.33980925")!,
            "quarter (UK)": Decimal(string: "12.70058636")!,
            "stone (US)": Decimal(string: "5.669904625")!,
            "stone (UK)": Decimal(string: "6.35029318")!,
            "tonne": 1000,
            "pennyweight": Decimal(string: "0.0015551738")!,
            "scruple (apothecary)": Decimal(string: "0.0012959782")!,
            "grain": Decimal(string: "6.47989e-5")!,
            "gamma": Decimal(sign: .minus, exponent: 9, significand: 1),
            "talent (Biblical Hebrew)": Decimal(string: "34.2")!,
            "mina (Biblical Hebrew)": Decimal(string: "0.57")!,
            "shekel (Biblical Hebrew)": Decimal(string: "0.0114")!,
            "bekan (Biblical Hebrew)": Decimal(string: "0.0057")!,
            "gerah (Biblical Hebrew)": Decimal(string: "0.00057")!,
            "talent (Biblical Greek)": Decimal(string: "20.4")!,
            "mina (Biblical Greek)": Decimal(string: "0.34")!,
            "tetradrachma (Biblical Greek)": Decimal(string: "0.0136")!,
            "didrachma (Biblical Greek)": Decimal(string: "0.0068")!,
            "drachma (Biblical Greek)": Decimal(string: "0.0034")!,
            "denarius (Biblical Roman)": Decimal(string: "0.00385")!,
            "assarion (Biblical Roman)": Decimal(string: "0.000240625")!,
            "quadrans (Biblical Roman)": Decimal(string: "6.01563e-5")!,
            "lepton (Biblical Roman)": Decimal(string: "3.00781e-5")!,
            "Planck mass": Decimal(string: "2.17671e-8")!,
            "Electron mass (rest)": Decimal(string: "9.1093897e-31")!,
            "Muon mass": Decimal(string: "1.8835327e-28")!,
            "Proton mass": Decimal(string: "1.6726231e-27")!,
            "Neutron mass": Decimal(string: "1.6749286e-27")!,
            "Deuteron mass": Decimal(string: "3.343586e-27")!,
            "Earth's mass": Decimal(string: "5.9760000000002e24")!,
            "Sun's mass": Decimal(sign: .plus, exponent: 30, significand: 2)
        ]

        guard let fromValue = kilogramValues[fromUnit.lowercased()], let toValue = kilogramValues[toUnit.lowercased()] else {
            return value
        }

        let kilograms = value * fromValue
        return kilograms / toValue
    }
            
    private func convertVolume(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let cubicMeterValues: [String: Decimal] = [
            "cubic meter": 1,
            "cubic kilometer": Decimal(sign: .plus, exponent: 9, significand: 1),
            "cubic centimeter": Decimal(sign: .minus, exponent: 6, significand: 1),
            "cubic millimeter": Decimal(sign: .minus, exponent: 9, significand: 1),
            "liter": Decimal(string: "0.001")!,
            "milliliter": Decimal(sign: .minus, exponent: 6, significand: 1),
            "gallon (US)": Decimal(string: "0.0037854118")!,
            "quart (US)": Decimal(string: "0.0009463529")!,
            "pint (US)": Decimal(string: "0.0004731765")!,
            "cup (US)": Decimal(string: "0.0002365882")!,
            "tablespoon (US)": Decimal(string: "1.47868e-5")!,
            "teaspoon (US)": Decimal(string: "4.92892159375e-6")!,
            "cubic mile": Decimal(string: "4168181825.4406")!,
            "cubic yard": Decimal(string: "0.764554858")!,
            "cubic foot": Decimal(string: "0.0283168466")!,
            "cubic inch": Decimal(string: "1.63871e-5")!,
            "cubic decimeter": Decimal(string: "0.001")!,
            "exaliter": Decimal(sign: .plus, exponent: 15, significand: 1),
            "petaliter": Decimal(sign: .plus, exponent: 12, significand: 1),
            "teraliter": Decimal(sign: .plus, exponent: 9, significand: 1),
            "gigaliter": Decimal(sign: .plus, exponent: 6, significand: 1),
            "megaliter": 1000,
            "kiloliter": 1,
            "hectoliter": Decimal(string: "0.1")!,
            "dekaliter": Decimal(string: "0.01")!,
            "deciliter": Decimal(string: "0.0001")!,
            "centiliter": Decimal(sign: .minus, exponent: 5, significand: 1),
            "microliter": Decimal(sign: .minus, exponent: 9, significand: 1),
            "nanoliter": Decimal(sign: .minus, exponent: 12, significand: 1),
            "picoliter": Decimal(sign: .minus, exponent: 15, significand: 1),
            "femtoliter": Decimal(sign: .minus, exponent: 18, significand: 1),
            "attoliter": Decimal(sign: .minus, exponent: 21, significand: 1),
            "cc": Decimal(sign: .minus, exponent: 6, significand: 1),
            "drop": Decimal(sign: .minus, exponent: 8, significand: 5),
            "barrel (oil)": Decimal(string: "0.1589872949")!,
            "barrel (US)": Decimal(string: "0.1192404712")!,
            "barrel (UK)": Decimal(string: "0.16365924")!,
            "gallon (UK)": Decimal(string: "0.00454609")!,
            "quart (UK)": Decimal(string: "0.0011365225")!,
            "pint (UK)": Decimal(string: "0.0005682613")!,
            "cup (metric)": Decimal(string: "0.00025")!,
            "cup (UK)": Decimal(string: "0.0002841306")!,
            "fluid ounce (US)": Decimal(string: "2.95735e-5")!,
            "fluid ounce (UK)": Decimal(string: "2.84131e-5")!,
            "tablespoon (metric)": Decimal(string: "1.5e-5")!,
            "tablespoon (UK)": Decimal(string: "1.77582e-5")!,
            "dessertspoon (US)": Decimal(string: "9.8578431875e-6")!,
            "dessertspoon (UK)": Decimal(string: "1.18388e-5")!,
            "teaspoon (metric)": Decimal(string: "5e-6")!,
            "teaspoon (UK)": Decimal(string: "5.9193880208333e-6")!,
            "gill (US)": Decimal(string: "0.0001182941")!,
            "gill (UK)": Decimal(string: "0.0001420653")!,
            "minim (US)": Decimal(string: "6.1611519921875e-8")!,
            "minim (UK)": Decimal(string: "5.9193880208333e-8")!,
            "ton register": Decimal(string: "2.8316846592")!,
            "ccf": Decimal(string: "2.8316846592")!,
            "hundred-cubic foot": Decimal(string: "2.8316846592")!,
            "acre-foot": Decimal(string: "1233.4818375475")!,
            "acre-foot (US survey)": Decimal(string: "1233.4892384682")!,
            "acre-inch": Decimal(string: "102.790153129")!,
            "dekastere": 10,
            "stere": 1,
            "decistere": Decimal(string: "0.1")!,
            "cord": Decimal(string: "3.6245563638")!,
            "tun": Decimal(string: "0.9539237696")!,
            "hogshead": Decimal(string: "0.2384809424")!,
            "board foot": Decimal(string: "0.0023597372")!,
            "dram": Decimal(string: "3.6966911953125e-6")!,
            "cor (Biblical)": Decimal(string: "0.22")!,
            "homer (Biblical)": Decimal(string: "0.22")!,
            "bath (Biblical)": Decimal(string: "0.022")!,
            "hin (Biblical)": Decimal(string: "0.0036666667")!,
            "cab (Biblical)": Decimal(string: "0.0012222222")!,
            "log (Biblical)": Decimal(string: "0.0003055556")!,
            "Taza (Spanish)": Decimal(string: "0.0002365882")!,
            "Earth's volume": Decimal(string: "1.083e21")!
        ]
        
        guard let fromValue = cubicMeterValues[fromUnit.lowercased()], let toValue = cubicMeterValues[toUnit.lowercased()] else {
            return value
        }

        let cubicMeters = value * fromValue
        return cubicMeters / toValue
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
        case "reaumur", "°re":
            kelvin = value * 5/4 + Decimal(273.15)
        case "triple point of water":
            kelvin = Decimal(273.16)
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
        case "reaumur", "°re":
            return (kelvin - Decimal(273.15)) * 4/5
        case "triple point of water":
            return Decimal(273.16)
        default:
            return value
        }
    }
    
    private func convertArea(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let squareMeterValues: [String: Decimal] = [
            "square meter": 1,
            "square kilometer": Decimal(sign: .plus, exponent: 6, significand: 1),
            "square centimeter": Decimal(sign: .minus, exponent: 4, significand: 1),
            "square millimeter": Decimal(sign: .minus, exponent: 6, significand: 1),
            "square micrometer": Decimal(sign: .minus, exponent: 12, significand: 1),
            "hectare": Decimal(sign: .plus, exponent: 4, significand: 1),
            "acre": Decimal(string: "4046.8564224")!,
            "square mile": Decimal(string: "2589988.110336")!,
            "square yard": Decimal(string: "0.83612736")!,
            "square foot": Decimal(string: "0.09290304")!,
            "square inch": Decimal(string: "0.00064516")!,
            "square hectometer": Decimal(sign: .plus, exponent: 4, significand: 1),
            "square dekameter": 100,
            "square decimeter": Decimal(string: "0.01")!,
            "square nanometer": Decimal(sign: .minus, exponent: 18, significand: 1),
            "are": 100,
            "barn": Decimal(sign: .minus, exponent: 28, significand: 1),
            "square mile (US survey)": Decimal(string: "2589998.4703195")!,
            "square foot (US survey)": Decimal(string: "0.0929034116")!,
            "circular inch": Decimal(string: "0.0005067075")!,
            "township": Decimal(string: "93239571.972096")!,
            "section": Decimal(string: "2589988.110336")!,
            "acre (US survey)": Decimal(string: "4046.8726098743")!,
            "rood": Decimal(string: "1011.7141056")!,
            "square chain": Decimal(string: "404.68564224")!,
            "square rod": Decimal(string: "25.29285264")!,
            "square rod (US survey)": Decimal(string: "25.2929538117")!,
            "square perch": Decimal(string: "25.29285264")!,
            "square pole": Decimal(string: "25.29285264")!,
            "square mil": Decimal(string: "6.4516e-10")!,
            "circular mil": Decimal(string: "5.067074790975e-10")!,
            "homestead": Decimal(string: "647497.027584")!,
            "sabin": Decimal(string: "0.09290304")!,
            "arpent": Decimal(string: "3418.8929236669")!,
            "cuerda": Decimal(string: "3930.395625")!,
            "plaza": 6400,
            "varas castellanas cuad": Decimal(string: "0.698737")!,
            "varas conuqueras cuad": Decimal(string: "6.288633")!,
            "Electron cross section": Decimal(string: "6.6524615999999e-29")!
        ]

        guard let fromValue = squareMeterValues[fromUnit.lowercased()], let toValue = squareMeterValues[toUnit.lowercased()] else {
            return value
        }

        let squareMeters = value * fromValue
        return squareMeters / toValue
    }
            
    private func convertPressure(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let pascalValues: [String: Decimal] = [
            "pascal": 1,
            "kilopascal": 1000,
            "bar": 100000,
            "psi": Decimal(string: "6894.7572931783")!,
            "ksi": Decimal(string: "6894757.2931783")!,
            "Standard atmosphere": 101325,
            "exapascal": Decimal(sign: .plus, exponent: 18, significand: 1),
            "petapascal": Decimal(sign: .plus, exponent: 15, significand: 1),
            "terapascal": Decimal(sign: .plus, exponent: 12, significand: 1),
            "gigapascal": Decimal(sign: .plus, exponent: 9, significand: 1),
            "megapascal": Decimal(sign: .plus, exponent: 6, significand: 1),
            "hectopascal": 100,
            "dekapascal": 10,
            "decipascal": Decimal(string: "0.1")!,
            "centipascal": Decimal(string: "0.01")!,
            "millipascal": Decimal(string: "0.001")!,
            "micropascal": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nanopascal": Decimal(sign: .minus, exponent: 9, significand: 1),
            "picopascal": Decimal(sign: .minus, exponent: 12, significand: 1),
            "femtopascal": Decimal(sign: .minus, exponent: 15, significand: 1),
            "attopascal": Decimal(sign: .minus, exponent: 18, significand: 1),
            "newton/square meter": 1,
            "newton/square centimeter": 10000,
            "newton/square millimeter": 1000000,
            "kilonewton/square meter": 1000,
            "millibar": 100,
            "microbar": Decimal(string: "0.1")!,
            "dyne/square centimeter": Decimal(string: "0.1")!,
            "kilogram-force/square meter": Decimal(string: "9.80665")!,
            "kilogram-force/sq. cm": Decimal(string: "98066.5")!,
            "kilogram-force/sq. millimeter": 9806650,
            "gram-force/sq. centimeter": Decimal(string: "98.0665")!,
            "ton-force (short)/sq. foot": Decimal(string: "95760.517960678")!,
            "ton-force (short)/sq. inch": Decimal(string: "13789514.586338")!,
            "ton-force (long)/square foot": Decimal(string: "107251.78011595")!,
            "ton-force (long)/square inch": Decimal(string: "15444256.336697")!,
            "kip-force/square inch": Decimal(string: "6894757.2931783")!,
            "pound-force/square foot": Decimal(string: "47.8802589804")!,
            "pound-force/square inch": Decimal(string: "6894.7572931783")!,
            "poundal/square foot": Decimal(string: "1.4881639436")!,
            "torr": Decimal(string: "133.3223684211")!,
            "centimeter mercury (0°C)": Decimal(string: "1333.22")!,
            "millimeter mercury (0°C)": Decimal(string: "133.322")!,
            "inch mercury (32°F)": Decimal(string: "3386.38")!,
            "inch mercury (60°F)": Decimal(string: "3376.85")!,
            "centimeter water (4°C)": Decimal(string: "98.0638")!,
            "millimeter water (4°C)": Decimal(string: "9.80638")!,
            "inch water (4°C)": Decimal(string: "249.082")!,
            "foot water (4°C)": Decimal(string: "2988.98")!,
            "inch water (60°F)": Decimal(string: "248.843")!,
            "foot water (60°F)": Decimal(string: "2986.116")!,
            "atmosphere technical": Decimal(string: "98066.500000003")!
        ]

        guard let fromValue = pascalValues[fromUnit.lowercased()], let toValue = pascalValues[toUnit.lowercased()] else {
            return value
        }

        let pascals = value * fromValue
        return pascals / toValue
    }
            
    private func convertAngle(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let degreeValues: [String: Decimal] = [
            "degree": 1,
            "radian": Decimal(string: "57.2957795131")!,
            "grad": Decimal(string: "0.9")!,
            "minute": Decimal(1) / 60,
            "second": Decimal(1) / 3600,
            "gon": Decimal(string: "0.9")!,
            "sign": 30,
            "mil": Decimal(string: "0.05625")!,
            "revolution": 360,
            "circle": 360,
            "turn": 360,
            "quadrant": 90,
            "right angle": 90,
            "sextant": 60
        ]

        guard let fromValue = degreeValues[fromUnit.lowercased()], let toValue = degreeValues[toUnit.lowercased()] else {
            return value
        }

        let degrees = value * fromValue
        return degrees / toValue
    }
    
    private func convertSpeed(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let meterPerSecondValues: [String: Decimal] = [
            "meter/second": 1,
            "kilometer/hour": Decimal(string: "0.2777777778")!,
            "mile/hour": Decimal(string: "0.44704")!,
            "meter/hour": Decimal(string: "0.0002777778")!,
            "meter/minute": Decimal(string: "0.0166666667")!,
            "kilometer/minute": Decimal(string: "16.6666666667")!,
            "kilometer/second": 1000,
            "centimeter/hour": Decimal(string: "2.7777777777778E-6")!,
            "centimeter/minute": Decimal(string: "0.0001666667")!,
            "centimeter/second": Decimal(string: "0.01")!,
            "millimeter/hour": Decimal(string: "2.7777777777778E-7")!,
            "millimeter/minute": Decimal(string: "1.66667E-5")!,
            "millimeter/second": Decimal(string: "0.001")!,
            "foot/hour": Decimal(string: "8.46667E-5")!,
            "foot/minute": Decimal(string: "0.00508")!,
            "foot/second": Decimal(string: "0.3048")!,
            "yard/hour": Decimal(string: "0.000254")!,
            "yard/minute": Decimal(string: "0.01524")!,
            "yard/second": Decimal(string: "0.9144")!,
            "mile/minute": Decimal(string: "26.8224")!,
            "mile/second": Decimal(string: "1609.344")!,
            "knot": Decimal(string: "0.5144444444")!,
            "knot (UK)": Decimal(string: "0.5147733333")!,
            "Velocity of light in vacuum": 299792458,
            "Cosmic velocity - first": Decimal(string: "7899.9999999999")!,
            "Cosmic velocity - second": 11200,
            "Cosmic velocity - third": 16670,
            "Earth's velocity": 29765,
            "Velocity of sound in pure water": Decimal(string: "1482.6999999998")!,
            "Velocity of sound in sea water (20°C, 10 meter deep)": Decimal(string: "1521.6")!,
            "Mach (20°C, 1 atm)": Decimal(string: "343.6")!,
            "Mach (SI standard)": Decimal(string: "295.0464000003")!
        ]
        
        guard let fromValue = meterPerSecondValues[fromUnit.lowercased()], let toValue = meterPerSecondValues[toUnit.lowercased()] else {
            return value
        }

        let meterPerSecond = value * fromValue
        return meterPerSecond / toValue
    }
        
    private func convertDuration(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let secondValues: [String: Decimal] = [
            "second": 1,
            "millisecond": Decimal(string: "0.001")!,
            "minute": 60,
            "hour": 3600,
            "day": 86400,
            "week": 604800,
            "month": 2628000,
            "year": 31557600,
            "decade": 315576000,
            "century": 3155760000,
            "millennium": 31557600000,
            "microsecond": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nanosecond": Decimal(sign: .minus, exponent: 9, significand: 1),
            "picosecond": Decimal(sign: .minus, exponent: 12, significand: 1),
            "femtosecond": Decimal(sign: .minus, exponent: 15, significand: 1),
            "attosecond": Decimal(sign: .minus, exponent: 18, significand: 1),
            "shake": Decimal(sign: .minus, exponent: 8, significand: 1),
            "month (synodic)": Decimal(string: "2551443.84")!,
            "year (Julian)": 31557600,
            "year (leap)": 31622400,
            "year (tropical)": 31556930,
            "year (sidereal)": Decimal(string: "31558149.54")!,
            "day (sidereal)": Decimal(string: "86164.09")!,
            "hour (sidereal)": Decimal(string: "3590.1704166667")!,
            "minute (sidereal)": Decimal(string: "59.8361736111")!,
            "second (sidereal)": Decimal(string: "0.9972695602")!,
            "fortnight": 1209600,
            "septennial": 220752000,
            "octennial": 252288000,
            "novennial": 283824000,
            "quindecennial": 473040000,
            "quinquennial": 157680000,
            "Planck time": Decimal(string: "5.39056e-44")!
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

    
    var info: LocalizedStringKey {
        switch self {
        case .mass:
            return "MassInfo"
        case .length:
            return "LengthInfo"
        case .area:
            return "AreaInfo"
        case .volume:
            return "VolumeInfo"
        case .pressure:
            return "PressureInfo"
        case .temperature:
            return "TemperatureInfo"
        case .angle:
            return "AngleInfo"
        case .speed:
            return "SpeedInfo"
        case .duration:
            return "DurationInfo"
        }
    }
    
    var availableUnits: [(symbol: String, name: String)] {
        switch self {
        case .length:
            return [
                ("m", String(localized: "meter")),
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
                ("handbreadth", "handbreadth"),
                ("fingerbreadth", "fingerbreadth"),
                ("lP", "Planck length"),
                ("re", "Electron radius (classical)"),
                ("a0", "Bohr radius"),
                ("RE", "Earth's equatorial radius"),
                ("RP", "Earth's polar radius"),
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
                ("cent", "century"),
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
                ("yr(trop)", "year (tropical)"),
                ("yr(sid)", "year (sidereal)"),
                ("d(sid)", "day (sidereal)"),
                ("h(sid)", "hour (sidereal)"),
                ("min(sid)", "minute (sidereal)"),
                ("s(sid)", "second (sidereal)"),
                ("fortnight", "fortnight"),
                ("septennial", "septennial"),
                ("octennial", "octennial"),
                ("novennial", "novennial"),
                ("quindecennial", "quindecennial"),
                ("quinquennial", "quinquennial"),
                ("tP", "Planck time")
            ]
        }
    }
}
