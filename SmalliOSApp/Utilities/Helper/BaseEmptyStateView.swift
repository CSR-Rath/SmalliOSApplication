//
//  BaseEmptyStateView.swift
//  SmalliOSApp
//
//  Created by Rath! on 14/10/25.
//

import SwiftUI

struct BaseEmptyStateView: View {
    let imageName: String
    let title: String
    let message: String?

    init(imageName: String = "person.2.slash", title: String = "No Users", message: String? = nil) {
        self.imageName = imageName
        self.title = title
        self.message = message
    }

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: imageName)
                .font(.system(size: 50))
                .foregroundColor(.gray)

            Text(title)
                .font(.title2)
                .fontWeight(.semibold)

            if let message = message {
                Text(message)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}
