//
//  AllConvertersModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import Foundation

enum AllConvertersCategory: String, CaseIterable, Identifiable{
    case engineeringConverters = "Engineering Converters"
    case heatConverters = "Heat Converters"
    case fluidsConverters = "Fluids Converters"
    case lightConverters = "Light Converters"
    case electricityConverters = "Electricity Converters"
    case magnetismConverters = "Magnetism Converters"
    case radiologyConverters = "Radiology Converters"
    
    var id: String { self.rawValue }
    
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
            return "dot.radiowaves.left.and.right"
        }
    }
    
    var unitCategory: [UnitCategory] {
        switch self {
        case .engineeringConverters:
            return EngineeringUnitsCategory.allCases
        case .heatConverters:
            return HeatUnitsCategory.allCases
        case .fluidsConverters:
            return FluidsUnitsCategory.allCases
        case .lightConverters:
            return LightUnitsCategory.allCases
        case .electricityConverters:
            return ElectricityUnitsCategory.allCases
        case .magnetismConverters:
            return MagnetismUnitsCategory.allCases
        case .radiologyConverters:
            return RadiollogyUnitsCategory.allCases
        }
    }
}
