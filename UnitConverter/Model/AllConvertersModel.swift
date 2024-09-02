//
//  AllConvertersModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import Foundation

enum AllConvertersCategory: String, CaseIterable {
    case engineeringConverters = "Engineering Converters"
    case heatConverters = "Heat Converters"
    case fluidsConverters = "Fluids Converters"
    case lightConverters = "Light Converters"
    case electricityConverters = "Electricity Converters"
    case magnetismConverters = "Magnetism Converters"
    case radiologyConverters = "Radiology Converters"
    
    var icon: String {
        switch self {
        case .engineeringConverters:
            return "wrench.and.screwdriver"
        case .heatConverters:
            return "flame"
        case .fluidsConverters:
            return "drop"
        case .lightConverters:
            return "lightbulb"
        case .electricityConverters:
            return "bolt"
        case .magnetismConverters:
            return "bolt.batteryblock"
        case .radiologyConverters:
            return "waveform.path.ecg" // TODO: find better
        }
    }
}
