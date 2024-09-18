//
//  UnitCategory.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 2.09.2024.
//

import Foundation
import SwiftUI

protocol UnitCategory {
    var rawValue: String { get }
    var icon: String { get }
    var info: LocalizedStringKey { get }
    var availableUnits: [(symbol: String, name: String)] { get }
    var localizedName: LocalizedStringKey { get }
    
    func convert(_ value: Decimal, from fromUnit: String, to toUnit: String) -> Decimal
}
