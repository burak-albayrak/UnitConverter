//
//  CustomTextFieldMac.swift
//  UnitConverter mac
//
//  Created by Burak Albayrak on 31/10/24.
//

import SwiftUI
import AppKit

struct CustomTextFieldMac: NSViewRepresentable {
    @Binding var text: String
    var placeholder: String
    
    func makeNSView(context: Context) -> NSTextField {
        let textField = NSTextField()
        textField.placeholderString = placeholder
        textField.delegate = context.coordinator
        textField.alignment = .left
        textField.bezelStyle = .roundedBezel
        return textField
    }
    
    func updateNSView(_ nsView: NSTextField, context: Context) {
        nsView.stringValue = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, NSTextFieldDelegate {
        var text: Binding<String>
        
        init(text: Binding<String>) {
            self.text = text
        }
        
        func controlTextDidChange(_ obj: Notification) {
            guard let textField = obj.object as? NSTextField else { return }
            
            let newValue = textField.stringValue
            let decimalSeparator = Locale.current.decimalSeparator ?? "."
            
            let filtered = newValue.filter { char in
                return "0123456789-\(decimalSeparator)".contains(char)
            }
            
            var finalValue = filtered
            if filtered.contains("-") {
                let minusStripped = filtered.replacingOccurrences(of: "-", with: "")
                finalValue = filtered.first == "-" ? "-" + minusStripped : minusStripped
            }
            
            if filtered.components(separatedBy: decimalSeparator).count > 2 {
                let components = filtered.components(separatedBy: decimalSeparator)
                finalValue = components[0] + decimalSeparator + components[1]
            }
            
            if finalValue != newValue {
                textField.stringValue = finalValue
            }
            
            self.text.wrappedValue = finalValue
        }
        
        func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
            return false
        }
    }
}
