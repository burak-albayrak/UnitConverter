//
//  PriceConvertersModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 7.09.2024.
//

import Foundation
import SwiftUI

enum CurrencyUnitsCategory: String, CaseIterable, UnitCategory {
    case currency = "Currency"

    static var exchangeRates: [String: Decimal] = [:]
    
    static func updateExchangeRates(completion: @escaping (Bool) -> Void) {
        CurrencyConverterNetwork.shared.fetchExchangeRates { result in
            switch result {
            case .success(let rates):
                self.exchangeRates = rates.conversion_rates.mapValues { Decimal(string: String($0)) ?? 1 }
                completion(true)
            case .failure(let error):
                print("Failed to fetch exchange rates: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
    
    var localizedInfo: LocalizedStringKey {
        LocalizedStringKey("\(self.rawValue)Info")
    }

    func convert(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal {
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

    var availableUnits: [(symbol: String, name: String)] {
        return CurrencyUnitsCategory.exchangeRates.keys.sorted().map { code in
            (symbol: code, name: getCurrencyFullName(for: code))
        }
    }

    // Predefined list of common currencies for fallback
    static let commonCurrencies = [
        "USD", "EUR", "JPY", "GBP", "AUD", "CAD", "CHF", "CNY", "HKD", "NZD",
        "SEK", "KRW", "SGD", "NOK", "MXN", "INR", "RUB", "ZAR", "TRY", "BRL",
        "TWD", "DKK", "PLN", "THB", "IDR", "HUF", "CZK", "ILS", "CLP", "PHP",
        "AED", "COP", "SAR", "MYR", "RON",
        "AFN", "AMD", "ANG", "AOA", "ARS", "AWG", "AZN", "BAM", "BDD", "BDT",
        "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BSD", "BTN", "BWP", "BYN",
        "BZD", "CDF", "CRC", "CUP", "CVE", "DJF", "DOP", "DZD", "EGP", "ERN",
        "ETB", "FJD", "FKP", "FOK", "GEL", "GGP", "GHS", "GIP", "GMD", "GNF",
        "GTQ", "GYD", "HNL", "HRK", "HTG", "IMP", "IQD", "IRR", "ISK", "JEP",
        "JMD", "JOD", "KES", "KGS", "KHR", "KID", "KMF", "KWD", "KYD", "KZT",
        "LAK", "LBP", "LKR", "LRD", "LSL", "LYD", "MAD", "MDL", "MGA", "MKD",
        "MMK", "MNT", "MOP", "MRU", "MUR", "MVR", "MWK", "MZN", "NAD", "NGN",
        "NIO", "NPR", "OMR", "PAB", "PEN", "PGK", "PKR", "PYG", "QAR", "RSD",
        "RWF", "SBD", "SCR", "SDG", "SHP", "SLE", "SLL", "SOS", "SRD", "SSP",
        "STN", "SYP", "SZL", "TJS", "TMT", "TND", "TOP", "TTD", "TVD", "TZS",
        "UAH", "UGX", "UYU", "UZS", "VES", "VND", "VUV", "WST", "XAF", "XCD",
        "XDR", "XOF", "XPF", "YER", "ZMW", "ZWL"
    ]

    // Fallback method if API fails
    static func setDefaultExchangeRates() {
        exchangeRates = Dictionary(uniqueKeysWithValues: commonCurrencies.map { ($0, 1.0) })
    }

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
        case "AFN": return "Afghan Afghani"
        case "AMD": return "Armenian Dram"
        case "ANG": return "Netherlands Antillean Guilder"
        case "AOA": return "Angolan Kwanza"
        case "ARS": return "Argentine Peso"
        case "AWG": return "Aruban Florin"
        case "AZN": return "Azerbaijani Manat"
        case "BAM": return "Bosnia-Herzegovina Convertible Mark"
        case "BDD": return "Brunei Dollar"
        case "BDT": return "Bangladeshi Taka"
        case "BGN": return "Bulgarian Lev"
        case "BHD": return "Bahraini Dinar"
        case "BIF": return "Burundian Franc"
        case "BMD": return "Bermudan Dollar"
        case "BND": return "Brunei Dollar"
        case "BOB": return "Bolivian Boliviano"
        case "BSD": return "Bahamian Dollar"
        case "BTN": return "Bhutanese Ngultrum"
        case "BWP": return "Botswanan Pula"
        case "BYN": return "Belarusian Ruble"
        case "BZD": return "Belize Dollar"
        case "CDF": return "Congolese Franc"
        case "CRC": return "Costa Rican Colón"
        case "CUP": return "Cuban Peso"
        case "CVE": return "Cape Verdean Escudo"
        case "DJF": return "Djiboutian Franc"
        case "DOP": return "Dominican Peso"
        case "DZD": return "Algerian Dinar"
        case "EGP": return "Egyptian Pound"
        case "ERN": return "Eritrean Nakfa"
        case "ETB": return "Ethiopian Birr"
        case "FJD": return "Fijian Dollar"
        case "FKP": return "Falkland Islands Pound"
        case "FOK": return "Faroese Króna"
        case "GEL": return "Georgian Lari"
        case "GGP": return "Guernsey Pound"
        case "GHS": return "Ghanaian Cedi"
        case "GIP": return "Gibraltar Pound"
        case "GMD": return "Gambian Dalasi"
        case "GNF": return "Guinean Franc"
        case "GTQ": return "Guatemalan Quetzal"
        case "GYD": return "Guyanaese Dollar"
        case "HNL": return "Honduran Lempira"
        case "HRK": return "Croatian Kuna"
        case "HTG": return "Haitian Gourde"
        case "IMP": return "Manx Pound"
        case "IQD": return "Iraqi Dinar"
        case "IRR": return "Iranian Rial"
        case "ISK": return "Icelandic Króna"
        case "JEP": return "Jersey Pound"
        case "JMD": return "Jamaican Dollar"
        case "JOD": return "Jordanian Dinar"
        case "KES": return "Kenyan Shilling"
        case "KGS": return "Kyrgystani Som"
        case "KHR": return "Cambodian Riel"
        case "KID": return "Kiribati Dollar"
        case "KMF": return "Comorian Franc"
        case "KWD": return "Kuwaiti Dinar"
        case "KYD": return "Cayman Islands Dollar"
        case "KZT": return "Kazakhstani Tenge"
        case "LAK": return "Laotian Kip"
        case "LBP": return "Lebanese Pound"
        case "LKR": return "Sri Lankan Rupee"
        case "LRD": return "Liberian Dollar"
        case "LSL": return "Lesotho Loti"
        case "LYD": return "Libyan Dinar"
        case "MAD": return "Moroccan Dirham"
        case "MDL": return "Moldovan Leu"
        case "MGA": return "Malagasy Ariary"
        case "MKD": return "Macedonian Denar"
        case "MMK": return "Myanmar Kyat"
        case "MNT": return "Mongolian Tugrik"
        case "MOP": return "Macanese Pataca"
        case "MRU": return "Mauritanian Ouguiya"
        case "MUR": return "Mauritian Rupee"
        case "MVR": return "Maldivian Rufiyaa"
        case "MWK": return "Malawian Kwacha"
        case "MZN": return "Mozambican Metical"
        case "NAD": return "Namibian Dollar"
        case "NGN": return "Nigerian Naira"
        case "NIO": return "Nicaraguan Córdoba"
        case "NPR": return "Nepalese Rupee"
        case "OMR": return "Omani Rial"
        case "PAB": return "Panamanian Balboa"
        case "PEN": return "Peruvian Sol"
        case "PGK": return "Papua New Guinean Kina"
        case "PKR": return "Pakistani Rupee"
        case "PYG": return "Paraguayan Guarani"
        case "QAR": return "Qatari Rial"
        case "RSD": return "Serbian Dinar"
        case "RWF": return "Rwandan Franc"
        case "SBD": return "Solomon Islands Dollar"
        case "SCR": return "Seychellois Rupee"
        case "SDG": return "Sudanese Pound"
        case "SHP": return "Saint Helena Pound"
        case "SLE": return "Sierra Leonean Leone"
        case "SLL": return "Sierra Leonean Leone"
        case "SOS": return "Somali Shilling"
        case "SRD": return "Surinamese Dollar"
        case "SSP": return "South Sudanese Pound"
        case "STN": return "São Tomé and Príncipe Dobra"
        case "SYP": return "Syrian Pound"
        case "SZL": return "Swazi Lilangeni"
        case "TJS": return "Tajikistani Somoni"
        case "TMT": return "Turkmenistani Manat"
        case "TND": return "Tunisian Dinar"
        case "TOP": return "Tongan Paʻanga"
        case "TTD": return "Trinidad and Tobago Dollar"
        case "TVD": return "Tuvaluan Dollar"
        case "TZS": return "Tanzanian Shilling"
        case "UAH": return "Ukrainian Hryvnia"
        case "UGX": return "Ugandan Shilling"
        case "UYU": return "Uruguayan Peso"
        case "UZS": return "Uzbekistani Som"
        case "VES": return "Venezuelan Bolívar Soberano"
        case "VND": return "Vietnamese Đồng"
        case "VUV": return "Vanuatu Vatu"
        case "WST": return "Samoan Tala"
        case "XAF": return "Central African CFA Franc"
        case "XCD": return "East Caribbean Dollar"
        case "XDR": return "Special Drawing Rights"
        case "XOF": return "West African CFA Franc"
        case "XPF": return "CFP Franc"
        case "YER": return "Yemeni Rial"
        case "ZMW": return "Zambian Kwacha"
        case "ZWL": return "Zimbabwean Dollar"
        default: return "Unknown Currency"
        }
    }
}
