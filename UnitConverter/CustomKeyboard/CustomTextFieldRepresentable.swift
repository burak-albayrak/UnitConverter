//
//  CustomTextFieldRepresentable.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 13.10.2024.
//

import SwiftUI

struct CustomTextFieldRepresentable: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> CustomTextField {
        let textField = CustomTextField(frame: .zero)
        textField.keyboardType = .numberPad
        textField.delegate = context.coordinator
        textField.placeholder = NSLocalizedString("Enter value", comment: "Placeholder for value input")
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }
    
    func updateUIView(_ uiView: CustomTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextFieldRepresentable
        
        init(_ parent: CustomTextFieldRepresentable) {
            self.parent = parent
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789e-\(Locale.current.decimalSeparator ?? ".")")
            if string.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
                return false
            }
            return true
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
