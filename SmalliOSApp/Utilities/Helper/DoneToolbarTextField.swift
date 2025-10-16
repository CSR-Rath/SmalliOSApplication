//
//  DoneToolbarTextField.swift
//  SmalliOSApp
//
//  Created by Rath! on 14/10/25.
//

import SwiftUI
import UIKit

// MARK: - NoAssistantTextField
final class NoAssistantTextField: UITextField {
    override var inputAssistantItem: UITextInputAssistantItem {
        let item = super.inputAssistantItem
        item.leadingBarButtonGroups = []
        item.trailingBarButtonGroups = []
        return item
    }
}

struct DoneToolbarTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var isEditing: Bool
    var keyboardType: UIKeyboardType = .default
    var contentType: UITextContentType?
    var placeholder: String = ""
    var onTextChange: ((String) -> Void)? = nil

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = .clear
        textField.keyboardType = keyboardType
        textField.textContentType = contentType
        textField.returnKeyType = .done

        // Placeholder color
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.gray.withAlphaComponent(0.3)]
        )

        // Padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
        textField.rightViewMode = .always

        //  Add toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: context.coordinator,
            action: #selector(Coordinator.doneButtonTapped)
        )
        toolbar.items = [UIBarButtonItem.flexibleSpace(), doneButton]
        textField.inputAccessoryView = toolbar
    

        // Text change
        textField.addTarget(context.coordinator, action: #selector(Coordinator.textChanged(_:)), for: .editingChanged)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if uiView.text != text { uiView.text = text }
        uiView.keyboardType = keyboardType
        uiView.textContentType = contentType
        if uiView.placeholder != placeholder {
            uiView.placeholder = placeholder
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    // MARK: - Coordinator
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: DoneToolbarTextField

        init(_ parent: DoneToolbarTextField) { self.parent = parent }

        @objc func textChanged(_ sender: UITextField) {
            parent.text = sender.text ?? ""
            parent.onTextChange?(parent.text)
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.parent.isEditing = true
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.isEditing = false
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            doneButtonTapped()
            return true
        }

        @objc func doneButtonTapped() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

