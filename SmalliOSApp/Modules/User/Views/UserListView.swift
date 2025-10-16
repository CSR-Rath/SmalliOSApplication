//
//  UserListView.swift
//  SmalliOSApp
//
//  Created by Rath! on 14/10/25.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel: UserViewModel
    @State private var isPushActive = false
    
    var body: some View {
        
        ZStack {
            Color.mainBg.edgesIgnoringSafeArea(.all)
            
            if viewModel.users.isEmpty {
                BaseEmptyStateView()
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.users) { user in
                            UserRowView(user: user, viewModel: viewModel)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                .animation(.easeInOut, value: viewModel.users.count)
            }
        }
        .navigationBarTitle("User List", displayMode: .inline)
        .navigationBarItems(
            trailing:
                NavigationLink(
                    destination: UserFormView(viewModel: viewModel),
                    isActive: $isPushActive
                ) {
                    Button(action: {
                        viewModel.cancelEditing()
                        isPushActive = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title3)
                    }
                }
        )
    }
//
//    private func deleteUser(at offsets: IndexSet) {
//        offsets.forEach { index in
//            let user = viewModel.users[index]
//            viewModel.deleteUser(user)
//        }
//    }
}

