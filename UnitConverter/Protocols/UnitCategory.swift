//
//  UnitCategory.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 2.09.2024.
//

import Foundation

protocol UnitCategory {
    var rawValue: String { get }
    var icon: String { get }
    var info: String { get }
    var availableUnits: [(symbol: String, name: String)] { get }

    func convert(_ value: Double, from fromUnit: String, to toUnit: String) -> Double
}
