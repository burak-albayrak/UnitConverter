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
            "m": 1,
            "km": 1000,
            "dm": Decimal(string: "0.1")!,
            "cm": Decimal(string: "0.01")!,
            "mm": Decimal(string: "0.001")!,
            "µm": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nm": Decimal(sign: .minus, exponent: 9, significand: 1),
            "mi": Decimal(string: "1609.344")!,
            "yd": Decimal(string: "0.9144")!,
            "ft": Decimal(string: "0.3048")!,
            "in": Decimal(string: "0.0254")!,
            "ly": Decimal(string: "9.46073047258e15")!,
            "Em": Decimal(sign: .plus, exponent: 18, significand: 1),
            "Pm": Decimal(sign: .plus, exponent: 15, significand: 1),
            "Tm": Decimal(sign: .plus, exponent: 12, significand: 1),
            "Gm": Decimal(sign: .plus, exponent: 9, significand: 1),
            "Mm": Decimal(sign: .plus, exponent: 6, significand: 1),
            "hm": 100,
            "dam": 10,
            "µ": Decimal(sign: .minus, exponent: 6, significand: 1),
            "pm": Decimal(sign: .minus, exponent: 12, significand: 1),
            "fm": Decimal(sign: .minus, exponent: 15, significand: 1),
            "am": Decimal(sign: .minus, exponent: 18, significand: 1),
            "Mpc": Decimal(string: "3.08567758128e22")!,
            "kpc": Decimal(string: "3.08567758128e19")!,
            "pc": Decimal(string: "3.08567758128e16")!,
            "au": 149597870691,
            "lea": Decimal(string: "4828.032")!,
            "nlea(UK)": Decimal(string: "5559.552")!,
            "nlea(int)": 5556,
            "lea(st)": Decimal(string: "4828.0416560833")!,
            "nmi(UK)": Decimal(string: "1853.184")!,
            "nmi(int)": 1852,
            "mi(st)": Decimal(string: "1609.3472186944")!,
            "mi(US)": Decimal(string: "1609.3472186944")!,
            "mi(Rom)": Decimal(string: "1479.804")!,
            "kyd": Decimal(string: "914.4")!,
            "fur": Decimal(string: "201.168")!,
            "fur(US)": Decimal(string: "201.1684023368")!,
            "ch": Decimal(string: "20.1168")!,
            "ch(US)": Decimal(string: "20.1168402337")!,
            "rope": Decimal(string: "6.096")!,
            "rod": Decimal(string: "5.0292")!,
            "rod(US)": Decimal(string: "5.0292100584")!,
            "per": Decimal(string: "5.0292")!,
            "pole": Decimal(string: "5.0292")!,
            "fth": Decimal(string: "1.8288")!,
            "fth(US)": Decimal(string: "1.8288036576")!,
            "ell": Decimal(string: "1.143")!,
            "ft(US)": Decimal(string: "0.3048006096")!,
            "link": Decimal(string: "0.201168")!,
            "link(US)": Decimal(string: "0.2011684023")!,
            "cubit(UK)": Decimal(string: "0.4572")!,
            "hand": Decimal(string: "0.1016")!,
            "span": Decimal(string: "0.2286")!,
            "finger": Decimal(string: "0.1143")!,
            "nail": Decimal(string: "0.05715")!,
            "in(US)": Decimal(string: "0.0254000508")!,
            "barleycorn": Decimal(string: "0.0084666667")!,
            "mil": Decimal(string: "2.54e-5")!,
            "µin": Decimal(string: "2.54e-8")!,
            "Å": Decimal(sign: .minus, exponent: 10, significand: 1),
            "au(l)": Decimal(string: "5.2917724900001e-11")!,
            "X": Decimal(string: "1.00208e-13")!,
            "F": Decimal(sign: .minus, exponent: 15, significand: 1),
            "arpent": Decimal(string: "58.5216")!,
            "pica": Decimal(string: "0.0042333333")!,
            "point": Decimal(string: "0.0003527778")!,
            "twip": Decimal(string: "1.76389e-5")!,
            "aln": Decimal(string: "0.5937777778")!,
            "famn": Decimal(string: "1.7813333333")!,
            "cal": Decimal(string: "0.000254")!,
            "cin": Decimal(string: "0.000254")!,
            "ken": Decimal(string: "2.11836")!,
            "archin": Decimal(string: "0.7112")!,
            "actus": Decimal(string: "35.47872")!,
            "vara(t)": Decimal(string: "2.505456")!,
            "vara(c)": Decimal(string: "2.505456")!,
            "vara(cas)": Decimal(string: "0.835152")!,
            "cubit(Gr)": Decimal(string: "0.462788")!,
            "lreed": Decimal(string: "3.2004")!,
            "reed": Decimal(string: "2.7432")!,
            "lcubit": Decimal(string: "0.5334")!,
            "handbreadth": Decimal(string: "0.0762")!,
            "fingerbreadth": Decimal(string: "0.01905")!,
            "lP": Decimal(string: "1.61605e-35")!,
            "re": Decimal(string: "2.81794092e-15")!,
            "a0": Decimal(string: "5.2917724900001e-11")!,
            "RE": 6378160,
            "RP": Decimal(string: "6356776.9999999")!,
            "AU": 149600000000,
            "RS": 696000000
        ]

        guard let fromValue = meterValues[fromUnit], let toValue = meterValues[toUnit] else {
            return value
        }

        let meters = value * fromValue
        return meters / toValue
    }
    
    private func convertMass(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kilogramValues: [String: Decimal] = [
            "kg": 1,
            "g": Decimal(string: "0.001")!,
            "mg": Decimal(sign: .minus, exponent: 6, significand: 1),
            " t": 1000,
            "lb": Decimal(string: "0.45359237")!,
            "oz": Decimal(string: "0.0283495231")!,
            "ct": Decimal(string: "0.0002")!,
            "ton(sh)": Decimal(string: "907.18474")!,
            "ton(l)": Decimal(string: "1016.0469088")!,
            "u": Decimal(string: "1.6605402e-27")!,
            "Eg": Decimal(sign: .plus, exponent: 15, significand: 1),
            "Pg": Decimal(sign: .plus, exponent: 12, significand: 1),
            "Tg": Decimal(sign: .plus, exponent: 9, significand: 1),
            "Gg": Decimal(sign: .plus, exponent: 6, significand: 1),
            "Mg": 1000,
            "hg": Decimal(string: "0.1")!,
            "dag": Decimal(string: "0.01")!,
            "dg": Decimal(string: "0.0001")!,
            "cg": Decimal(sign: .minus, exponent: 5, significand: 1),
            "µg": Decimal(sign: .minus, exponent: 9, significand: 1),
            "ng": Decimal(sign: .minus, exponent: 12, significand: 1),
            "pg": Decimal(sign: .minus, exponent: 15, significand: 1),
            "fg": Decimal(sign: .minus, exponent: 18, significand: 1),
            "ag": Decimal(sign: .minus, exponent: 21, significand: 1),
            "Da": Decimal(string: "1.6605300000013e-27")!,
            "kgf·s²/m": Decimal(string: "9.80665")!,
            "klb": Decimal(string: "453.59237")!,
            "kip": Decimal(string: "453.59237")!,
            "slug": Decimal(string: "14.5939029372")!,
            "lbf·s²/ft": Decimal(string: "14.5939029372")!,
            "lb(t)": Decimal(string: "0.3732417216")!,
            "pdl": Decimal(string: "0.0140867196")!,
            "ton(a,US)": Decimal(string: "0.02916667")!,
            "ton(a,UK)": Decimal(string: "0.0326666667")!,
            "kt": Decimal(sign: .plus, exponent: 6, significand: 1),
            "q": 100,
            "cwt(US)": Decimal(string: "45.359237")!,
            "cwt(UK)": Decimal(string: "50.80234544")!,
            "qr(US)": Decimal(string: "11.33980925")!,
            "qr(UK)": Decimal(string: "12.70058636")!,
            "stone(US)": Decimal(string: "5.669904625")!,
            "stone(UK)": Decimal(string: "6.35029318")!,
            "t": 1000,
            "dwt": Decimal(string: "0.0015551738")!,
            "s(ap)": Decimal(string: "0.0012959782")!,
            "gr": Decimal(string: "6.47989e-5")!,
            "γ": Decimal(sign: .minus, exponent: 9, significand: 1),
            "talent(BH)": Decimal(string: "34.2")!,
            "mina(BH)": Decimal(string: "0.57")!,
            "shekel(BH)": Decimal(string: "0.0114")!,
            "bekan(BH)": Decimal(string: "0.0057")!,
            "gerah(BH)": Decimal(string: "0.00057")!,
            "talent(BG)": Decimal(string: "20.4")!,
            "mina(BG)": Decimal(string: "0.34")!,
            "tetradrachma(BG)": Decimal(string: "0.0136")!,
            "didrachma(BG)": Decimal(string: "0.0068")!,
            "drachma(BG)": Decimal(string: "0.0034")!,
            "denarius(BR)": Decimal(string: "0.00385")!,
            "assarion(BR)": Decimal(string: "0.000240625")!,
            "quadrans(BR)": Decimal(string: "6.01563e-5")!,
            "lepton(BR)": Decimal(string: "3.00781e-5")!,
            "mP": Decimal(string: "2.17671e-8")!,
            "me": Decimal(string: "9.1093897e-31")!,
            "mµ": Decimal(string: "1.8835327e-28")!,
            "mp": Decimal(string: "1.6726231e-27")!,
            "mn": Decimal(string: "1.6749286e-27")!,
            "md": Decimal(string: "3.343586e-27")!,
            "ME": Decimal(string: "5.9760000000002e24")!,
            "MS": Decimal(sign: .plus, exponent: 30, significand: 2)
        ]

        guard let fromValue = kilogramValues[fromUnit], let toValue = kilogramValues[toUnit] else {
            return value
        }

        let kilograms = value * fromValue
        return kilograms / toValue
    }
            
    private func convertVolume(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let cubicMeterValues: [String: Decimal] = [
            "m³": 1,
            "km³": Decimal(sign: .plus, exponent: 9, significand: 1),
            "cm³": Decimal(sign: .minus, exponent: 6, significand: 1),
            "mm³": Decimal(sign: .minus, exponent: 9, significand: 1),
            "L": Decimal(string: "0.001")!,
            "mL": Decimal(sign: .minus, exponent: 6, significand: 1),
            "gal(US)": Decimal(string: "0.0037854118")!,
            "qt(US)": Decimal(string: "0.0009463529")!,
            "pt(US)": Decimal(string: "0.0004731765")!,
            "cup(US)": Decimal(string: "0.0002365882")!,
            "tbsp(US)": Decimal(string: "1.47868e-5")!,
            "tsp(US)": Decimal(string: "4.92892159375e-6")!,
            "mi³": Decimal(string: "4168181825.4406")!,
            "yd³": Decimal(string: "0.764554858")!,
            "ft³": Decimal(string: "0.0283168466")!,
            "in³": Decimal(string: "1.63871e-5")!,
            "dm³": Decimal(string: "0.001")!,
            "EL": Decimal(sign: .plus, exponent: 15, significand: 1),
            "PL": Decimal(sign: .plus, exponent: 12, significand: 1),
            "TL": Decimal(sign: .plus, exponent: 9, significand: 1),
            "GL": Decimal(sign: .plus, exponent: 6, significand: 1),
            "ML": 1000,
            "kL": 1,
            "hL": Decimal(string: "0.1")!,
            "daL": Decimal(string: "0.01")!,
            "dL": Decimal(string: "0.0001")!,
            "cL": Decimal(sign: .minus, exponent: 5, significand: 1),
            "µL": Decimal(sign: .minus, exponent: 9, significand: 1),
            "nL": Decimal(sign: .minus, exponent: 12, significand: 1),
            "pL": Decimal(sign: .minus, exponent: 15, significand: 1),
            "fL": Decimal(sign: .minus, exponent: 18, significand: 1),
            "aL": Decimal(sign: .minus, exponent: 21, significand: 1),
            "cc": Decimal(sign: .minus, exponent: 6, significand: 1),
            "drop": Decimal(sign: .minus, exponent: 8, significand: 5),
            "bbl(oil)": Decimal(string: "0.1589872949")!,
            "bbl(US)": Decimal(string: "0.1192404712")!,
            "bbl(UK)": Decimal(string: "0.16365924")!,
            "gal(UK)": Decimal(string: "0.00454609")!,
            "qt(UK)": Decimal(string: "0.0011365225")!,
            "pt(UK)": Decimal(string: "0.0005682613")!,
            "cup(m)": Decimal(string: "0.00025")!,
            "cup(UK)": Decimal(string: "0.0002841306")!,
            "fl oz(US)": Decimal(string: "2.95735e-5")!,
            "fl oz(UK)": Decimal(string: "2.84131e-5")!,
            "tbsp(m)": Decimal(string: "1.5e-5")!,
            "tbsp(UK)": Decimal(string: "1.77582e-5")!,
            "dsp(US)": Decimal(string: "9.8578431875e-6")!,
            "dsp(UK)": Decimal(string: "1.18388e-5")!,
            "tsp(m)": Decimal(string: "5e-6")!,
            "tsp(UK)": Decimal(string: "5.9193880208333e-6")!,
            "gill(US)": Decimal(string: "0.0001182941")!,
            "gill(UK)": Decimal(string: "0.0001420653")!,
            "min(US)": Decimal(string: "6.1611519921875e-8")!,
            "min(UK)": Decimal(string: "5.9193880208333e-8")!,
            "reg ton": Decimal(string: "2.8316846592")!,
            "ccf": Decimal(string: "2.8316846592")!,
            "hcf": Decimal(string: "2.8316846592")!,
            "ac·ft": Decimal(string: "1233.4818375475")!,
            "ac·ft(US)": Decimal(string: "1233.4892384682")!,
            "ac·in": Decimal(string: "102.790153129")!,
            "das": 10,
            "s": 1,
            "ds": Decimal(string: "0.1")!,
            "cord": Decimal(string: "3.6245563638")!,
            "tun": Decimal(string: "0.9539237696")!,
            "hhd": Decimal(string: "0.2384809424")!,
            "bf": Decimal(string: "0.0023597372")!,
            "dr": Decimal(string: "3.6966911953125e-6")!,
            "cor(B)": Decimal(string: "0.22")!,
            "homer(B)": Decimal(string: "0.22")!,
            "bath(B)": Decimal(string: "0.022")!,
            "hin(B)": Decimal(string: "0.0036666667")!,
            "cab(B)": Decimal(string: "0.0012222222")!,
            "log(B)": Decimal(string: "0.0003055556")!,
            "taza": Decimal(string: "0.0002365882")!,
            "VE": Decimal(string: "1.083e21")!
        ]
        
        guard let fromValue = cubicMeterValues[fromUnit], let toValue = cubicMeterValues[toUnit] else {
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
            "m²": 1,
            "km²": Decimal(sign: .plus, exponent: 6, significand: 1),
            "cm²": Decimal(sign: .minus, exponent: 4, significand: 1),
            "mm²": Decimal(sign: .minus, exponent: 6, significand: 1),
            "µm²": Decimal(sign: .minus, exponent: 12, significand: 1),
            "ha": Decimal(sign: .plus, exponent: 4, significand: 1),
            "ac": Decimal(string: "4046.8564224")!,
            "mi²": Decimal(string: "2589988.110336")!,
            "yd²": Decimal(string: "0.83612736")!,
            "ft²": Decimal(string: "0.09290304")!,
            "in²": Decimal(string: "0.00064516")!,
            "hm²": Decimal(sign: .plus, exponent: 4, significand: 1),
            "dam²": 100,
            "dm²": Decimal(string: "0.01")!,
            "nm²": Decimal(sign: .minus, exponent: 18, significand: 1),
            "a": 100,
            "b": Decimal(sign: .minus, exponent: 28, significand: 1),
            "mi²(US)": Decimal(string: "2589998.4703195")!,
            "ft²(US)": Decimal(string: "0.0929034116")!,
            "cir in": Decimal(string: "0.0005067075")!,
            "twp": Decimal(string: "93239571.972096")!,
            "sec": Decimal(string: "2589988.110336")!,
            "ac(US)": Decimal(string: "4046.8726098743")!,
            "rood": Decimal(string: "1011.7141056")!,
            "ch²": Decimal(string: "404.68564224")!,
            "rod²": Decimal(string: "25.29285264")!,
            "rod²(US)": Decimal(string: "25.2929538117")!,
            "per²": Decimal(string: "25.29285264")!,
            "pole²": Decimal(string: "25.29285264")!,
            "mil²": Decimal(string: "6.4516e-10")!,
            "cir mil": Decimal(string: "5.067074790975e-10")!,
            "homestead": Decimal(string: "647497.027584")!,
            "sabin": Decimal(string: "0.09290304")!,
            "arpent": Decimal(string: "3418.8929236669")!,
            "cuerda": Decimal(string: "3930.395625")!,
            "plaza": 6400,
            "var²(cas)": Decimal(string: "0.698737")!,
            "var²(con)": Decimal(string: "6.288633")!,
            "σe": Decimal(string: "6.6524615999999e-29")!
        ]

        guard let fromValue = squareMeterValues[fromUnit], let toValue = squareMeterValues[toUnit] else {
            return value
        }

        let squareMeters = value * fromValue
        return squareMeters / toValue
    }
            
    private func convertPressure(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let pascalValues: [String: Decimal] = [
            "Pa": 1,
            "kPa": 1000,
            "bar": 100000,
            "psi": Decimal(string: "6894.7572931783")!,
            "ksi": Decimal(string: "6894757.2931783")!,
            "atm": 101325,
            "EPa": Decimal(sign: .plus, exponent: 18, significand: 1),
            "PPa": Decimal(sign: .plus, exponent: 15, significand: 1),
            "TPa": Decimal(sign: .plus, exponent: 12, significand: 1),
            "GPa": Decimal(sign: .plus, exponent: 9, significand: 1),
            "MPa": Decimal(sign: .plus, exponent: 6, significand: 1),
            "hPa": 100,
            "daPa": 10,
            "dPa": Decimal(string: "0.1")!,
            "cPa": Decimal(string: "0.01")!,
            "mPa": Decimal(string: "0.001")!,
            "µPa": Decimal(sign: .minus, exponent: 6, significand: 1),
            "nPa": Decimal(sign: .minus, exponent: 9, significand: 1),
            "pPa": Decimal(sign: .minus, exponent: 12, significand: 1),
            "fPa": Decimal(sign: .minus, exponent: 15, significand: 1),
            "aPa": Decimal(sign: .minus, exponent: 18, significand: 1),
            "N/m²": 1,
            "N/cm²": 10000,
            "N/mm²": 1000000,
            "kN/m²": 1000,
            "mbar": 100,
            "µbar": Decimal(string: "0.1")!,
            "dyn/cm²": Decimal(string: "0.1")!,
            "kgf/m²": Decimal(string: "9.80665")!,
            "kgf/cm²": Decimal(string: "98066.5")!,
            "kgf/mm²": 9806650,
            "gf/cm²": Decimal(string: "98.0665")!,
            "tonf(sh)/ft²": Decimal(string: "95760.517960678")!,
            "tonf(sh)/in²": Decimal(string: "13789514.586338")!,
            "tonf(l)/ft²": Decimal(string: "107251.78011595")!,
            "tonf(l)/in²": Decimal(string: "15444256.336697")!,
            "kipf/in²": Decimal(string: "6894757.2931783")!,
            "lbf/ft²": Decimal(string: "47.8802589804")!,
            "lbf/in²": Decimal(string: "6894.7572931783")!,
            "pdl/ft²": Decimal(string: "1.4881639436")!,
            "Torr": Decimal(string: "133.3223684211")!,
            "cmHg": Decimal(string: "1333.22")!,
            "mmHg": Decimal(string: "133.322")!,
            "inHg": Decimal(string: "3386.38")!,
            "inHg(60°F)": Decimal(string: "3376.85")!,
            "cmH2O": Decimal(string: "98.0638")!,
            "mmH2O": Decimal(string: "9.80638")!,
            "inH2O": Decimal(string: "249.082")!,
            "ftH2O": Decimal(string: "2988.98")!,
            "inH2O(60°F)": Decimal(string: "248.843")!,
            "ftH2O(60°F)": Decimal(string: "2986.116")!,
            "at": Decimal(string: "98066.500000003")!
        ]

        guard let fromValue = pascalValues[fromUnit], let toValue = pascalValues[toUnit] else {
            return value
        }

        let pascals = value * fromValue
        return pascals / toValue
    }
            
    private func convertAngle(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let degreeValues: [String: Decimal] = [
            "°": 1,
            "rad": Decimal(string: "57.2957795131")!,
            "grad": Decimal(string: "0.9")!,
            "'": Decimal(1) / 60,
            "\"": Decimal(1) / 3600,
            "gon": Decimal(string: "0.9")!,
            "sign": 30,
            "mil": Decimal(string: "0.05625")!,
            "rev": 360,
            "⊙": 360,
            "tr": 360,
            "quad": 90,
            "right angle": 90,
            "sextant": 60
        ]

        guard let fromValue = degreeValues[fromUnit], let toValue = degreeValues[toUnit] else {
            return value
        }

        let degrees = value * fromValue
        return degrees / toValue
    }
    
    private func convertSpeed(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let meterPerSecondValues: [String: Decimal] = [
            "m/s": 1,
            "km/h": Decimal(string: "0.2777777778")!,
            "mi/h": Decimal(string: "0.44704")!,
            "m/h": Decimal(string: "0.0002777778")!,
            "m/min": Decimal(string: "0.0166666667")!,
            "km/min": Decimal(string: "16.6666666667")!,
            "km/s": 1000,
            "cm/h": Decimal(string: "2.7777777777778E-6")!,
            "cm/min": Decimal(string: "0.0001666667")!,
            "cm/s": Decimal(string: "0.01")!,
            "mm/h": Decimal(string: "2.7777777777778E-7")!,
            "mm/min": Decimal(string: "1.66667E-5")!,
            "mm/s": Decimal(string: "0.001")!,
            "ft/h": Decimal(string: "8.46667E-5")!,
            "ft/min": Decimal(string: "0.00508")!,
            "ft/s": Decimal(string: "0.3048")!,
            "yd/h": Decimal(string: "0.000254")!,
            "yd/min": Decimal(string: "0.01524")!,
            "yd/s": Decimal(string: "0.9144")!,
            "mi/min": Decimal(string: "26.8224")!,
            "mi/s": Decimal(string: "1609.344")!,
            "kn": Decimal(string: "0.5144444444")!,
            "kn(UK)": Decimal(string: "0.5147733333")!,
            "c": 299792458,
            "v1": Decimal(string: "7899.9999999999")!,
            "v2": 11200,
            "v3": 16670,
            "vE": 29765,
            "vs(w)": Decimal(string: "1482.6999999998")!,
            "vs(sw)": Decimal(string: "1521.6")!,
            "M": Decimal(string: "343.6")!,
            "M(SI)": Decimal(string: "295.0464000003")!
        ]
        
        guard let fromValue = meterPerSecondValues[fromUnit], let toValue = meterPerSecondValues[toUnit] else {
            return value
        }

        let meterPerSecond = value * fromValue
        return meterPerSecond / toValue
    }
        
    private func convertDuration(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let secondValues: [String: Decimal] = [
            "s": 1,
            "ms": Decimal(string: "0.001")!,
            "min": 60,
            "h": 3600,
            "d": 86400,
            "wk": 604800,
            "mo": 2628000,
            "yr": 31557600,
            "dec": 315576000,
            "cent": 3155760000,
            "mill": 31557600000,
            "µs": Decimal(sign: .minus, exponent: 6, significand: 1),
            "ns": Decimal(sign: .minus, exponent: 9, significand: 1),
            "ps": Decimal(sign: .minus, exponent: 12, significand: 1),
            "fs": Decimal(sign: .minus, exponent: 15, significand: 1),
            "as": Decimal(sign: .minus, exponent: 18, significand: 1),
            "shake": Decimal(sign: .minus, exponent: 8, significand: 1),
            "mo(syn)": Decimal(string: "2551443.84")!,
            "yr(J)": 31557600,
            "yr(leap)": 31622400,
            "yr(trop)": 31556930,
            "yr(sid)": Decimal(string: "31558149.54")!,
            "d(sid)": Decimal(string: "86164.09")!,
            "h(sid)": Decimal(string: "3590.1704166667")!,
            "min(sid)": Decimal(string: "59.8361736111")!,
            "s(sid)": Decimal(string: "0.9972695602")!,
            "fortnight": 1209600,
            "septennial": 220752000,
            "octennial": 252288000,
            "novennial": 283824000,
            "quindecennial": 473040000,
            "quinquennial": 157680000,
            "tP": Decimal(string: "5.39056e-44")!
        ]
        
        guard let fromValue = secondValues[fromUnit], let toValue = secondValues[toUnit] else {
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
                (" t", String(localized: "ton (metric)")),
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
                // FIXME: sextant eksik
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
