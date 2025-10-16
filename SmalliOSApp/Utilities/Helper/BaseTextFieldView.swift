//
//  BaseTextField.swift
//  SmalliOSApp
//
//  Created by Rath! on 15/10/25.
//

import SwiftUI

struct BaseTextFieldView: View {
    @Binding var text: String
    var placeholder: String
    var errorMessage: String?
    var keyboardType: UIKeyboardType = .default
    var contentType: UITextContentType?
    var onEditingChanged: ((Bool) -> Void)? = nil
    var onTextChanged: (() -> Void)? = nil

    @State private var isEditing: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(placeholder)
                .font(.footnote)
                .foregroundColor(.gray)

            DoneToolbarTextField(
                text: $text,
                isEditing: $isEditing,
                keyboardType: keyboardType,
                contentType: contentType,
                placeholder: placeholder,
                onTextChange: { _ in onTextChanged?() }
            )
            .frame(height: 44)
            .background(Color.clear)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 1.2)
                
            )
            .onChange(of: isEditing) { newValue in
                    onEditingChanged?(newValue)
            }

            if let error = errorMessage, !error.isEmpty {
                HStack(spacing: 4) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.caption2)
                        .foregroundColor(.red)
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                    Spacer()
                }
                .padding(.horizontal, 4)
                .transition(.opacity)
            }
        }
        .frame(minHeight: 60)
    }

    private var borderColor: Color {
        if let error = errorMessage, !error.isEmpty { return .red }
        else if isEditing { return .blue }
        else { return .gray.opacity(0.4) }
    }
}
