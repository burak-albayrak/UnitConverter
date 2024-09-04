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
    var availableUnitNames: [String] { get }
    var availableUnits: [Dimension] { get }
}

