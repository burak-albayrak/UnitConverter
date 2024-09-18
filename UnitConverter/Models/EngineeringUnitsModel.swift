//
//  EngineeringUnitsModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import Foundation
import SwiftUI

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
    
    private func convertLength(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let meterValues: [String: Decimal] = [
            "m": 1,
            "km": 1000,
            "dm": Decimal(string: "0.1")!,
            "cm": Decimal(string: "0.01")!,
            "mm": Decimal(string: "0.001")!,
            "µm": Decimal(sign: .plus, exponent: -6, significand: 1),
            "nm": Decimal(sign: .plus, exponent: -9, significand: 1),
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
            "µ": Decimal(sign: .plus, exponent: -6, significand: 1),
            "pm": Decimal(sign: .plus, exponent: -12, significand: 1),
            "fm": Decimal(sign: .plus, exponent: -15, significand: 1),
            "am": Decimal(sign: .plus, exponent: -18, significand: 1),
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
            "Å": Decimal(sign: .plus, exponent: -10, significand: 1),
            "au(l)": Decimal(string: "5.2917724900001e-11")!,
            "X": Decimal(string: "1.00208e-13")!,
            "F": Decimal(sign: .plus, exponent: -15, significand: 1),
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
            "mg": Decimal(sign: .plus, exponent: -6, significand: 1),
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
            "cg": Decimal(sign: .plus, exponent: -5, significand: 1),
            "µg": Decimal(sign: .plus, exponent: -9, significand: 1),
            "ng": Decimal(sign: .plus, exponent: -12, significand: 1),
            "pg": Decimal(sign: .plus, exponent: -15, significand: 1),
            "fg": Decimal(sign: .plus, exponent: -18, significand: 1),
            "ag": Decimal(sign: .plus, exponent: -21, significand: 1),
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
            "γ": Decimal(sign: .plus, exponent: -9, significand: 1),
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
            "cm³": Decimal(sign: .plus, exponent: -6, significand: 1),
            "mm³": Decimal(sign: .plus, exponent: -9, significand: 1),
            "L": Decimal(string: "0.001")!,
            "mL": Decimal(sign: .plus, exponent: -6, significand: 1),
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
            "cL": Decimal(sign: .plus, exponent: -5, significand: 1),
            "µL": Decimal(sign: .plus, exponent: -9, significand: 1),
            "nL": Decimal(sign: .plus, exponent: -12, significand: 1),
            "pL": Decimal(sign: .plus, exponent: -15, significand: 1),
            "fL": Decimal(sign: .plus, exponent: -18, significand: 1),
            "aL": Decimal(sign: .plus, exponent: -21, significand: 1),
            "cc": Decimal(sign: .plus, exponent: -6, significand: 1),
            "drop": Decimal(sign: .plus, exponent: -8, significand: 5),
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
        case "reaumur", "°re", "°ré":
            kelvin = value * 5/4 + Decimal(273.15)
        case "triple point of water", "tw":
            kelvin = value * Decimal(273.16)
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
        case "reaumur", "°re", "°ré":
            return (kelvin - Decimal(273.15)) * 4/5
        case "triple point of water", "tw":
            return kelvin / Decimal(273.16)
        default:
            return value
        }
    }
    
    private func convertArea(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let squareMeterValues: [String: Decimal] = [
            "m²": 1,
            "km²": Decimal(sign: .plus, exponent: 6, significand: 1),
            "cm²": Decimal(sign: .plus, exponent: -4, significand: 1),
            "mm²": Decimal(sign: .plus, exponent: -6, significand: 1),
            "µm²": Decimal(sign: .plus, exponent: -12, significand: 1),
            "ha": Decimal(sign: .plus, exponent: 4, significand: 1),
            "ac": Decimal(string: "4046.8564224")!,
            "mi²": Decimal(string: "2589988.110336")!,
            "yd²": Decimal(string: "0.83612736")!,
            "ft²": Decimal(string: "0.09290304")!,
            "in²": Decimal(string: "0.00064516")!,
            "hm²": Decimal(sign: .plus, exponent: 4, significand: 1),
            "dam²": 100,
            "dm²": Decimal(string: "0.01")!,
            "nm²": Decimal(sign: .plus, exponent: -18, significand: 1),
            "a": 100,
            "b": Decimal(sign: .plus, exponent: -28, significand: 1),
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
            "µPa": Decimal(sign: .plus, exponent: -6, significand: 1),
            "nPa": Decimal(sign: .plus, exponent: -9, significand: 1),
            "pPa": Decimal(sign: .plus, exponent: -12, significand: 1),
            "fPa": Decimal(sign: .plus, exponent: -15, significand: 1),
            "aPa": Decimal(sign: .plus, exponent: -18, significand: 1),
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
            "µs": Decimal(sign: .plus, exponent: -6, significand: 1),
            "ns": Decimal(sign: .plus, exponent: -9, significand: 1),
            "ps": Decimal(sign: .plus, exponent: -12, significand: 1),
            "fs": Decimal(sign: .plus, exponent: -15, significand: 1),
            "as": Decimal(sign: .plus, exponent: -18, significand: 1),
            "shake": Decimal(sign: .plus, exponent: -8, significand: 1),
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
    
    private func convertEnergy(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let jouleValues: [String: Decimal] = [
            "J": 1,
            "kJ": 1000,
            "kWh": 3600000,
            "Wh": 3600,
            "Cal": Decimal(string: "4186.8")!,
            " hp·h": Decimal(string: "2647795.5")!,
            "Btu(IT)": Decimal(string: "1055.05585262")!,
            "Btu(th)": Decimal(string: "1054.3499999744")!,
            "GJ": Decimal(sign: .plus, exponent: 9, significand: 1),
            "MJ": Decimal(sign: .plus, exponent: 6, significand: 1),
            "mJ": Decimal(string: "0.001")!,
            "µJ": Decimal(sign: .plus, exponent: -6, significand: 1),
            "nJ": Decimal(sign: .plus, exponent: -9, significand: 1),
            "aJ": Decimal(sign: .plus, exponent: -18, significand: 1),
            "MeV": Decimal(string: "1.6021766339999e-13")!,
            "keV": Decimal(string: "1.6021766339999e-16")!,
            "eV": Decimal(string: "1.6021766339999e-19")!,
            "erg": Decimal(sign: .plus, exponent: -7, significand: 1),
            "GWh": Decimal(string: "3.6e12")!,
            "MWh": Decimal(string: "3.6e9")!,
            "kW·s": 1000,
            "W·s": 1,
            "N·m": 1,
            "hp·h": Decimal(string: "2684519.5368856")!,
            "kcal(IT)": Decimal(string: "4186.8")!,
            "kcal(th)": 4184,
            "cal(IT)": Decimal(string: "4.1868")!,
            "cal(th)": Decimal(string: "4.184")!,
            "MBtu(IT)": Decimal(string: "1055055852.62")!,
            "ton·h": Decimal(string: "12660670.23144")!,
            "FOE(kL)": Decimal(string: "40197627984.822")!,
            "FOE(bbl)": Decimal(string: "6383087908.3509")!,
            "Gt": Decimal(string: "4.184e18")!,
            "Mt": Decimal(string: "4.184e15")!,
            "kt": Decimal(string: "4.184e12")!,
            "t(TNT)": Decimal(string: "4.184e9")!,
            "dyn·cm": Decimal(sign: .plus, exponent: -7, significand: 1),
            "gf·m": Decimal(string: "0.00980665")!,
            "gf·cm": Decimal(string: "9.80665e-5")!,
            "kgf·cm": Decimal(string: "0.0980665")!,
            "kgf·m": Decimal(string: "9.8066499997")!,
            "kp·m": Decimal(string: "9.8066499997")!,
            "lbf·ft": Decimal(string: "1.3558179483")!,
            "lbf·in": Decimal(string: "0.112984829")!,
            "ozf·in": Decimal(string: "0.0070615518")!,
            "ft·lb": Decimal(string: "1.3558179483")!,
            "in·lb": Decimal(string: "0.112984829")!,
            "in·oz": Decimal(string: "0.0070615518")!,
            "pdl·ft": Decimal(string: "0.04214011")!,
            "th": 105505600,
            "th(EC)": 105505600,
            "th(US)": 105480400,
            "Eh": Decimal(string: "4.3597482e-18")!,
            "Ry": Decimal(string: "2.1798741e-18")!
        ]
        
        guard let fromValue = jouleValues[fromUnit], let toValue = jouleValues[toUnit] else {
            return value
        }
        
        let joules = value * fromValue
        return joules / toValue
    }
    
    private func convertPower(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let wattValues: [String: Decimal] = [
            "W": 1,
            "EW": Decimal(sign: .plus, exponent: 18, significand: 1),
            "PW": Decimal(sign: .plus, exponent: 15, significand: 1),
            "TW": Decimal(sign: .plus, exponent: 12, significand: 1),
            "GW": Decimal(sign: .plus, exponent: 9, significand: 1),
            "MW": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kW": Decimal(sign: .plus, exponent: 3, significand: 1),
            "hW": Decimal(sign: .plus, exponent: 2, significand: 1),
            "daW": Decimal(sign: .plus, exponent: 1, significand: 1),
            "dW": Decimal(sign: .plus, exponent: -1, significand: 1),
            "cW": Decimal(sign: .plus, exponent: -2, significand: 1),
            "mW": Decimal(sign: .plus, exponent: -3, significand: 1),
            "µW": Decimal(sign: .plus, exponent: -6, significand: 1),
            "nW": Decimal(sign: .plus, exponent: -9, significand: 1),
            "pW": Decimal(sign: .plus, exponent: -12, significand: 1),
            "fW": Decimal(sign: .plus, exponent: -15, significand: 1),
            "aW": Decimal(sign: .plus, exponent: -18, significand: 1),
            "hp": Decimal(string: "745.6998715823")!,
            "hp(550)": Decimal(string: "745.6998715823")!,
            "hp(m)": Decimal(string: "735.49875")!,
            "hp(b)": Decimal(string: "9809.5000000002")!,
            "hp(e)": 746,
            "hp(w)": Decimal(string: "746.043")!,
            "PS": Decimal(string: "735.49875")!,
            "Btu(IT)/h": Decimal(string: "0.2930710702")!,
            "Btu(IT)/min": Decimal(string: "17.5842642103")!,
            "Btu(IT)/s": Decimal(string: "1055.05585262")!,
            "Btu(th)/h": Decimal(string: "0.292875")!,
            "Btu(th)/min": Decimal(string: "17.5724999996")!,
            "Btu(th)/s": Decimal(string: "1054.3499999744")!,
            "MBtu(IT)/h": Decimal(string: "293071.07017222")!,
            "MBH": Decimal(string: "293.0710701722")!,
            "ton(ref)": Decimal(string: "3516.8528420667")!,
            "kcal(IT)/h": Decimal(string: "1.163")!,
            "kcal(IT)/min": Decimal(string: "69.78")!,
            "kcal(IT)/s": Decimal(string: "4186.8")!,
            "kcal(th)/h": Decimal(string: "1.1622222222")!,
            "kcal(th)/min": Decimal(string: "69.7333333333")!,
            "kcal(th)/s": 4184,
            "cal(IT)/h": Decimal(string: "0.001163")!,
            "cal(IT)/min": Decimal(string: "0.06978")!,
            "cal(IT)/s": Decimal(string: "4.1868")!,
            "cal(th)/h": Decimal(string: "0.0011622222")!,
            "cal(th)/min": Decimal(string: "0.0697333333")!,
            "cal(th)/s": Decimal(string: "4.184")!,
            "ft·lbf/h": Decimal(string: "0.0003766161")!,
            "ft·lbf/min": Decimal(string: "0.0225969658")!,
            "ft·lbf/s": Decimal(string: "1.3558179483")!,
            "lb·ft/h": Decimal(string: "0.0003766161")!,
            "lb·ft/min": Decimal(string: "0.0225969658")!,
            "lb·ft/s": Decimal(string: "1.3558179483")!,
            "erg/s": Decimal(sign: .plus, exponent: -7, significand: 1),
            "kVA": 1000,
            "VA": 1,
            "N·m/s": 1,
            "J/s": 1,
            "EJ/s": Decimal(sign: .plus, exponent: 18, significand: 1),
            "PJ/s": Decimal(sign: .plus, exponent: 15, significand: 1),
            "TJ/s": Decimal(sign: .plus, exponent: 12, significand: 1),
            "GJ/s": Decimal(sign: .plus, exponent: 9, significand: 1),
            "MJ/s": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kJ/s": Decimal(sign: .plus, exponent: 3, significand: 1),
            "hJ/s": Decimal(sign: .plus, exponent: 2, significand: 1),
            "daJ/s": Decimal(sign: .plus, exponent: 1, significand: 1),
            "dJ/s": Decimal(sign: .plus, exponent: -1, significand: 1),
            "cJ/s": Decimal(sign: .plus, exponent: -2, significand: 1),
            "mJ/s": Decimal(sign: .plus, exponent: -3, significand: 1),
            "µJ/s": Decimal(sign: .plus, exponent: -6, significand: 1),
            "nJ/s": Decimal(sign: .plus, exponent: -9, significand: 1),
            "pJ/s": Decimal(sign: .plus, exponent: -12, significand: 1),
            "fJ/s": Decimal(sign: .plus, exponent: -15, significand: 1),
            "aJ/s": Decimal(sign: .plus, exponent: -18, significand: 1),
            "J/h": Decimal(string: "0.0002777778")!,
            "J/min": Decimal(string: "0.0166666667")!,
            "kJ/h": Decimal(string: "0.2777777778")!,
            "kJ/min": Decimal(string: "16.6666666667")!
        ]
        
        guard let fromValue = wattValues[fromUnit], let toValue = wattValues[toUnit] else {
            return value
        }
        
        let watts = value * fromValue
        return watts / toValue
    }
    
    private func convertForce(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let newtonValues: [String: Decimal] = [
            "N": 1,
            "kN": 1000,
            "gf": Decimal(string: "0.00980665")!,
            "kgf": Decimal(string: "9.80665")!,
            "tf": Decimal(string: "9806.65")!,
            "EN": Decimal(sign: .plus, exponent: 18, significand: 1),
            "PN": Decimal(sign: .plus, exponent: 15, significand: 1),
            "TN": Decimal(sign: .plus, exponent: 12, significand: 1),
            "GN": Decimal(sign: .plus, exponent: 9, significand: 1),
            "MN": Decimal(sign: .plus, exponent: 6, significand: 1),
            "hN": 100,
            "daN": 10,
            "dN": Decimal(string: "0.1")!,
            "cN": Decimal(string: "0.01")!,
            "mN": Decimal(string: "0.001")!,
            "µN": Decimal(sign: .plus, exponent: -6, significand: 1),
            "nN": Decimal(sign: .plus, exponent: -9, significand: 1),
            "pN": Decimal(sign: .plus, exponent: -12, significand: 1),
            "fN": Decimal(sign: .plus, exponent: -15, significand: 1),
            "aN": Decimal(sign: .plus, exponent: -18, significand: 1),
            "dyn": Decimal(sign: .plus, exponent: -5, significand: 1),
            "J/m": 1,
            "J/cm": Decimal(string: "0.01")!,
            "tf(sh)": Decimal(string: "8896.443230521")!,
            "tf(l)": Decimal(string: "9964.0164181707")!,
            "kipf": Decimal(string: "4448.2216152548")!,
            "klbf": Decimal(string: "4448.2216152548")!,
            "lbf": Decimal(string: "4.4482216153")!,
            "ozf": Decimal(string: "0.278013851")!,
            "pdl": Decimal(string: "0.1382549544")!,
            "lb·ft/s²": Decimal(string: "0.1382549544")!,
            "p": Decimal(string: "0.00980665")!,
            "kp": Decimal(string: "9.80665")!
        ]
        
        guard let fromValue = newtonValues[fromUnit], let toValue = newtonValues[toUnit] else {
            return value
        }
        
        let newtons = value * fromValue
        return newtons / toValue
    }
    
    private func convertFuelConsumption(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let meterPerLiterValues: [String: Decimal] = [
            "m/L": 1,
            "Em/L": Decimal(sign: .plus, exponent: 18, significand: 1),
            "Pm/L": Decimal(sign: .plus, exponent: 15, significand: 1),
            "Tm/L": Decimal(sign: .plus, exponent: 12, significand: 1),
            "Gm/L": Decimal(sign: .plus, exponent: 9, significand: 1),
            "Mm/L": Decimal(sign: .plus, exponent: 6, significand: 1),
            "km/L": 1000,
            "hm/L": 100,
            "dam/L": 10,
            "cm/L": Decimal(string: "0.01")!,
            "mi(US)/L": Decimal(string: "1609.344")!,
            "nmi/L": Decimal(string: "1853.24496")!,
            "nmi/gal(US)": Decimal(string: "489.5755247")!,
            "km/gal(US)": Decimal(string: "264.1720524")!,
            "m/gal(US)": Decimal(string: "0.2641720524")!,
            "m/gal(UK)": Decimal(string: "0.2199687986")!,
            "mi/gal(US)": Decimal(string: "425.1437075")!,
            "mi/gal(UK)": Decimal(string: "354.00619")!,
            "m/m³": Decimal(string: "0.001")!,
            "m/cm³": 1000,
            "m/yd³": Decimal(string: "0.0013079506")!,
            "m/ft³": Decimal(string: "0.0353146667")!,
            "m/in³": Decimal(string: "61.02374409")!,
            "m/qt(US)": Decimal(string: "1.056688209")!,
            "m/qt(UK)": Decimal(string: "0.8798751948")!,
            "m/pt(US)": Decimal(string: "2.113376419")!,
            "m/pt(UK)": Decimal(string: "1.759750389")!,
            "m/cup(US)": Decimal(string: "4.226752838")!,
            "m/cup(UK)": Decimal(string: "3.519500777")!,
            "m/fl oz(US)": Decimal(string: "33.8140227")!,
            "m/fl oz(UK)": Decimal(string: "35.19500777")!,
            "L/m": 1,
            "L/100km": 100000,
            "gal(US)/mi": Decimal(string: "425.1437074976")!,
            "gal(US)/100mi": Decimal(string: "42514.370749763")!,
            "gal(UK)/mi": Decimal(string: "354.0061899559")!,
            "gal(UK)/100mi": Decimal(string: "35400.618995592")!
        ]
        
        func convertToStandard(_ val: Decimal, unit: String) -> Decimal {
            switch unit {
            case "L/100km", "gal(US)/100mi", "gal(UK)/100mi", "gal(US)/mi", "gal(UK)/mi":
                return meterPerLiterValues[unit]! / val
            case "L/m":
                return 1 / val
            default:
                return val * (meterPerLiterValues[unit] ?? 1)
            }
        }
        
        func convertFromStandard(_ val: Decimal, unit: String) -> Decimal {
            switch unit {
            case "L/100km", "gal(US)/100mi", "gal(UK)/100mi", "gal(US)/mi", "gal(UK)/mi":
                return meterPerLiterValues[unit]! / val
            case "L/m":
                return 1 / val
            default:
                return val / (meterPerLiterValues[unit] ?? 1)
            }
        }
        
        let standardValue = convertToStandard(value, unit: fromUnit)
        return convertFromStandard(standardValue, unit: toUnit)
    }
    
    private func convertVolumeDry(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let literValues: [String: Decimal] = [
            "L": 1,
            "bbl(d,US)": Decimal(string: "115.6271236039")!,
            "pt(d,US)": Decimal(string: "0.5506104714")!,
            "qt(d,US)": Decimal(string: "1.1012209428")!,
            "pk(US)": Decimal(string: "8.8097675424")!,
            "pk(UK)": Decimal(string: "9.09218")!,
            "bu(US)": Decimal(string: "35.2390701696")!,
            "bu(UK)": Decimal(string: "36.36872")!,
            "cor(B)": Decimal(string: "219.9999892918")!,
            "homer(B)": Decimal(string: "219.9999892918")!,
            "ephah(B)": Decimal(string: "21.9999989292")!,
            "seah(B)": Decimal(string: "7.3333329764")!,
            "omer(B)": Decimal(string: "2.1999998929")!,
            "cab(B)": Decimal(string: "1.2222221627")!,
            "log(B)": Decimal(string: "0.3055555407")!
        ]
        
        guard let fromValue = literValues[fromUnit], let toValue = literValues[toUnit] else {
            return value
        }
        
        let liters = value * fromValue
        return liters / toValue
    }
    
    private func convertAngularVelocity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let radianPerSecondValues: [String: Decimal] = [
            "rad/s": 1,
            "rad/d": Decimal(string: "1.15741E-5")!,
            "rad/h": Decimal(string: "0.0002777778")!,
            "rad/min": Decimal(string: "0.0166666667")!,
            "°/d": Decimal(string: "2.0200570046231E-7")!,
            "°/h": Decimal(string: "4.8481368110954E-6")!,
            "°/min": Decimal(string: "0.0002908882")!,
            "°/s": Decimal(string: "0.0174532925")!,
            "rev/d": Decimal(string: "7.27221E-5")!,
            "rev/h": Decimal(string: "0.0017453293")!,
            "rev/min": Decimal(string: "0.1047197551")!,
            "rev/s": Decimal(string: "6.2831853072")!
        ]
        
        guard let fromValue = radianPerSecondValues[fromUnit], let toValue = radianPerSecondValues[toUnit] else {
            return value
        }
        
        let radianPerSecond = value * fromValue
        return radianPerSecond / toValue
    }
    
    private func convertAcceleration(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let meterPerSquareSecondValues: [String: Decimal] = [
            "m/s²": 1,
            "dm/s²": Decimal(string: "0.1")!,
            "km/s²": 1000,
            "hm/s²": 100,
            "dam/s²": 10,
            "cm/s²": Decimal(string: "0.01")!,
            "mm/s²": Decimal(string: "0.001")!,
            "µm/s²": Decimal(sign: .plus, exponent: -6, significand: 1),
            "nm/s²": Decimal(sign: .plus, exponent: -9, significand: 1),
            "pm/s²": Decimal(sign: .plus, exponent: -12, significand: 1),
            "fm/s²": Decimal(sign: .plus, exponent: -15, significand: 1),
            "am/s²": Decimal(sign: .plus, exponent: -18, significand: 1),
            "Gal": Decimal(string: "0.01")!,
            " Gal": Decimal(string: "0.01")!, // FIXME: ÜSTTEKİYLE AYNI
            "mi/s²": Decimal(string: "1609.344")!,
            "yd/s²": Decimal(string: "0.9144")!,
            "ft/s²": Decimal(string: "0.3048")!,
            "in/s²": Decimal(string: "0.0254")!,
            "g": Decimal(string: "9.80665")!
        ]
        
        guard let fromValue = meterPerSquareSecondValues[fromUnit], let toValue = meterPerSquareSecondValues[toUnit] else {
            return value
        }
        
        let meterPerSquareSecond = value * fromValue
        return meterPerSquareSecond / toValue
    }
    
    private func convertAngularAcceleration(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let radianPerSquareSecondValues: [String: Decimal] = [
            "rad/s²": 1,
            "rad/min²": Decimal(string: "0.0002777778")!,
            "rev/s²": Decimal(string: "6.2831853069")!,
            "rev/min/s": Decimal(string: "0.1047197551")!,
            "rev/min²": Decimal(string: "0.0017453293")!
        ]
        
        guard let fromValue = radianPerSquareSecondValues[fromUnit], let toValue = radianPerSquareSecondValues[toUnit] else {
            return value
        }
        
        let radianPerSquareSecond = value * fromValue
        return radianPerSquareSecond / toValue
    }
    
    private func convertDensity(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kilogramPerCubicMeterValues: [String: Decimal] = [
            "kg/m³": 1,
            "g/cm³": 1000,
            "kg/cm³": 1000000,
            "g/m³": Decimal(string: "0.001")!,
            "g/mm³": 1000000,
            "mg/m³": Decimal(sign: .plus, exponent: -6, significand: 1),
            "mg/cm³": 1,
            "mg/mm³": 1000,
            "Eg/L": Decimal(sign: .plus, exponent: 18, significand: 1),
            "Pg/L": Decimal(sign: .plus, exponent: 15, significand: 1),
            "Tg/L": Decimal(sign: .plus, exponent: 12, significand: 1),
            "Gg/L": Decimal(sign: .plus, exponent: 9, significand: 1),
            "Mg/L": Decimal(sign: .plus, exponent: 6, significand: 1),
            "kg/L": 1000,
            "hg/L": 100,
            "dag/L": 10,
            "g/L": 1,
            "dg/L": Decimal(string: "0.1")!,
            "cg/L": Decimal(string: "0.01")!,
            "mg/L": Decimal(string: "0.001")!,
            "µg/L": Decimal(sign: .plus, exponent: -6, significand: 1),
            "ng/L": Decimal(sign: .plus, exponent: -9, significand: 1),
            "pg/L": Decimal(sign: .plus, exponent: -12, significand: 1),
            "fg/L": Decimal(sign: .plus, exponent: -15, significand: 1),
            "ag/L": Decimal(sign: .plus, exponent: -18, significand: 1),
            "lb/in³": Decimal(string: "27679.904710191")!,
            "lb/ft³": Decimal(string: "16.018463374")!,
            "lb/yd³": Decimal(string: "0.5932764213")!,
            "lb/gal(US)": Decimal(string: "119.8264273167")!,
            "lb/gal(UK)": Decimal(string: "99.7763726631")!,
            "oz/in³": Decimal(string: "1729.9940443869")!,
            "oz/ft³": Decimal(string: "1.0011539609")!,
            "oz/gal(US)": Decimal(string: "7.4891517073")!,
            "oz/gal(UK)": Decimal(string: "6.2360232914")!,
            "gr/gal(US)": Decimal(string: "0.017118061")!,
            "gr/gal(UK)": Decimal(string: "0.0142537675")!,
            "gr/ft³": Decimal(string: "0.0022883519")!,
            "ton(sh)/yd³": Decimal(string: "1186.552842515")!,
            "ton(l)/yd³": Decimal(string: "1328.9391836174")!,
            "slug/ft³": Decimal(string: "515.3788183932")!,
            "psi/1000ft": Decimal(string: "2.3066587258")!,
            "ρE": Decimal(string: "5517.9999999999")!
        ]
        
        guard let fromValue = kilogramPerCubicMeterValues[fromUnit], let toValue = kilogramPerCubicMeterValues[toUnit] else {
            return value
        }
        
        let kilogramPerCubicMeter = value * fromValue
        return kilogramPerCubicMeter / toValue
    }
    
    private func convertSpecificVolume(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let cubicMeterPerKilogramValues: [String: Decimal] = [
            "m³/kg": 1,
            "cm³/g": Decimal(string: "0.001")!,
            "L/kg": Decimal(string: "0.001")!,
            "L/g": 1,
            "ft³/kg": Decimal(string: "0.0283168466")!,
            "ft³/lb": Decimal(string: "0.06242796")!,
            "gal(US)/lb": Decimal(string: "0.0083454039")!,
            "gal(UK)/lb": Decimal(string: "0.0100224128")!
        ]
        
        guard let fromValue = cubicMeterPerKilogramValues[fromUnit], let toValue = cubicMeterPerKilogramValues[toUnit] else {
            return value
        }
        
        let cubicMeterPerKilogram = value * fromValue
        return cubicMeterPerKilogram / toValue
    }
    
    private func convertMomentOfInertia(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let kilogramSquareMeterValues: [String: Decimal] = [
            "kg·m²": 1,
            "kg·cm²": Decimal(string: "0.0001")!,
            "kg·mm²": Decimal(sign: .plus, exponent: -6, significand: 1),
            "g·cm²": Decimal(sign: .plus, exponent: -7, significand: 1),
            "g·mm²": Decimal(sign: .plus, exponent: -9, significand: 1),
            "kgf·m·s²": Decimal(string: "9.8066499998")!,
            "kgf·cm·s²": Decimal(string: "0.0980665")!,
            "oz·in²": Decimal(string: "1.829e-5")!,
            "ozf·in·s²": Decimal(string: "0.0070615519")!,
            "lb·ft²": Decimal(string: "0.0421401101")!,
            "lbf·ft·s²": Decimal(string: "1.3558179619")!,
            "lb·in²": Decimal(string: "0.0002926397")!,
            "lbf·in·s²": Decimal(string: "0.1129848302")!,
            "slug·ft²": Decimal(string: "1.3558179619")!
        ]
        
        guard let fromValue = kilogramSquareMeterValues[fromUnit], let toValue = kilogramSquareMeterValues[toUnit] else {
            return value
        }
        
        let kilogramSquareMeter = value * fromValue
        return kilogramSquareMeter / toValue
    }
    
    private func convertMomentOfForce(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let newtonMeterValues: [String: Decimal] = [
            "N·m": 1,
            "kN·m": 1000,
            "mN·m": Decimal(string: "0.001")!,
            "µN·m": Decimal(sign: .plus, exponent: -6, significand: 1),
            "tonf(sh)·m": Decimal(string: "8896.4400000035")!,
            "tonf(l)·m": Decimal(string: "9964.0200000047")!,
            "tonf(m)·m": Decimal(string: "9806.6499999993")!,
            "kgf·m": Decimal(string: "9.80665")!,
            "gf·cm": Decimal(string: "9.80665e-5")!,
            "lbf·ft": Decimal(string: "1.35582")!,
            "pdl·ft": Decimal(string: "0.0421401")!,
            "pdl·in": Decimal(string: "0.003511675")!
        ]
        
        guard let fromValue = newtonMeterValues[fromUnit], let toValue = newtonMeterValues[toUnit] else {
            return value
        }
        
        let newtonMeter = value * fromValue
        return newtonMeter / toValue
    }
    
    private func convertTorque(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
        let newtonMeterValues: [String: Decimal] = [
            "N·m": 1,
            "N·cm": Decimal(string: "0.01")!,
            "N·mm": Decimal(string: "0.001")!,
            "kN·m": 1000,
            "dyn·m": Decimal(sign: .plus, exponent: -5, significand: 1),
            "dyn·cm": Decimal(sign: .plus, exponent: -7, significand: 1),
            "dyn·mm": Decimal(sign: .plus, exponent: -8, significand: 1),
            "kgf·m": Decimal(string: "9.80665")!,
            "kgf·cm": Decimal(string: "0.0980665")!,
            "kgf·mm": Decimal(string: "0.00980665")!,
            "gf·m": Decimal(string: "0.00980665")!,
            "gf·cm": Decimal(string: "9.80665e-5")!,
            "gf·mm": Decimal(string: "9.80665e-6")!,
            "ozf·ft": Decimal(string: "0.084738624")!,
            "ozf·in": Decimal(string: "0.007061552")!,
            "lbf·ft": Decimal(string: "1.355818")!,
            "lbf·in": Decimal(string: "0.1129848333")!,
        ]
        
        guard let fromValue = newtonMeterValues[fromUnit], let toValue = newtonMeterValues[toUnit] else {
            return value
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
            return "bolt.circle"
        case .force:
            return "arrow.left.arrow.right"
        case .fuelConsumption:
            return "fuelpump"
        case .volumeDry:
            return "cube"
        case .velocityAngular:
            return "arrow.clockwise"
        case .acceleration:
            return "gauge.open.with.lines.needle.33percent.and.arrowtriangle"
        case .accelerationAngular:
            return "digitalcrown.arrow.clockwise"
        case .density:
            return "circle.dotted.and.circle"
        case .specificVolume:
            return "shippingbox"
        case .momentOfInertia:
            return "rotate.right"
        case .momentOfForce:
            return "wrench"
        case .torque:
            return "gearshape"
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
        case .energy:
            return "EnergyInfo"
        case .power:
            return "PowerInfo"
        case .force:
            return "ForceInfo"
        case .fuelConsumption:
            return "FuelConsumptionInfo"
        case .volumeDry:
            return "VolumeDryInfo"
        case .velocityAngular:
            return "AngularVelocityInfo"
        case .acceleration:
            return "AccelerationInfo"
        case .accelerationAngular:
            return "AngularAccelerationInfo"
        case .density:
            return "DensityInfo"
        case .specificVolume:
            return "SpecificVolumeInfo"
        case .momentOfInertia:
            return "MomentOfIneritaInfo"
        case .momentOfForce:
            return "MomentOfForceInfo"
        case .torque:
            return "TorqueInfo"
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
        case .energy:
            return [
                ("J", String(localized: "joule")),
                ("kJ", String(localized: "kilojoule")),
                ("kWh", String(localized: "kilowatt-hour")),
                ("Wh", String(localized: "watt-hour")),
                ("Cal", String(localized: "calorie (nutritional)")),
                (" hp·h", String(localized: "horsepower (metric) hour")),
                ("Btu(IT)", String(localized: "Btu (IT)")),
                ("Btu(th)", String(localized: "Btu (th)")),
                ("GJ", String(localized: "gigajoule")),
                ("MJ", String(localized: "megajoule")),
                ("mJ", String(localized: "millijoule")),
                ("µJ", String(localized: "microjoule")),
                ("nJ", String(localized: "nanojoule")),
                ("aJ", String(localized: "attojoule")),
                ("MeV", String(localized: "megaelectron-volt")),
                ("keV", String(localized: "kiloelectron-volt")),
                ("eV", String(localized: "electron-volt")),
                ("erg", String(localized: "erg")),
                ("GWh", String(localized: "gigawatt-hour")),
                ("MWh", String(localized: "megawatt-hour")),
                ("kW·s", String(localized: "kilowatt-second")),
                ("W·s", String(localized: "watt-second")),
                ("N·m", String(localized: "newton meter")),
                ("hp·h", String(localized: "horsepower hour")),
                ("kcal(IT)", String(localized: "kilocalorie (IT)")),
                ("kcal(th)", String(localized: "kilocalorie (th)")),
                ("cal(IT)", String(localized: "calorie (IT)")),
                ("cal(th)", String(localized: "calorie (th)")),
                ("MBtu(IT)", String(localized: "mega Btu (IT)")),
                ("ton·h", String(localized: "ton-hour (refrigeration)")),
                ("FOE(kL)", String(localized: "fuel oil equivalent @kiloliter")),
                ("FOE(bbl)", String(localized: "fuel oil equivalent @barrel (US)")),
                ("Gt", String(localized: "gigaton")),
                ("Mt", String(localized: "megaton")),
                ("kt", String(localized: "kiloton")),
                ("t(TNT)", String(localized: "ton (explosives)")),
                ("dyn·cm", String(localized: "dyne centimeter")),
                ("gf·m", String(localized: "gram-force meter")),
                ("gf·cm", String(localized: "gram-force centimeter")),
                ("kgf·cm", String(localized: "kilogram-force centimeter")),
                ("kgf·m", String(localized: "kilogram-force meter")),
                ("kp·m", String(localized: "kilopond meter")),
                ("lbf·ft", String(localized: "pound-force foot")),
                ("lbf·in", String(localized: "pound-force inch")),
                ("ozf·in", String(localized: "ounce-force inch")),
                ("ft·lb", String(localized: "foot-pound")),
                ("in·lb", String(localized: "inch-pound")),
                ("in·oz", String(localized: "inch-ounce")),
                ("pdl·ft", String(localized: "poundal foot")),
                ("th", String(localized: "therm")),
                ("th(EC)", String(localized: "therm (EC)")),
                ("th(US)", String(localized: "therm (US)")),
                ("Eh", String(localized: "Hartree energy")),
                ("Ry", String(localized: "Rydberg constant"))
            ]
        case .power:
            return [
                ("W", String(localized: "watt")),
                ("EW", String(localized: "exawatt")),
                ("PW", String(localized: "petawatt")),
                ("TW", String(localized: "terawatt")),
                ("GW", String(localized: "gigawatt")),
                ("MW", String(localized: "megawatt")),
                ("kW", String(localized: "kilowatt")),
                ("hW", String(localized: "hectowatt")),
                ("daW", String(localized: "dekawatt")),
                ("dW", String(localized: "deciwatt")),
                ("cW", String(localized: "centiwatt")),
                ("mW", String(localized: "milliwatt")),
                ("µW", String(localized: "microwatt")),
                ("nW", String(localized: "nanowatt")),
                ("pW", String(localized: "picowatt")),
                ("fW", String(localized: "femtowatt")),
                ("aW", String(localized: "attowatt")),
                ("hp", String(localized: "horsepower")),
                ("hp(550)", String(localized: "horsepower (550 ft*lbf/s)")),
                ("hp(m)", String(localized: "horsepower (metric)")),
                ("hp(b)", String(localized: "horsepower (boiler)")),
                ("hp(e)", String(localized: "horsepower (electric)")),
                ("hp(w)", String(localized: "horsepower (water)")),
                ("PS", String(localized: "pferdestarke (ps)")),
                ("Btu(IT)/h", String(localized: "Btu (IT)/hour")),
                ("Btu(IT)/min", String(localized: "Btu (IT)/minute")),
                ("Btu(IT)/s", String(localized: "Btu (IT)/second")),
                ("Btu(th)/h", String(localized: "Btu (th)/hour")),
                ("Btu(th)/min", String(localized: "Btu (th)/minute")),
                ("Btu(th)/s", String(localized: "Btu (th)/second")),
                ("MBtu(IT)/h", String(localized: "MBtu (IT)/hour")),
                ("MBH", String(localized: "MBH")),
                ("ton(ref)", String(localized: "ton (refrigeration)")),
                ("kcal(IT)/h", String(localized: "kilocalorie (IT)/hour")),
                ("kcal(IT)/min", String(localized: "kilocalorie (IT)/minute")),
                ("kcal(IT)/s", String(localized: "kilocalorie (IT)/second")),
                ("kcal(th)/h", String(localized: "kilocalorie (th)/hour")),
                ("kcal(th)/min", String(localized: "kilocalorie (th)/minute")),
                ("kcal(th)/s", String(localized: "kilocalorie (th)/second")),
                ("cal(IT)/h", String(localized: "calorie (IT)/hour")),
                ("cal(IT)/min", String(localized: "calorie (IT)/minute")),
                ("cal(IT)/s", String(localized: "calorie (IT)/second")),
                ("cal(th)/h", String(localized: "calorie (th)/hour")),
                ("cal(th)/min", String(localized: "calorie (th)/minute")),
                ("cal(th)/s", String(localized: "calorie (th)/second")),
                ("ft·lbf/h", String(localized: "foot pound-force/hour")),
                ("ft·lbf/min", String(localized: "foot pound-force/minute")),
                ("ft·lbf/s", String(localized: "foot pound-force/second")),
                ("lb·ft/h", String(localized: "pound-foot/hour")),
                ("lb·ft/min", String(localized: "pound-foot/minute")),
                ("lb·ft/s", String(localized: "pound-foot/second")),
                ("erg/s", String(localized: "erg/second")),
                ("kVA", String(localized: "kilovolt ampere")),
                ("VA", String(localized: "volt ampere")),
                ("N·m/s", String(localized: "newton meter/second")),
                ("J/s", String(localized: "joule/second")),
                ("EJ/s", String(localized: "exajoule/second")),
                ("PJ/s", String(localized: "petajoule/second")),
                ("TJ/s", String(localized: "terajoule/second")),
                ("GJ/s", String(localized: "gigajoule/second")),
                ("MJ/s", String(localized: "megajoule/second")),
                ("kJ/s", String(localized: "kilojoule/second")),
                ("hJ/s", String(localized: "hectojoule/second")),
                ("daJ/s", String(localized: "dekajoule/second")),
                ("dJ/s", String(localized: "decijoule/second")),
                ("cJ/s", String(localized: "centijoule/second")),
                ("mJ/s", String(localized: "millijoule/second")),
                ("µJ/s", String(localized: "microjoule/second")),
                ("nJ/s", String(localized: "nanojoule/second")),
                ("pJ/s", String(localized: "picojoule/second")),
                ("fJ/s", String(localized: "femtojoule/second")),
                ("aJ/s", String(localized: "attojoule/second")),
                ("J/h", String(localized: "joule/hour")),
                ("J/min", String(localized: "joule/minute")),
                ("kJ/h", String(localized: "kilojoule/hour")),
                ("kJ/min", String(localized: "kilojoule/minute"))
            ]
        case .force:
            return [
                ("N", String(localized: "newton")),
                ("kN", String(localized: "kilonewton")),
                ("gf", String(localized: "gram-force")),
                ("kgf", String(localized: "kilogram-force")),
                ("tf", String(localized: "ton-force (metric)")),
                ("EN", String(localized: "exanewton")),
                ("PN", String(localized: "petanewton")),
                ("TN", String(localized: "teranewton")),
                ("GN", String(localized: "giganewton")),
                ("MN", String(localized: "meganewton")),
                ("hN", String(localized: "hectonewton")),
                ("daN", String(localized: "dekanewton")),
                ("dN", String(localized: "decinewton")),
                ("cN", String(localized: "centinewton")),
                ("mN", String(localized: "millinewton")),
                ("µN", String(localized: "micronewton")),
                ("nN", String(localized: "nanonewton")),
                ("pN", String(localized: "piconewton")),
                ("fN", String(localized: "femtonewton")),
                ("aN", String(localized: "attonewton")),
                ("dyn", String(localized: "dyne")),
                ("J/m", String(localized: "joule/meter")),
                ("J/cm", String(localized: "joule/centimeter")),
                ("tf(sh)", String(localized: "ton-force (short)")),
                ("tf(l)", String(localized: "ton-force (long)")),
                ("kipf", String(localized: "kip-force")),
                ("klbf", String(localized: "kilopound-force")),
                ("lbf", String(localized: "pound-force")),
                ("ozf", String(localized: "ounce-force")),
                ("pdl", String(localized: "poundal")),
                ("lb·ft/s²", String(localized: "pound foot/square second")),
                ("p", String(localized: "pond")),
                ("kp", String(localized: "kilopond"))
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
        case .fuelConsumption:
            return [
                ("m/L", String(localized: "meter/liter")),
                ("Em/L", String(localized: "exameter/liter")),
                ("Pm/L", String(localized: "petameter/liter")),
                ("Tm/L", String(localized: "terameter/liter")),
                ("Gm/L", String(localized: "gigameter/liter")),
                ("Mm/L", String(localized: "megameter/liter")),
                ("km/L", String(localized: "kilometer/liter")),
                ("hm/L", String(localized: "hectometer/liter")),
                ("dam/L", String(localized: "dekameter/liter")),
                ("cm/L", String(localized: "centimeter/liter")),
                ("mi(US)/L", String(localized: "mile (US)/liter")),
                ("nmi/L", String(localized: "nautical mile/liter")),
                ("nmi/gal(US)", String(localized: "nautical mile/gallon (US)")),
                ("km/gal(US)", String(localized: "kilometer/gallon (US)")),
                ("m/gal(US)", String(localized: "meter/gallon (US)")),
                ("m/gal(UK)", String(localized: "meter/gallon (UK)")),
                ("mi/gal(US)", String(localized: "mile/gallon (US)")),
                ("mi/gal(UK)", String(localized: "mile/gallon (UK)")),
                ("m/m³", String(localized: "meter/cubic meter")),
                ("m/cm³", String(localized: "meter/cubic centimeter")),
                ("m/yd³", String(localized: "meter/cubic yard")),
                ("m/ft³", String(localized: "meter/cubic foot")),
                ("m/in³", String(localized: "meter/cubic inch")),
                ("m/qt(US)", String(localized: "meter/quart (US)")),
                ("m/qt(UK)", String(localized: "meter/quart (UK)")),
                ("m/pt(US)", String(localized: "meter/pint (US)")),
                ("m/pt(UK)", String(localized: "meter/pint (UK)")),
                ("m/cup(US)", String(localized: "meter/cup (US)")),
                ("m/cup(UK)", String(localized: "meter/cup (UK)")),
                ("m/fl oz(US)", String(localized: "meter/fluid ounce (US)")),
                ("m/fl oz(UK)", String(localized: "meter/fluid ounce (UK)")),
                ("L/m", String(localized: "liter/meter")),
                ("L/100km", String(localized: "liter/100 km")),
                ("gal(US)/mi", String(localized: "gallon (US)/mile")),
                ("gal(US)/100mi", String(localized: "gallon (US)/100 mi")),
                ("gal(UK)/mi", String(localized: "gallon (UK)/mile")),
                ("gal(UK)/100mi", String(localized: "gallon (UK)/100 mi"))
            ]
        case .volumeDry:
            return [
                ("L", String(localized: "liter")),
                ("bbl(d,US)", String(localized: "barrel dry (US)")),
                ("pt(d,US)", String(localized: "pint dry (US)")),
                ("qt(d,US)", String(localized: "quart dry (US)")),
                ("pk(US)", String(localized: "peck (US)")),
                ("pk(UK)", String(localized: "peck (UK)")),
                ("bu(US)", String(localized: "bushel (US)")),
                ("bu(UK)", String(localized: "bushel (UK)")),
                ("cor(B)", String(localized: "cor (Biblical)")),
                ("homer(B)", String(localized: "homer (Biblical)")),
                ("ephah(B)", String(localized: "ephah (Biblical)")),
                ("seah(B)", String(localized: "seah (Biblical)")),
                ("omer(B)", String(localized: "omer (Biblical)")),
                ("cab(B)", String(localized: "cab (Biblical)")),
                ("log(B)", String(localized: "log (Biblical)"))
            ]
        case .velocityAngular:
            return [
                ("rad/s", String(localized: "radian/second")),
                ("rad/d", String(localized: "radian/day")),
                ("rad/h", String(localized: "radian/hour")),
                ("rad/min", String(localized: "radian/minute")),
                ("°/d", String(localized: "degree/day")),
                ("°/h", String(localized: "degree/hour")),
                ("°/min", String(localized: "degree/minute")),
                ("°/s", String(localized: "degree/second")),
                ("rev/d", String(localized: "revolution/day")),
                ("rev/h", String(localized: "revolution/hour")),
                ("rev/min", String(localized: "revolution/minute")),
                ("rev/s", String(localized: "revolution/second"))
            ]
        case .acceleration:
            return [
                ("m/s²", String(localized: "meter/square second")),
                ("dm/s²", String(localized: "decimeter/square second")),
                ("km/s²", String(localized: "kilometer/square second")),
                ("hm/s²", String(localized: "hectometer/square second")),
                ("dam/s²", String(localized: "dekameter/square second")),
                ("cm/s²", String(localized: "centimeter/square second")),
                ("mm/s²", String(localized: "millimeter/square second")),
                ("µm/s²", String(localized: "micrometer/square second")),
                ("nm/s²", String(localized: "nanometer/square second")),
                ("pm/s²", String(localized: "picometer/square second")),
                ("fm/s²", String(localized: "femtometer/square second")),
                ("am/s²", String(localized: "attometer/square second")),
                ("Gal", String(localized: "gal")),
                (" Gal", String(localized: "galileo")),
                ("mi/s²", String(localized: "mile/square second")),
                ("yd/s²", String(localized: "yard/square second")),
                ("ft/s²", String(localized: "foot/square second")),
                ("in/s²", String(localized: "inch/square second")),
                ("g", String(localized: "Acceleration of gravity"))
            ]
        case .accelerationAngular:
            return [
                ("rad/s²", String(localized: "radian/square second")),
                ("rad/min²", String(localized: "radian/square minute")),
                ("rev/s²", String(localized: "revolution/square second")),
                ("rev/min/s", String(localized: "revolution/minute/second")),
                ("rev/min²", String(localized: "revolution/square minute"))
            ]
        case .density:
            return [
                ("kg/m³", String(localized: "kilogram/cubic meter")),
                ("g/cm³", String(localized: "gram/cubic centimeter")),
                ("kg/cm³", String(localized: "kilogram/cubic centimeter")),
                ("g/m³", String(localized: "gram/cubic meter")),
                ("g/mm³", String(localized: "gram/cubic millimeter")),
                ("mg/m³", String(localized: "milligram/cubic meter")),
                ("mg/cm³", String(localized: "milligram/cubic centimeter")),
                ("mg/mm³", String(localized: "milligram/cubic millimeter")),
                ("Eg/L", String(localized: "exagram/liter")),
                ("Pg/L", String(localized: "petagram/liter")),
                ("Tg/L", String(localized: "teragram/liter")),
                ("Gg/L", String(localized: "gigagram/liter")),
                ("Mg/L", String(localized: "megagram/liter")),
                ("kg/L", String(localized: "kilogram/liter")),
                ("hg/L", String(localized: "hectogram/liter")),
                ("dag/L", String(localized: "dekagram/liter")),
                ("g/L", String(localized: "gram/liter")),
                ("dg/L", String(localized: "decigram/liter")),
                ("cg/L", String(localized: "centigram/liter")),
                ("mg/L", String(localized: "milligram/liter")),
                ("µg/L", String(localized: "microgram/liter")),
                ("ng/L", String(localized: "nanogram/liter")),
                ("pg/L", String(localized: "picogram/liter")),
                ("fg/L", String(localized: "femtogram/liter")),
                ("ag/L", String(localized: "attogram/liter")),
                ("lb/in³", String(localized: "pound/cubic inch")),
                ("lb/ft³", String(localized: "pound/cubic foot")),
                ("lb/yd³", String(localized: "pound/cubic yard")),
                ("lb/gal(US)", String(localized: "pound/gallon (US)")),
                ("lb/gal(UK)", String(localized: "pound/gallon (UK)")),
                ("oz/in³", String(localized: "ounce/cubic inch")),
                ("oz/ft³", String(localized: "ounce/cubic foot")),
                ("oz/gal(US)", String(localized: "ounce/gallon (US)")),
                ("oz/gal(UK)", String(localized: "ounce/gallon (UK)")),
                ("gr/gal(US)", String(localized: "grain/gallon (US)")),
                ("gr/gal(UK)", String(localized: "grain/gallon (UK)")),
                ("gr/ft³", String(localized: "grain/cubic foot")),
                ("ton(sh)/yd³", String(localized: "ton (short)/cubic yard")),
                ("ton(l)/yd³", String(localized: "ton (long)/cubic yard")),
                ("slug/ft³", String(localized: "slug/cubic foot")),
                ("psi/1000ft", String(localized: "psi/1000 feet")),
                ("ρE", String(localized: "Earth's density (mean)"))
            ]
        case .specificVolume:
            return [
                ("m³/kg", String(localized: "cubic meter/kilogram")),
                ("cm³/g", String(localized: "cubic centimeter/gram")),
                ("L/kg", String(localized: "liter/kilogram")),
                ("L/g", String(localized: "liter/gram")),
                ("ft³/kg", String(localized: "cubic foot/kilogram")),
                ("ft³/lb", String(localized: "cubic foot/pound")),
                ("gal(US)/lb", String(localized: "gallon (US)/pound")),
                ("gal(UK)/lb", String(localized: "gallon (UK)/pound"))
            ]
        case .momentOfInertia:
            return [
                ("kg·m²", String(localized: "kilogram square meter")),
                ("kg·cm²", String(localized: "kilogram square centimeter")),
                ("kg·mm²", String(localized: "kilogram square millimeter")),
                ("g·cm²", String(localized: "gram square centimeter")),
                ("g·mm²", String(localized: "gram square millimeter")),
                ("kgf·m·s²", String(localized: "kilogram-force meter square second")),
                ("kgf·cm·s²", String(localized: "kilogram-force centimeter square second")),
                ("oz·in²", String(localized: "ounce square inch")),
                ("ozf·in·s²", String(localized: "ounce-force inch sq. second")),
                ("lb·ft²", String(localized: "pound square foot")),
                ("lbf·ft·s²", String(localized: "pound-force foot sq. second")),
                ("lb·in²", String(localized: "pound square inch")),
                ("lbf·in·s²", String(localized: "pound-force inch sq. second")),
                ("slug·ft²", String(localized: "slug square foot"))
            ]
        case .momentOfForce:
            return [
                ("N·m", String(localized: "newton meter")),
                ("kN·m", String(localized: "kilonewton meter")),
                ("mN·m", String(localized: "millinewton meter")),
                ("µN·m", String(localized: "micronewton meter")),
                ("tonf(sh)·m", String(localized: "ton-force (short) meter")),
                ("tonf(l)·m", String(localized: "ton-force (long) meter")),
                ("tonf(m)·m", String(localized: "ton-force (metric) meter")),
                ("kgf·m", String(localized: "kilogram-force meter")),
                ("gf·cm", String(localized: "gram-force centimeter")),
                ("lbf·ft", String(localized: "pound-force foot")),
                ("pdl·ft", String(localized: "poundal foot")),
                ("pdl·in", String(localized: "poundal inch"))
            ]
        case .torque:
            return [
                ("N·m", String(localized: "newton meter")),
                ("N·cm", String(localized: "newton centimeter")),
                ("N·mm", String(localized: "newton millimeter")),
                ("kN·m", String(localized: "kilonewton meter")),
                ("dyn·m", String(localized: "dyne meter")),
                ("dyn·cm", String(localized: "dyne centimeter")),
                ("dyn·mm", String(localized: "dyne millimeter")),
                ("kgf·m", String(localized: "kilogram-force meter")),
                ("kgf·cm", String(localized: "kilogram-force centimeter")),
                ("kgf·mm", String(localized: "kilogram-force millimeter")),
                ("gf·m", String(localized: "gram-force meter")),
                ("gf·cm", String(localized: "gram-force centimeter")),
                ("gf·mm", String(localized: "gram-force millimeter")),
                ("ozf·ft", String(localized: "ounce-force foot")),
                ("ozf·in", String(localized: "ounce-force inch")),
                ("lbf·ft", String(localized: "pound-force foot")),
                ("lbf·in", String(localized: "pound-force inch")),
            ]
        }
    }
}
