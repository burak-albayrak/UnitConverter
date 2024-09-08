//
//  UnitConverterViewModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import Foundation
import SwiftUI
import SwiftData

final class UnitConversionViewModel<T: UnitCategory>: ObservableObject {
    @Environment(\.modelContext) private var modelContext
    @Published var selectedFirstUnitIndex = 0
    @Published var selectedSecondUnitIndex = 1
    @Published var firstUnitInputValue = ""
    @Published var isInfoPresented = false
    
    var category: T
    
    init(category: T) {
        self.category = category
    }
    
    var availableUnits: [(symbol: String, name: String)] {
        category.availableUnits
    }

    
    var availableUnitsIndices: Range<Int> {
        0..<availableUnits.count
    }
    
    func convertUnits(value: String) -> String {
        guard let doubleValue = Double(value),
              selectedFirstUnitIndex < availableUnits.count,
              selectedSecondUnitIndex < availableUnits.count else {
            return "0"
        }

        let fromUnit = availableUnits[selectedFirstUnitIndex].name
        let toUnit = availableUnits[selectedSecondUnitIndex].name

        let result = category.convert(doubleValue, from: fromUnit, to: toUnit)
        return String(format: "%4f", result)
    }
}
