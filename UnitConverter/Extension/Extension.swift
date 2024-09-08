//
//  Extension.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 9.09.2024.
//

import UIKit

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
