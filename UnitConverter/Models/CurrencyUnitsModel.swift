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

    var info: LocalizedStringKey {
        return "CurrencyInfo"
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
        "AED", "COP", "SAR", "MYR", "RON", "ALL", "BBD",
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
        case "USD": return String(localized: "United States Dollar")
        case "EUR": return String(localized: "Euro")
        case "JPY": return String(localized: "Japanese Yen")
        case "GBP": return String(localized: "British Pound Sterling")
        case "AUD": return String(localized: "Australian Dollar")
        case "CAD": return String(localized: "Canadian Dollar")
        case "CHF": return String(localized: "Swiss Franc")
        case "CNY": return String(localized: "Chinese Yuan")
        case "HKD": return String(localized: "Hong Kong Dollar")
        case "NZD": return String(localized: "New Zealand Dollar")
        case "SEK": return String(localized: "Swedish Krona")
        case "KRW": return String(localized: "South Korean Won")
        case "SGD": return String(localized: "Singapore Dollar")
        case "NOK": return String(localized: "Norwegian Krone")
        case "MXN": return String(localized: "Mexican Peso")
        case "INR": return String(localized: "Indian Rupee")
        case "RUB": return String(localized: "Russian Ruble")
        case "ZAR": return String(localized: "South African Rand")
        case "TRY": return String(localized: "Turkish Lira")
        case "BRL": return String(localized: "Brazilian Real")
        case "TWD": return String(localized: "New Taiwan Dollar")
        case "DKK": return String(localized: "Danish Krone")
        case "PLN": return String(localized: "Polish Złoty")
        case "THB": return String(localized: "Thai Baht")
        case "IDR": return String(localized: "Indonesian Rupiah")
        case "HUF": return String(localized: "Hungarian Forint")
        case "CZK": return String(localized: "Czech Koruna")
        case "ILS": return String(localized: "Israeli New Shekel")
        case "CLP": return String(localized: "Chilean Peso")
        case "PHP": return String(localized: "Philippine Peso")
        case "AED": return String(localized: "United Arab Emirates Dirham")
        case "COP": return String(localized: "Colombian Peso")
        case "SAR": return String(localized: "Saudi Riyal")
        case "MYR": return String(localized: "Malaysian Ringgit")
        case "RON": return String(localized: "Romanian Leu")
        case "ALL": return String(localized: "Albanian Lek")
        case "AMD": return String(localized: "Armenian Dram")
        case "ANG": return String(localized: "Netherlands Antillean Guilder")
        case "AOA": return String(localized: "Angolan Kwanza")
        case "ARS": return String(localized: "Argentine Peso")
        case "AWG": return String(localized: "Aruban Florin")
        case "AZN": return String(localized: "Azerbaijani Manat")
        case "BAM": return String(localized: "Bosnia-Herzegovina Convertible Mark")
        case "BBD": return String(localized: "Barbadian Dollar")
        case "BDT": return String(localized: "Bangladeshi Taka")
        case "BGN": return String(localized: "Bulgarian Lev")
        case "BHD": return String(localized: "Bahraini Dinar")
        case "BIF": return String(localized: "Burundian Franc")
        case "BMD": return String(localized: "Bermudan Dollar")
        case "BND": return String(localized: "Brunei Dollar")
        case "BOB": return String(localized: "Bolivian Boliviano")
        case "BSD": return String(localized: "Bahamian Dollar")
        case "BTN": return String(localized: "Bhutanese Ngultrum")
        case "BWP": return String(localized: "Botswanan Pula")
        case "BYN": return String(localized: "Belarusian Ruble")
        case "BZD": return String(localized: "Belize Dollar")
        case "CDF": return String(localized: "Congolese Franc")
        case "CRC": return String(localized: "Costa Rican Colón")
        case "CUP": return String(localized: "Cuban Peso")
        case "CVE": return String(localized: "Cape Verdean Escudo")
        case "DJF": return String(localized: "Djiboutian Franc")
        case "DOP": return String(localized: "Dominican Peso")
        case "DZD": return String(localized: "Algerian Dinar")
        case "EGP": return String(localized: "Egyptian Pound")
        case "ERN": return String(localized: "Eritrean Nakfa")
        case "ETB": return String(localized: "Ethiopian Birr")
        case "FJD": return String(localized: "Fijian Dollar")
        case "FKP": return String(localized: "Falkland Islands Pound")
        case "FOK": return String(localized: "Faroese Króna")
        case "GEL": return String(localized: "Georgian Lari")
        case "GGP": return String(localized: "Guernsey Pound")
        case "GHS": return String(localized: "Ghanaian Cedi")
        case "GIP": return String(localized: "Gibraltar Pound")
        case "GMD": return String(localized: "Gambian Dalasi")
        case "GNF": return String(localized: "Guinean Franc")
        case "GTQ": return String(localized: "Guatemalan Quetzal")
        case "GYD": return String(localized: "Guyanaese Dollar")
        case "HNL": return String(localized: "Honduran Lempira")
        case "HRK": return String(localized: "Croatian Kuna")
        case "HTG": return String(localized: "Haitian Gourde")
        case "IMP": return String(localized: "Manx Pound")
        case "IQD": return String(localized: "Iraqi Dinar")
        case "IRR": return String(localized: "Iranian Rial")
        case "ISK": return String(localized: "Icelandic Króna")
        case "JEP": return String(localized: "Jersey Pound")
        case "JMD": return String(localized: "Jamaican Dollar")
        case "JOD": return String(localized: "Jordanian Dinar")
        case "KES": return String(localized: "Kenyan Shilling")
        case "KGS": return String(localized: "Kyrgystani Som")
        case "KHR": return String(localized: "Cambodian Riel")
        case "KID": return String(localized: "Kiribati Dollar")
        case "KMF": return String(localized: "Comorian Franc")
        case "KWD": return String(localized: "Kuwaiti Dinar")
        case "KYD": return String(localized: "Cayman Islands Dollar")
        case "KZT": return String(localized: "Kazakhstani Tenge")
        case "LAK": return String(localized: "Laotian Kip")
        case "LBP": return String(localized: "Lebanese Pound")
        case "LKR": return String(localized: "Sri Lankan Rupee")
        case "LRD": return String(localized: "Liberian Dollar")
        case "LSL": return String(localized: "Lesotho Loti")
        case "LYD": return String(localized: "Libyan Dinar")
        case "MAD": return String(localized: "Moroccan Dirham")
        case "MDL": return String(localized: "Moldovan Leu")
        case "MGA": return String(localized: "Malagasy Ariary")
        case "MKD": return String(localized: "Macedonian Denar")
        case "MMK": return String(localized: "Myanmar Kyat")
        case "MNT": return String(localized: "Mongolian Tugrik")
        case "MOP": return String(localized: "Macanese Pataca")
        case "MRU": return String(localized: "Mauritanian Ouguiya")
        case "MUR": return String(localized: "Mauritian Rupee")
        case "MVR": return String(localized: "Maldivian Rufiyaa")
        case "MWK": return String(localized: "Malawian Kwacha")
        case "MZN": return String(localized: "Mozambican Metical")
        case "NAD": return String(localized: "Namibian Dollar")
        case "NGN": return String(localized: "Nigerian Naira")
        case "NIO": return String(localized: "Nicaraguan Córdoba")
        case "NPR": return String(localized: "Nepalese Rupee")
        case "OMR": return String(localized: "Omani Rial")
        case "PAB": return String(localized: "Panamanian Balboa")
        case "PEN": return String(localized: "Peruvian Sol")
        case "PGK": return String(localized: "Papua New Guinean Kina")
        case "PKR": return String(localized: "Pakistani Rupee")
        case "PYG": return String(localized: "Paraguayan Guarani")
        case "QAR": return String(localized: "Qatari Rial")
        case "RSD": return String(localized: "Serbian Dinar")
        case "RWF": return String(localized: "Rwandan Franc")
        case "SBD": return String(localized: "Solomon Islands Dollar")
        case "SCR": return String(localized: "Seychellois Rupee")
        case "SDG": return String(localized: "Sudanese Pound")
        case "SHP": return String(localized: "Saint Helena Pound")
        case "SLE": return String(localized: "Sierra Leonean Leone")
        case "SLL": return String(localized: "Sierra Leonean Leone")
        case "SOS": return String(localized: "Somali Shilling")
        case "SRD": return String(localized: "Surinamese Dollar")
        case "SSP": return String(localized: "South Sudanese Pound")
        case "STN": return String(localized: "São Tomé and Príncipe Dobra")
        case "SYP": return String(localized: "Syrian Pound")
        case "SZL": return String(localized: "Swazi Lilangeni")
        case "TJS": return String(localized: "Tajikistani Somoni")
        case "TMT": return String(localized: "Turkmenistani Manat")
        case "TND": return String(localized: "Tunisian Dinar")
        case "TOP": return String(localized: "Tongan Paʻanga")
        case "TTD": return String(localized: "Trinidad and Tobago Dollar")
        case "TVD": return String(localized: "Tuvaluan Dollar")
        case "TZS": return String(localized: "Tanzanian Shilling")
        case "UAH": return String(localized: "Ukrainian Hryvnia")
        case "UGX": return String(localized: "Ugandan Shilling")
        case "UYU": return String(localized: "Uruguayan Peso")
        case "UZS": return String(localized: "Uzbekistani Som")
        case "VES": return String(localized: "Venezuelan Bolívar Soberano")
        case "VND": return String(localized: "Vietnamese Đồng")
        case "VUV": return String(localized: "Vanuatu Vatu")
        case "WST": return String(localized: "Samoan Tala")
        case "XAF": return String(localized: "Central African CFA Franc")
        case "XCD": return String(localized: "East Caribbean Dollar")
        case "XDR": return String(localized: "Special Drawing Rights")
        case "XOF": return String(localized: "West African CFA Franc")
        case "XPF": return String(localized: "CFP Franc")
        case "YER": return String(localized: "Yemeni Rial")
        case "ZMW": return String(localized: "Zambian Kwacha")
        case "ZWL": return String(localized: "Zimbabwean Dollar")
        case "AFN": return String(localized: "Afghan Afghani")
        default: return code
        }
    }}
