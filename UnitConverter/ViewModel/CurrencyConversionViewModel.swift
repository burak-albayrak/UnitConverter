//
//  PriceConversionViewModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 7.09.2024.
//

import Foundation
import SwiftUI

class CurrencyConversionViewModel: ObservableObject {
    @Published var selectedFromCurrencyIndex = 0
    @Published var selectedToCurrencyIndex = 1
    @Published var inputValue = ""
    @Published var isInfoPresented = false
    @Published var convertedValue = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var availableCurrencies: [(symbol: String, name: String)] = []
    
    let category = CurrencyUnitsCategory.currency
    
    init() {
        fetchExchangeRates()
    }
    
    func fetchExchangeRates() {
        isLoading = true
        errorMessage = nil
        
        CurrencyUnitsCategory.updateExchangeRates { [weak self] success in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if success {
                    self?.availableCurrencies = self?.category.availableUnits ?? []
                    self?.convertCurrency()
                } else {
                    self?.errorMessage = "Failed to fetch exchange rates. Using default rates."
                    CurrencyUnitsCategory.setDefaultExchangeRates()
                    self?.availableCurrencies = CurrencyUnitsCategory.commonCurrencies.map { ($0, self?.category.getCurrencyFullName(for: $0) ?? $0) }
                }
            }
        }
    }
    
    func convertCurrency() {
        guard let inputNumber = Double(inputValue),
              selectedFromCurrencyIndex < availableCurrencies.count,
              selectedToCurrencyIndex < availableCurrencies.count else {
            convertedValue = ""
            return
        }
        
        let fromCurrency = availableCurrencies[selectedFromCurrencyIndex].symbol
        let toCurrency = availableCurrencies[selectedToCurrencyIndex].symbol
        
        let result = category.convert(inputNumber, from: fromCurrency, to: toCurrency)
        convertedValue = String(format: "%.2f", result)
    }
    
    var info: String {
        return category.info
    }
}
