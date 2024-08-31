//
//  UnitModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import Foundation

enum Category: String, CaseIterable {
    case length = "Length / Distance"
    case mass = "Weight / Mass"
    case volume = "Volume"
    case temperature = "Temperature"
    case area = "Area"
    case pressure = "Pressure"
    case angle = "Angle"
    case speed = "Speed"
    case duration = "Duration"
    
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
            return "Mass is a fundamental property of matter that causes it to resist being accelerated by a force. The SI unit for mass is the kilogram (kg), which is defined in terms of the mass of the international prototype kilogram."
        case .length:
            return "Length is the dimensional extent of matter. The SI unit for length is the meter (m), which is defined in terms of the distance traveled by light in a vacuum."
        case .area:
            return "Area is a quantity of extent in two dimensions. Area can be expressed by SI derived units in terms of square meters (m2). Area is also commonly measured in square feet (ft2) and acres (ac)."
        case .volume:
            return "Volume is a quantity of the extent of matter in three dimensions. The SI accepted unit of volume is the liter (L), which is derived as one cubic decimeter (1 dm3). Volume is also commonly expressed in terms of cubic meters (m3), gallons (gal), and cups (cup)."
        case .pressure:
            return "Pressure is the normal force over a surface. The SI unit for pressure is the pascal (Pa), which is derived as one newton of force over one square meter (1Pa = 1N / 1m2)."
        case .temperature:
            return "Temperature is a comparative measure of thermal energy. The SI unit for temperature is the kelvin (K), which is defined in terms of the triple point of water. Temperature is also commonly measured by degrees of various scales, including Celsius (°C) and Fahrenheit (°F)."
        case .angle:
            return "Angle is a quantity of rotation. The SI unit for angle is the radian (rad), which is dimensionless and defined to be the angle subtended by an arc that is equal in length to the radius of a circle. Angle is also commonly expressed in terms of degrees (°) and revolutions (rev)."
        case .speed:
            return "Speed is the magnitude of velocity, or the rate of change of position. Speed can be expressed by SI derived units in terms of meters per second (m/s), and is also commonly expressed in terms of kilometers per hour (km/h) and miles per hour (mph)."
        case .duration:
            return "Duration is a quantity of time. The SI unit for time is the second (sec), which is defined in terms of the radioactivity of a cesium-133 atom. Duration is also commonly expressed in terms of minutes (min) and hours (hr)."
        }
    }
}
