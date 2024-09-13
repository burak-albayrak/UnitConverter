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
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current

        formatter.decimalSeparator = "."
        
        guard let decimalValue = formatter.number(from: value)?.decimalValue,
              selectedFirstUnitIndex < availableUnits.count,
              selectedSecondUnitIndex < availableUnits.count else {
            return "0"
        }

        let fromUnit = availableUnits[selectedFirstUnitIndex].symbol
        let toUnit = availableUnits[selectedSecondUnitIndex].symbol

        let result = category.convert(decimalValue, from: fromUnit, to: toUnit)

        let resultFormatter = NumberFormatter()
        resultFormatter.numberStyle = .decimal
        resultFormatter.maximumFractionDigits = 22
        resultFormatter.minimumFractionDigits = 0

        if abs(result) >= 0.000001 && abs(result) < pow(Decimal(10), 22) {
            return resultFormatter.string(from: NSDecimalNumber(decimal: result)) ?? "0"
        } else {
            resultFormatter.numberStyle = .scientific
            resultFormatter.exponentSymbol = "e"
            let formattedResult = resultFormatter.string(from: NSDecimalNumber(decimal: result)) ?? "0"
            return formattedResult == "0e0" ? "0" : formattedResult
        }
    }

    
    func setFromFavorite(_ favorite: FavoriteConversion) {
        selectedFirstUnitIndex = availableUnits.firstIndex(where: { $0.name == favorite.fromUnit }) ?? 0
        selectedSecondUnitIndex = availableUnits.firstIndex(where: { $0.name == favorite.toUnit }) ?? 1
    }
}
