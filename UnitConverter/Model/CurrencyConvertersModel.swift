//
//  PriceConvertersModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 7.09.2024.
//

import Foundation

enum CurrencyUnitsCategory: String, CaseIterable, UnitCategory {
    case currency = "Currency"
    
    var icon: String {
        return "dollarsign.circle"
    }
    
    var info: String {
        return """
        Currency conversion allows you to determine the exchange value of one country's money in relation to another. Exchange rates fluctuate based on various economic factors.

        This converter uses real-time exchange rates to provide accurate conversions between different currencies. The base currency used for calculations is USD (United States Dollar).

        Please note that while these rates are updated regularly, they should be considered approximate for informational purposes. For precise financial transactions, always consult with a financial institution or use official banking rates.
        """
    }
    
    var availableUnits: [Dimension] {
        return [
            UnitCurrency.usd,
            UnitCurrency.eur,
            UnitCurrency.gbp,
            UnitCurrency.jpy,
            UnitCurrency.cad,
            UnitCurrency.aud,
            UnitCurrency.chf,
            UnitCurrency.cny,
            // Add more currencies as needed
        ]
    }
    
    var availableUnitNames: [String] {
        return [
            "US Dollar",
            "Euro",
            "British Pound",
            "Japanese Yen",
            "Canadian Dollar",
            "Australian Dollar",
            "Swiss Franc",
            "Chinese Yuan",
            // Add more currency names as needed
        ]
    }
}

class UnitCurrency: Dimension {
    static let usd = UnitCurrency(symbol: "USD", converter: UnitConverterLinear(coefficient: 1.0))
    static let eur = UnitCurrency(symbol: "EUR", converter: UnitConverterLinear(coefficient: 1.0))
    static let gbp = UnitCurrency(symbol: "GBP", converter: UnitConverterLinear(coefficient: 1.0))
    static let jpy = UnitCurrency(symbol: "JPY", converter: UnitConverterLinear(coefficient: 1.0))
    static let cad = UnitCurrency(symbol: "CAD", converter: UnitConverterLinear(coefficient: 1.0))
    static let aud = UnitCurrency(symbol: "AUD", converter: UnitConverterLinear(coefficient: 1.0))
    static let chf = UnitCurrency(symbol: "CHF", converter: UnitConverterLinear(coefficient: 1.0))
    static let cny = UnitCurrency(symbol: "CNY", converter: UnitConverterLinear(coefficient: 1.0))
    // Add more currencies as needed
    
    override class func baseUnit() -> Self {
        return usd as! Self
    }
}
