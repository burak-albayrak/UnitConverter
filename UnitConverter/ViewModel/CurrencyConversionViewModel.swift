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
    @Published var availableCurrencies: [String] = []
    
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
                    self?.availableCurrencies = CurrencyUnitsCategory.exchangeRates.keys.sorted()
                    self?.convertCurrency()
                } else {
                    self?.errorMessage = "Failed to fetch exchange rates. Using default rates."
                    CurrencyUnitsCategory.setDefaultExchangeRates()
                    self?.availableCurrencies = CurrencyUnitsCategory.commonCurrencies
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
        
        let fromCurrency = availableCurrencies[selectedFromCurrencyIndex]
        let toCurrency = availableCurrencies[selectedToCurrencyIndex]
        
        let result = category.convert(inputNumber, from: fromCurrency, to: toCurrency)
        convertedValue = String(format: "%.2f", result)
    }
    
    func getCurrencyFullName(for index: Int) -> String {
        guard index < availableCurrencies.count else { return "" }
        let code = availableCurrencies[index]
        return category.getCurrencyFullName(for: code)
    }
    
    var info: String {
        return category.info
    }
}
