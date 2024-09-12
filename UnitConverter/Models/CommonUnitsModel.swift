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
                ("km", String(localized: "kilometer")),
                ("dm", String(localized: "decimeter")),
                ("cm", String(localized: "centimeter")),
                ("mm", String(localized: "millimeter")),
                ("µm", String(localized: "micrometer")),
                ("nm", String(localized: "nanometer")),
                ("mi", String(localized: "mile")),
                ("yd", String(localized: "yard")),
                ("ft", String(localized: "foot")),
                ("in", String(localized: "inch")),
                ("ly", String(localized: "light year")),
                ("Em", String(localized: "exameter")),
                ("Pm", String(localized: "petameter")),
                ("Tm", String(localized: "terameter")),
                ("Gm", String(localized: "gigameter")),
                ("Mm", String(localized: "megameter")),
                ("hm", String(localized: "hectometer")),
                ("dam", String(localized: "dekameter")),
                ("µ", String(localized: "micron")),
                ("pm", String(localized: "picometer")),
                ("fm", String(localized: "femtometer")),
                ("am", String(localized: "attometer")),
                ("Mpc", String(localized: "megaparsec")),
                ("kpc", String(localized: "kiloparsec")),
                ("pc", String(localized: "parsec")),
                ("au", String(localized: "astronomical unit")),
                ("lea", String(localized: "league")),
                ("nlea(UK)", String(localized: "nautical league (UK)")),
                ("nlea(int)", String(localized: "nautical league (int.)")),
                ("lea(st)", String(localized: "league (statute)")),
                ("nmi(UK)", String(localized: "nautical mile (UK)")),
                ("nmi(int)", String(localized: "nautical mile (international)")),
                ("mi(st)", String(localized: "mile (statute)")),
                ("mi(US)", String(localized: "mile (US survey)")),
                ("mi(Rom)", String(localized: "mile (Roman)")),
                ("kyd", String(localized: "kiloyard")),
                ("fur", String(localized: "furlong")),
                ("fur(US)", String(localized: "furlong (US survey)")),
                ("ch", String(localized: "chain")),
                ("ch(US)", String(localized: "chain (US survey)")),
                ("rope", String(localized: "rope")),
                ("rod", String(localized: "rod")),
                ("rod(US)", String(localized: "rod (US survey)")),
                ("per", String(localized: "perch")),
                ("pole", String(localized: "pole")),
                ("fth", String(localized: "fathom")),
                ("fth(US)", String(localized: "fathom (US survey)")),
                ("ell", String(localized: "ell")),
                ("ft(US)", String(localized: "foot (US survey)")),
                ("link", String(localized: "link")),
                ("link(US)", String(localized: "link (US survey)")),
                ("cubit(UK)", String(localized: "cubit (UK)")),
                ("hand", String(localized: "hand")),
                ("span", String(localized: "span (cloth)")),
                ("finger", String(localized: "finger (cloth)")),
                ("nail", String(localized: "nail (cloth)")),
                ("in(US)", String(localized: "inch (US survey)")),
                ("barleycorn", String(localized: "barleycorn")),
                ("mil", String(localized: "mil")),
                ("µin", String(localized: "microinch")),
                ("Å", String(localized: "angstrom")),
                ("au(l)", String(localized: "a.u. of length")),
                ("X", String(localized: "X-unit")),
                ("F", String(localized: "fermi")),
                ("arpent", String(localized: "arpent")),
                ("pica", String(localized: "pica")),
                ("point", String(localized: "point")),
                ("twip", String(localized: "twip")),
                ("aln", String(localized: "aln")),
                ("famn", String(localized: "famn")),
                ("cal", String(localized: "caliber")),
                ("cin", String(localized: "centiinch")),
                ("ken", String(localized: "ken")),
                ("archin", String(localized: "Russian archin")),
                ("actus", String(localized: "Roman actus")),
                ("vara(t)", String(localized: "vara de tarea")),
                ("vara(c)", String(localized: "vara conuquera")),
                ("vara(cas)", String(localized: "vara castellana")),
                ("cubit(Gr)", String(localized: "cubit (Greek)")),
                ("lreed", String(localized: "long reed")),
                ("reed", String(localized: "reed")),
                ("lcubit", String(localized: "long cubit")),
                ("handbreadth", String(localized: "handbreadth")),
                ("fingerbreadth", String(localized: "fingerbreadth")),
                ("lP", String(localized: "Planck length")),
                ("re", String(localized: "Electron radius (classical)")),
                ("a0", String(localized: "Bohr radius")),
                ("RE", String(localized: "Earth's equatorial radius")),
                ("RP", String(localized: "Earth's polar radius")),
                ("AU", String(localized: "Earth's distance from sun")),
                ("RS", String(localized: "Sun's radius"))
            ]
        case .mass:
            return [
                ("kg", String(localized: "kilogram")),
                ("g", String(localized: "gram")),
                ("mg", String(localized: "milligram")),
                ("t", String(localized: "ton (metric)")),
                ("lb", String(localized: "pound")),
                ("oz", String(localized: "ounce")),
                ("ct", String(localized: "carat")),
                ("ton(sh)", String(localized: "ton (short)")),
                ("ton(l)", String(localized: "ton (long)")),
                ("u", String(localized: "Atomic mass unit")),
                ("Eg", String(localized: "exagram")),
                ("Pg", String(localized: "petagram")),
                ("Tg", String(localized: "teragram")),
                ("Gg", String(localized: "gigagram")),
                ("Mg", String(localized: "megagram")),
                ("hg", String(localized: "hectogram")),
                ("dag", String(localized: "dekagram")),
                ("dg", String(localized: "decigram")),
                ("cg", String(localized: "centigram")),
                ("µg", String(localized: "microgram")),
                ("ng", String(localized: "nanogram")),
                ("pg", String(localized: "picogram")),
                ("fg", String(localized: "femtogram")),
                ("ag", String(localized: "attogram")),
                ("Da", String(localized: "dalton")),
                ("kgf·s²/m", String(localized: "kilogram-force square second/meter")),
                ("klb", String(localized: "kilopound")),
                ("kip", String(localized: "kip")),
                ("slug", String(localized: "slug")),
                ("lbf·s²/ft", String(localized: "pound-force square second/foot")),
                ("lb(t)", String(localized: "pound (troy or apothecary)")),
                ("pdl", String(localized: "poundal")),
                ("ton(a,US)", String(localized: "ton (assay) (US)")),
                ("ton(a,UK)", String(localized: "ton (assay) (UK)")),
                ("kt", String(localized: "kiloton (metric)")),
                ("q", String(localized: "quintal (metric)")),
                ("cwt(US)", String(localized: "hundredweight (US)")),
                ("cwt(UK)", String(localized: "hundredweight (UK)")),
                ("qr(US)", String(localized: "quarter (US)")),
                ("qr(UK)", String(localized: "quarter (UK)")),
                ("stone(US)", String(localized: "stone (US)")),
                ("stone(UK)", String(localized: "stone (UK)")),
                ("t", String(localized: "tonne")),
                ("dwt", String(localized: "pennyweight")),
                ("s(ap)", String(localized: "scruple (apothecary)")),
                ("gr", String(localized: "grain")),
                ("γ", String(localized: "gamma")),
                ("talent(BH)", String(localized: "talent (Biblical Hebrew)")),
                ("mina(BH)", String(localized: "mina (Biblical Hebrew)")),
                ("shekel(BH)", String(localized: "shekel (Biblical Hebrew)")),
                ("bekan(BH)", String(localized: "bekan (Biblical Hebrew)")),
                ("gerah(BH)", String(localized: "gerah (Biblical Hebrew)")),
                ("talent(BG)", String(localized: "talent (Biblical Greek)")),
                ("mina(BG)", String(localized: "mina (Biblical Greek)")),
                ("tetradrachma(BG)", String(localized: "tetradrachma (Biblical Greek)")),
                ("didrachma(BG)", String(localized: "didrachma (Biblical Greek)")),
                ("drachma(BG)", String(localized: "drachma (Biblical Greek)")),
                ("denarius(BR)", String(localized: "denarius (Biblical Roman)")),
                ("assarion(BR)", String(localized: "assarion (Biblical Roman)")),
                ("quadrans(BR)", String(localized: "quadrans (Biblical Roman)")),
                ("lepton(BR)", String(localized: "lepton (Biblical Roman)")),
                ("mP", String(localized: "Planck mass")),
                ("me", String(localized: "Electron mass (rest)")),
                ("mµ", String(localized: "Muon mass")),
                ("mp", String(localized: "Proton mass")),
                ("mn", String(localized: "Neutron mass")),
                ("md", String(localized: "Deuteron mass")),
                ("ME", String(localized: "Earth's mass")),
                ("MS", String(localized: "Sun's mass"))
            ]
            case .volume:
                return [
                    ("m³", String(localized: "cubic meter")),
                    ("km³", String(localized: "cubic kilometer")),
                    ("cm³", String(localized: "cubic centimeter")),
                    ("mm³", String(localized: "cubic millimeter")),
                    ("L", String(localized: "liter")),
                    ("mL", String(localized: "milliliter")),
                    ("gal(US)", String(localized: "gallon (US)")),
                    ("qt(US)", String(localized: "quart (US)")),
                    ("pt(US)", String(localized: "pint (US)")),
                    ("cup(US)", String(localized: "cup (US)")),
                    ("tbsp(US)", String(localized: "tablespoon (US)")),
                    ("tsp(US)", String(localized: "teaspoon (US)")),
                    ("mi³", String(localized: "cubic mile")),
                    ("yd³", String(localized: "cubic yard")),
                    ("ft³", String(localized: "cubic foot")),
                    ("in³", String(localized: "cubic inch")),
                    ("dm³", String(localized: "cubic decimeter")),
                    ("EL", String(localized: "exaliter")),
                    ("PL", String(localized: "petaliter")),
                    ("TL", String(localized: "teraliter")),
                    ("GL", String(localized: "gigaliter")),
                    ("ML", String(localized: "megaliter")),
                    ("kL", String(localized: "kiloliter")),
                    ("hL", String(localized: "hectoliter")),
                    ("daL", String(localized: "dekaliter")),
                    ("dL", String(localized: "deciliter")),
                    ("cL", String(localized: "centiliter")),
                    ("µL", String(localized: "microliter")),
                    ("nL", String(localized: "nanoliter")),
                    ("pL", String(localized: "picoliter")),
                    ("fL", String(localized: "femtoliter")),
                    ("aL", String(localized: "attoliter")),
                    ("cc", String(localized: "cc")),
                    ("drop", String(localized: "drop")),
                    ("bbl(oil)", String(localized: "barrel (oil)")),
                    ("bbl(US)", String(localized: "barrel (US)")),
                    ("bbl(UK)", String(localized: "barrel (UK)")),
                    ("gal(UK)", String(localized: "gallon (UK)")),
                    ("qt(UK)", String(localized: "quart (UK)")),
                    ("pt(UK)", String(localized: "pint (UK)")),
                    ("cup(m)", String(localized: "cup (metric)")),
                    ("cup(UK)", String(localized: "cup (UK)")),
                    ("fl oz(US)", String(localized: "fluid ounce (US)")),
                    ("fl oz(UK)", String(localized: "fluid ounce (UK)")),
                    ("tbsp(m)", String(localized: "tablespoon (metric)")),
                    ("tbsp(UK)", String(localized: "tablespoon (UK)")),
                    ("dsp(US)", String(localized: "dessertspoon (US)")),
                    ("dsp(UK)", String(localized: "dessertspoon (UK)")),
                    ("tsp(m)", String(localized: "teaspoon (metric)")),
                    ("tsp(UK)", String(localized: "teaspoon (UK)")),
                    ("gill(US)", String(localized: "gill (US)")),
                    ("gill(UK)", String(localized: "gill (UK)")),
                    ("min(US)", String(localized: "minim (US)")),
                    ("min(UK)", String(localized: "minim (UK)")),
                    ("reg ton", String(localized: "ton register")),
                    ("ccf", String(localized: "ccf")),
                    ("hcf", String(localized: "hundred-cubic foot")),
                    ("ac·ft", String(localized: "acre-foot")),
                    ("ac·ft(US)", String(localized: "acre-foot (US survey)")),
                    ("ac·in", String(localized: "acre-inch")),
                    ("das", String(localized: "dekastere")),
                    ("s", String(localized: "stere")),
                    ("ds", String(localized: "decistere")),
                    ("cord", String(localized: "cord")),
                    ("tun", String(localized: "tun")),
                    ("hhd", String(localized: "hogshead")),
                    ("bf", String(localized: "board foot")),
                    ("dr", String(localized: "dram")),
                    ("cor(B)", String(localized: "cor (Biblical)")),
                    ("homer(B)", String(localized: "homer (Biblical)")),
                    ("bath(B)", String(localized: "bath (Biblical)")),
                    ("hin(B)", String(localized: "hin (Biblical)")),
                    ("cab(B)", String(localized: "cab (Biblical)")),
                    ("log(B)", String(localized: "log (Biblical)")),
                    ("taza", String(localized: "Taza (Spanish)")),
                    ("VE", String(localized: "Earth's volume"))
                ]
        case .temperature:
            return [
                ("K", String(localized: "Kelvin")),
                ("°C", String(localized: "Celsius")),
                ("°F", String(localized: "Fahrenheit")),
                ("°R", String(localized: "Rankine")),
                ("°Ré", String(localized: "Reaumur")),
                ("Tw", String(localized: "Triple point of water"))
            ]
            case .area:
                return [
                    ("m²", String(localized: "square meter")),
                    ("km²", String(localized: "square kilometer")),
                    ("cm²", String(localized: "square centimeter")),
                    ("mm²", String(localized: "square millimeter")),
                    ("µm²", String(localized: "square micrometer")),
                    ("ha", String(localized: "hectare")),
                    ("ac", String(localized: "acre")),
                    ("mi²", String(localized: "square mile")),
                    ("yd²", String(localized: "square yard")),
                    ("ft²", String(localized: "square foot")),
                    ("in²", String(localized: "square inch")),
                    ("hm²", String(localized: "square hectometer")),
                    ("dam²", String(localized: "square dekameter")),
                    ("dm²", String(localized: "square decimeter")),
                    ("nm²", String(localized: "square nanometer")),
                    ("a", String(localized: "are")),
                    ("b", String(localized: "barn")),
                    ("mi²(US)", String(localized: "square mile (US survey)")),
                    ("ft²(US)", String(localized: "square foot (US survey)")),
                    ("cir in", String(localized: "circular inch")),
                    ("twp", String(localized: "township")),
                    ("sec", String(localized: "section")),
                    ("ac(US)", String(localized: "acre (US survey)")),
                    ("rood", String(localized: "rood")),
                    ("ch²", String(localized: "square chain")),
                    ("rod²", String(localized: "square rod")),
                    ("rod²(US)", String(localized: "square rod (US survey)")),
                    ("per²", String(localized: "square perch")),
                    ("pole²", String(localized: "square pole")),
                    ("mil²", String(localized: "square mil")),
                    ("cir mil", String(localized: "circular mil")),
                    ("homestead", String(localized: "homestead")),
                    ("sabin", String(localized: "sabin")),
                    ("arpent", String(localized: "arpent")),
                    ("cuerda", String(localized: "cuerda")),
                    ("plaza", String(localized: "plaza")),
                    ("var²(cas)", String(localized: "varas castellanas cuad")),
                    ("var²(con)", String(localized: "varas conuqueras cuad")),
                    ("σe", String(localized: "Electron cross section"))
                ]
            case .pressure:
                return [
                    ("Pa", String(localized: "pascal")),
                    ("kPa", String(localized: "kilopascal")),
                    ("bar", String(localized: "bar")),
                    ("psi", String(localized: "psi")),
                    ("ksi", String(localized: "ksi")),
                    ("atm", String(localized: "Standard atmosphere")),
                    ("EPa", String(localized: "exapascal")),
                    ("PPa", String(localized: "petapascal")),
                    ("TPa", String(localized: "terapascal")),
                    ("GPa", String(localized: "gigapascal")),
                    ("MPa", String(localized: "megapascal")),
                    ("hPa", String(localized: "hectopascal")),
                    ("daPa", String(localized: "dekapascal")),
                    ("dPa", String(localized: "decipascal")),
                    ("cPa", String(localized: "centipascal")),
                    ("mPa", String(localized: "millipascal")),
                    ("µPa", String(localized: "micropascal")),
                    ("nPa", String(localized: "nanopascal")),
                    ("pPa", String(localized: "picopascal")),
                    ("fPa", String(localized: "femtopascal")),
                    ("aPa", String(localized: "attopascal")),
                    ("N/m²", String(localized: "newton/square meter")),
                    ("N/cm²", String(localized: "newton/square centimeter")),
                    ("N/mm²", String(localized: "newton/square millimeter")),
                    ("kN/m²", String(localized: "kilonewton/square meter")),
                    ("mbar", String(localized: "millibar")),
                    ("µbar", String(localized: "microbar")),
                    ("dyn/cm²", String(localized: "dyne/square centimeter")),
                    ("kgf/m²", String(localized: "kilogram-force/square meter")),
                    ("kgf/cm²", String(localized: "kilogram-force/sq. cm")),
                    ("kgf/mm²", String(localized: "kilogram-force/sq. millimeter")),
                    ("gf/cm²", String(localized: "gram-force/sq. centimeter")),
                    ("tonf(sh)/ft²", String(localized: "ton-force (short)/sq. foot")),
                    ("tonf(sh)/in²", String(localized: "ton-force (short)/sq. inch")),
                    ("tonf(l)/ft²", String(localized: "ton-force (long)/square foot")),
                    ("tonf(l)/in²", String(localized: "ton-force (long)/square inch")),
                    ("kipf/in²", String(localized: "kip-force/square inch")),
                    ("lbf/ft²", String(localized: "pound-force/square foot")),
                    ("lbf/in²", String(localized: "pound-force/square inch")),
                    ("pdl/ft²", String(localized: "poundal/square foot")),
                    ("Torr", String(localized: "torr")),
                    ("cmHg", String(localized: "centimeter mercury (0°C)")),
                    ("mmHg", String(localized: "millimeter mercury (0°C)")),
                    ("inHg", String(localized: "inch mercury (32°F)")),
                    ("inHg(60°F)", String(localized: "inch mercury (60°F)")),
                    ("cmH2O", String(localized: "centimeter water (4°C)")),
                    ("mmH2O", String(localized: "millimeter water (4°C)")),
                    ("inH2O", String(localized: "inch water (4°C)")),
                    ("ftH2O", String(localized: "foot water (4°C)")),
                    ("inH2O(60°F)", String(localized: "inch water (60°F)")),
                    ("ftH2O(60°F)", String(localized: "foot water (60°F)")),
                    ("at", String(localized: "atmosphere technical"))
                ]
        case .angle:
            return [
                ("°", String(localized: "degree")),
                ("rad", String(localized: "radian")),
                ("grad", String(localized: "grad")),
                ("'", String(localized: "minute")),
                ("\"", String(localized: "second")),
                ("gon", String(localized: "gon")),
                ("sign", String(localized: "sign")),
                ("mil", String(localized: "mil")),
                ("rev", String(localized: "revolution")),
                ("⊙", String(localized: "circle")),
                ("tr", String(localized: "turn")),
                ("quad", String(localized: "quadrant")),
                ("right angle", String(localized: "right angle")),
            ]
        case .speed:
            return [
                ("m/s", String(localized: "meter/second")),
                ("km/h", String(localized: "kilometer/hour")),
                ("mi/h", String(localized: "mile/hour")),
                ("m/h", String(localized: "meter/hour")),
                ("m/min", String(localized: "meter/minute")),
                ("km/min", String(localized: "kilometer/minute")),
                ("km/s", String(localized: "kilometer/second")),
                ("cm/h", String(localized: "centimeter/hour")),
                ("cm/min", String(localized: "centimeter/minute")),
                ("cm/s", String(localized: "centimeter/second")),
                ("mm/h", String(localized: "millimeter/hour")),
                ("mm/min", String(localized: "millimeter/minute")),
                ("mm/s", String(localized: "millimeter/second")),
                ("ft/h", String(localized: "foot/hour")),
                ("ft/min", String(localized: "foot/minute")),
                ("ft/s", String(localized: "foot/second")),
                ("yd/h", String(localized: "yard/hour")),
                ("yd/min", String(localized: "yard/minute")),
                ("yd/s", String(localized: "yard/second")),
                ("mi/min", String(localized: "mile/minute")),
                ("mi/s", String(localized: "mile/second")),
                ("kn", String(localized: "knot")),
                ("kn(UK)", String(localized: "knot (UK)")),
                ("c", String(localized: "Velocity of light in vacuum")),
                ("v1", String(localized: "Cosmic velocity - first")),
                ("v2", String(localized: "Cosmic velocity - second")),
                ("v3", String(localized: "Cosmic velocity - third")),
                ("vE", String(localized: "Earth's velocity")),
                ("vs(w)", String(localized: "Velocity of sound in pure water")),
                ("vs(sw)", String(localized: "Velocity of sound in sea water (20°C, 10 meter deep)")),
                ("M", String(localized: "Mach (20°C, 1 atm)")),
                ("M(SI)", String(localized: "Mach (SI standard)"))
            ]
        case .duration:
            return [
                ("s", String(localized: "second")),
                ("ms", String(localized: "millisecond")),
                ("min", String(localized: "minute")),
                ("h", String(localized: "hour")),
                ("d", String(localized: "day")),
                ("wk", String(localized: "week")),
                ("mo", String(localized: "month")),
                ("yr", String(localized: "year")),
                ("dec", String(localized: "decade")),
                ("cent", String(localized: "century")),
                ("mill", String(localized: "millennium")),
                ("µs", String(localized: "microsecond")),
                ("ns", String(localized: "nanosecond")),
                ("ps", String(localized: "picosecond")),
                ("fs", String(localized: "femtosecond")),
                ("as", String(localized: "attosecond")),
                ("shake", String(localized: "shake")),
                ("mo(syn)", String(localized: "month (synodic)")),
                ("yr(J)", String(localized: "year (Julian)")),
                ("yr(leap)", String(localized: "year (leap)")),
                ("yr(trop)", String(localized: "year (tropical)")),
                ("yr(sid)", String(localized: "year (sidereal)")),
                ("d(sid)", String(localized: "day (sidereal)")),
                ("h(sid)", String(localized: "hour (sidereal)")),
                ("min(sid)", String(localized: "minute (sidereal)")),
                ("s(sid)", String(localized: "second (sidereal)")),
                ("fortnight", String(localized: "fortnight")),
                ("septennial", String(localized: "septennial")),
                ("octennial", String(localized: "octennial")),
                ("novennial", String(localized: "novennial")),
                ("quindecennial", String(localized: "quindecennial")),
                ("quinquennial", String(localized: "quinquennial")),
                ("tP", String(localized: "Planck time"))
            ]
        }
    }
}
