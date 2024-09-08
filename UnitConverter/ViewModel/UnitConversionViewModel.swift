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
        guard let decimalValue = Decimal(string: value),
              selectedFirstUnitIndex < availableUnits.count,
              selectedSecondUnitIndex < availableUnits.count else {
            return "0"
        }

        let fromUnit = availableUnits[selectedFirstUnitIndex].name
        let toUnit = availableUnits[selectedSecondUnitIndex].name

        let result = category.convert(decimalValue, from: fromUnit, to: toUnit)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 6
        formatter.exponentSymbol = "e"
        
        if abs(result) >= 0.000001 {
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 6
        }
        
        return formatter.string(from: NSDecimalNumber(decimal: result)) ?? "0"
    }
    func setFromFavorite(_ favorite: FavoriteConversion) {
        selectedFirstUnitIndex = availableUnits.firstIndex(where: { $0.name == favorite.fromUnit }) ?? 0
        selectedSecondUnitIndex = availableUnits.firstIndex(where: { $0.name == favorite.toUnit }) ?? 1
    }
}
