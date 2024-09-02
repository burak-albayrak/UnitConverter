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
            return "waveform.path.ecg" // TODO: find better
        }
    }
    
    var unitCategory: [UnitCategory] {
        switch self {
        case .engineeringConverters:
            return EngineeringUnitsCategory.allCases
        // Diğer kategoriler için benzer şekilde devam edin
        // case .heat:
        //     return HeatUnitsCategory.allCases
        // ...
        default:
            return [] // Geçici olarak boş dizi döndürüyoruz
        }
    }
}
