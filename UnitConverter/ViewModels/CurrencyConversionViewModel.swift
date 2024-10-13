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
    
    func setDefaultCurrencies() {
        let usdIndex = availableCurrencies.firstIndex(where: { $0.symbol == "USD" }) ?? 0
        let eurIndex = availableCurrencies.firstIndex(where: { $0.symbol == "EUR" }) ?? 1
        
        selectedFromCurrencyIndex = usdIndex
        selectedToCurrencyIndex = eurIndex
        
        convertCurrency()
    }
    
    
    func fetchExchangeRates() {
        isLoading = true
        errorMessage = nil
        
        CurrencyUnitsCategory.updateExchangeRates { [weak self] success in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if success {
                    self?.availableCurrencies = self?.category.availableUnits ?? []
                    self?.setDefaultCurrencies()
                } else {
                    self?.errorMessage = "Failed to fetch exchange rates. Using default rates."
                    CurrencyUnitsCategory.setDefaultExchangeRates()
                    self?.availableCurrencies = CurrencyUnitsCategory.commonCurrencies.map { ($0, self?.category.getCurrencyFullName(for: $0) ?? $0) }
                    self?.setDefaultCurrencies()
                }
            }
        }
    }
    
    func convertCurrency() {
        guard let inputNumber = Decimal(string: inputValue.replacingOccurrences(of: ",", with: ".")),
              selectedFromCurrencyIndex < availableCurrencies.count,
              selectedToCurrencyIndex < availableCurrencies.count else {
            convertedValue = ""
            return
        }
        
        let fromCurrency = availableCurrencies[selectedFromCurrencyIndex].symbol
        let toCurrency = availableCurrencies[selectedToCurrencyIndex].symbol
        
        let result = category.convert(inputNumber, from: fromCurrency, to: toCurrency)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale.current
        
        convertedValue = formatter.string(from: NSDecimalNumber(decimal: result)) ?? ""
    }
    
    var info: LocalizedStringKey {
        return category.info
    }
}
