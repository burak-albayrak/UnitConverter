//
//  PriceConvertersModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 7.09.2024.
//

import Foundation

enum CurrencyUnitsCategory: String, CaseIterable, UnitCategory {
    case currency = "Currency"

    static var exchangeRates: [String: Double] = [:]
    
    static func updateExchangeRates(completion: @escaping (Bool) -> Void) {
        CurrencyConverterNetwork.shared.fetchExchangeRates { result in
            switch result {
            case .success(let rates):
                self.exchangeRates = rates.conversion_rates
                completion(true)
            case .failure(let error):
                print("Failed to fetch exchange rates: \(error.localizedDescription)")
                completion(false)
            }
        }
    }

    func convert(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        guard let fromRate = CurrencyUnitsCategory.exchangeRates[fromUnit],
              let toRate = CurrencyUnitsCategory.exchangeRates[toUnit] else {
            return value // Return original value if conversion rates are not available
        }

        // Convert to USD first, then to the target currency
        let usdValue = value / fromRate
        return usdValue * toRate
    }

    var icon: String {
        return "dollarsign.circle"
    }

    var info: String {
        return """
        Currency conversion allows you to determine the equivalent value of money between different countries' currencies. Exchange rates fluctuate based on various economic factors.

        This converter supports a wide range of global currencies, including major ones like USD, EUR, JPY, GBP, as well as many others. The base currency for these conversions is USD (United States Dollar). All other currencies are converted relative to USD.

        Please note:
        1. Exchange rates are updated periodically and may not reflect real-time market rates.
        2. For the most accurate and up-to-date conversions, especially for large amounts or official purposes, consult a bank or official financial institution.
        3. Currency exchange in practice often involves fees and different rates for buying and selling, which are not reflected in these basic conversions.
        4. Some currencies might have been redenominated or replaced. Always check for the most current information.

        Use this tool for general reference and educational purposes. For financial decisions, seek professional advice.
        """
    }

    var availableUnits: [String] {
        return Array(CurrencyUnitsCategory.exchangeRates.keys).sorted()
    }

    // Predefined list of common currencies for fallback
    static let commonCurrencies = [
        "USD", "EUR", "JPY", "GBP", "AUD", "CAD", "CHF", "CNY", "HKD", "NZD",
        "SEK", "KRW", "SGD", "NOK", "MXN", "INR", "RUB", "ZAR", "TRY", "BRL",
        "TWD", "DKK", "PLN", "THB", "IDR", "HUF", "CZK", "ILS", "CLP", "PHP",
        "AED", "COP", "SAR", "MYR", "RON"
    ]

    // Fallback method if API fails
    static func setDefaultExchangeRates() {
        exchangeRates = Dictionary(uniqueKeysWithValues: commonCurrencies.map { ($0, 1.0) })
    }
}

// Extension to provide more readable currency names
extension CurrencyUnitsCategory {
    func getCurrencyFullName(for code: String) -> String {
        switch code {
        case "USD": return "United States Dollar"
        case "EUR": return "Euro"
        case "JPY": return "Japanese Yen"
        case "GBP": return "British Pound Sterling"
        case "AUD": return "Australian Dollar"
        case "CAD": return "Canadian Dollar"
        case "CHF": return "Swiss Franc"
        case "CNY": return "Chinese Yuan"
        case "HKD": return "Hong Kong Dollar"
        case "NZD": return "New Zealand Dollar"
        case "SEK": return "Swedish Krona"
        case "KRW": return "South Korean Won"
        case "SGD": return "Singapore Dollar"
        case "NOK": return "Norwegian Krone"
        case "MXN": return "Mexican Peso"
        case "INR": return "Indian Rupee"
        case "RUB": return "Russian Ruble"
        case "ZAR": return "South African Rand"
        case "TRY": return "Turkish Lira"
        case "BRL": return "Brazilian Real"
        case "TWD": return "New Taiwan Dollar"
        case "DKK": return "Danish Krone"
        case "PLN": return "Polish Złoty"
        case "THB": return "Thai Baht"
        case "IDR": return "Indonesian Rupiah"
        case "HUF": return "Hungarian Forint"
        case "CZK": return "Czech Koruna"
        case "ILS": return "Israeli New Shekel"
        case "CLP": return "Chilean Peso"
        case "PHP": return "Philippine Peso"
        case "AED": return "United Arab Emirates Dirham"
        case "COP": return "Colombian Peso"
        case "SAR": return "Saudi Riyal"
        case "MYR": return "Malaysian Ringgit"
        case "RON": return "Romanian Leu"
        default: return code
        }
    }
}
