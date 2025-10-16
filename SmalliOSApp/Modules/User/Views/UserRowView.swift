//
//  UserRowView.swift
//  SmalliOSApp
//
//  Created by Rath! on 14/10/25.
//

import SwiftUI

struct UserRowView: View {
    let user: UserModel
    @ObservedObject var viewModel: UserViewModel
    @State private var showDeleteAlert = false
    @State private var isEditingActive = false
    
    var body: some View {
        HStack(spacing: 15) {
            
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Text(user.firstName.firstInitial + user.lastName.firstInitial )
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(user.firstName) \(user.lastName)")
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text(viewModel.getEmail(uuid: user.id))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            VStack(spacing: 0) {
               
                NavigationLink(
                    destination: UserFormView(viewModel: viewModel),
                    isActive: $isEditingActive
                ) {
                    Button {
                        viewModel.setupEditForm(user)
                        isEditingActive = true
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                }
                .buttonStyle(PlainButtonStyle())
                .alert(isPresented: $showDeleteAlert) {
                    Alert(
                        title: Text("Delete User"),
                        message: Text("Are you sure you want to delete \(user.firstName) \(user.lastName)?"),
                        primaryButton: .destructive(Text("Delete")) {
                            viewModel.deleteUser(user)
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.white))
                .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
        )
    }
}


