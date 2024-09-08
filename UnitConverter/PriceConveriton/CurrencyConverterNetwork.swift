//
//  CurrencyConverterNetwork.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 7.09.2024.
//

import Foundation

struct ExchangeRates: Codable {
    let result: String
    let base_code: String
    let conversion_rates: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case result
        case base_code
        case conversion_rates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decode(String.self, forKey: .result)
        base_code = try container.decode(String.self, forKey: .base_code)
        
        let doubleRates = try container.decode([String: Double].self, forKey: .conversion_rates)
        conversion_rates = doubleRates.mapValues { String($0) }
    }
}

class CurrencyConverterNetwork {
    static let shared = CurrencyConverterNetwork()
    private init() {}
    
    private let apiKey = "2a970da4e21650fd70158b82"
    private let baseURL = "https://v6.exchangerate-api.com/v6/"
    
    func fetchExchangeRates(completion: @escaping (Result<ExchangeRates, Error>) -> Void) {
        let urlString = "\(baseURL)\(apiKey)/latest/USD"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            if let dataString = String(data: data, encoding: .utf8) {
                print("Raw API Response: \(dataString)")
            }
            
            do {
                let decoder = JSONDecoder()
                let exchangeRates = try decoder.decode(ExchangeRates.self, from: data)
                completion(.success(exchangeRates))
            } catch {
                print("Decoding Error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
