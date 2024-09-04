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
    
    var availableUnits: [Dimension] {
        return category.availableUnits
    }
    
    var availableUnitNames: [String] {
        return category.availableUnitNames
    }
    
    func convertUnits(value: String) -> String {
        guard let numericValue = Double(value) else {
            return ""
        }
        
        let fromUnit = availableUnits[selectedFirstUnitIndex]
        let toUnit = availableUnits[selectedSecondUnitIndex]
        
        let measurement = Measurement(value: numericValue, unit: fromUnit)
        let convertedValue = measurement.converted(to: toUnit).value
        
        return String(format: "%g", convertedValue)
    }
}
