//
//  CustomTextField.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 13.10.2024.
//

import UIKit

class CustomTextField: UITextField {
    
    private let decimalSeparator = Locale.current.decimalSeparator ?? "."
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInputAccessoryView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInputAccessoryView()
    }
    
    private func setupInputAccessoryView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Create the buttons
        let minusButton = createCustomButton(title: "−", action: #selector(insertMinus))
        let eButton = createCustomButton(title: "e", action: #selector(insertE))
        let decimalButton = createCustomButton(title: decimalSeparator, action: #selector(insertDecimal))
        
        // Create flexible spaces
        let flexibleSpace1 = UIBarButtonItem(systemItem: .flexibleSpace)
        let flexibleSpace2 = UIBarButtonItem(systemItem: .flexibleSpace)
        let flexibleSpace3 = UIBarButtonItem(systemItem: .flexibleSpace)
        let flexibleSpace4 = UIBarButtonItem(systemItem: .flexibleSpace)
        let flexibleSpace5 = UIBarButtonItem(systemItem: .flexibleSpace)
        
        // Create divider views
        let divider1 = createDivider()
        let divider2 = createDivider()
        
        // Set the items in order
        toolbar.items = [
            flexibleSpace1,
            UIBarButtonItem(customView: minusButton),
            flexibleSpace4,
            UIBarButtonItem(customView: divider1),
            flexibleSpace2,
            UIBarButtonItem(customView: eButton),
            flexibleSpace5,
            UIBarButtonItem(customView: divider2),
            flexibleSpace3,
            UIBarButtonItem(customView: decimalButton),
            flexibleSpace1
        ]
        
        inputAccessoryView = toolbar
    }
    
    @objc private func insertE() {
        guard let text = self.text,
              !text.isEmpty,
              !text.contains("e"),
              text != "-" else { return }
        
        // Check if there's a number before 'e'
        let numbers = CharacterSet.decimalDigits
        guard text.rangeOfCharacter(from: numbers) != nil else { return }
        
        insertTextAtCursor("e")
    }
    
    @objc private func insertMinus() {
        guard let selectedRange = selectedTextRange else { return }
        let cursorPosition = selectedRange.start
        if let textRange = textRange(from: beginningOfDocument, to: cursorPosition) {
            let textBeforeCursor = text(in: textRange) ?? ""
            if cursorPosition == beginningOfDocument || textBeforeCursor.last == "e" {
                insertTextAtCursor("-")
            }
        }
    }
    
    @objc private func insertDecimal() {
        guard let text = self.text,
              !text.isEmpty,
              !text.contains(decimalSeparator),
              text != "-" else { return }
        insertTextAtCursor(decimalSeparator)
    }
    
    private func insertTextAtCursor(_ string: String) {
        guard let selectedRange = selectedTextRange else { return }
        replace(selectedRange, withText: string)
    }
    
    private func createCustomButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(configuration: .plain())
        
        button.configuration?.title = title
        button.configuration?.baseForegroundColor = .systemCyan
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        button.configuration?.attributedTitle = AttributedString(title, attributes: container)
        
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    private func createDivider() -> UIView {
        let divider = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 25))
        divider.backgroundColor = .lightGray
        return divider
    }
}
