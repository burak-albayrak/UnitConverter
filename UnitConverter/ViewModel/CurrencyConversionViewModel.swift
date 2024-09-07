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
    
    let category = CurrencyUnitsCategory.currency
    private var exchangeRates: [String: Double] = [:]
    
    init() {
        fetchExchangeRates()
    }
    
    func fetchExchangeRates() {
        isLoading = true
        errorMessage = nil
        
        CurrencyConverterNetwork.shared.fetchExchangeRates { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let rates):
                    self?.exchangeRates = rates.conversion_rates
                    self?.convertCurrency()
                case .failure(let error):
                    self?.errorMessage = "Failed to fetch exchange rates: \(error.localizedDescription)"
                    print("Error details: \(error)")
                }
            }
        }
    }
    
    func convertCurrency() {
        guard let inputNumber = Double(inputValue),
              let fromRate = exchangeRates[category.availableUnits[selectedFromCurrencyIndex].symbol],
              let toRate = exchangeRates[category.availableUnits[selectedToCurrencyIndex].symbol] else {
            convertedValue = ""
            return
        }
        
        let result = inputNumber * (toRate / fromRate)
        convertedValue = String(format: "%.2f", result)
    }
}
