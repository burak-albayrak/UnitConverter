//
//  UnitConverterViewModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import Foundation
import SwiftUI

final class UnitConversionViewModel<T: UnitCategory>: ObservableObject {
    @Published var selectedFirstUnitIndex = 0
    @Published var selectedSecondUnitIndex = 1
    @Published var firstUnitInputValue = ""
    @Published var isInfoPresented = false
    
    var category: T
    
    init(category: T) {
        self.category = category
    }
    
    var availableUnits: [(symbol: String, name: String)] {
        return category.availableUnits.map { unit in
            let name = unit.prefix(1).uppercased() + unit.dropFirst().lowercased()
            return (symbol: unit, name: name)
        }
    }
    
    var availableUnitsIndices: Range<Int> {
        0..<availableUnits.count
    }
    
    func convertUnits(value: String) -> String {
        guard let numericValue = Double(value) else {
            return ""
        }
        
        let fromUnit = availableUnits[selectedFirstUnitIndex].symbol
        let toUnit = availableUnits[selectedSecondUnitIndex].symbol
        
        let convertedValue = category.convert(numericValue, from: fromUnit, to: toUnit)
        
        return String(format: "%g", convertedValue)
    }
}
