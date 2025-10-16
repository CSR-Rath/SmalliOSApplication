//
//  BaseButton.swift
//  SmalliOSApp
//
//  Created by Rath! on 15/10/25.
//

import SwiftUI

struct BaseButton: View {
    let title: String
    var backgroundColor: Color = .blue
    var foregroundColor: Color = .white
    var cornerRadius: CGFloat = 12
    var height: CGFloat = 44
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
        }
    }
}
