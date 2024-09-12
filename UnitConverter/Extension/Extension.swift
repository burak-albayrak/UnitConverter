//
//  Extension.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 9.09.2024.
//

import UIKit
import SwiftUI

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Color {
    static let customCyan = Color(red: 90/255, green: 180/255, blue: 240/255)
}
