//
//  FavoriteConversion.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 8.09.2024.
//

import Foundation
import SwiftData

@Model
final class FavoriteConversion {
    var id: UUID
    var category: String
    var fromUnit: String
    var toUnit: String
    
    init(category: String, fromUnit: String, toUnit: String) {
        self.id = UUID()
        self.category = category
        self.fromUnit = fromUnit
        self.toUnit = toUnit
    }
}
