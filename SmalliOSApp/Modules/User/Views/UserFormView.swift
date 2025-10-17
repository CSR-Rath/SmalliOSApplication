//
//  UserFormView.swift
//  SmalliOSApp
//
//  Created by Rath! on 14/10/25.
//

import SwiftUI
import Combine

struct UserFormView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        ZStack {
            Color.mainBg.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 20) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                    
                    VStack(spacing: 15) {
                        // MARK: TextFields
                        BaseTextFieldView(
                            text: $viewModel.firstName,
                            placeholder: "First Name",
                            errorMessage: viewModel.fieldErrors["firstName"],
                            onEditingChanged: { _ in viewModel.fieldErrors["firstName"] = nil },
                            onTextChanged: { viewModel.fieldErrors["firstName"] = nil }
                        )
                        
                        BaseTextFieldView(
                            text: $viewModel.lastName,
                            placeholder: "Last Name",
                            errorMessage: viewModel.fieldErrors["lastName"],
                            onEditingChanged: { _ in viewModel.fieldErrors["lastName"] = nil },
                            onTextChanged: { viewModel.fieldErrors["lastName"] = nil }
                        )
                        
                        BaseTextFieldView(
                            text: $viewModel.email,
                            placeholder: "Email",
                            errorMessage: viewModel.fieldErrors["email"],
                            onEditingChanged: { _ in viewModel.fieldErrors["email"] = nil },
                            onTextChanged: { viewModel.fieldErrors["email"] = nil }
                        )
                        
                        // MARK: Save/Update Button
                        BaseButton(
                            title: viewModel.isEditing ? "Update User" : "Save User",
                            backgroundColor: .blue,
                            foregroundColor: .white
                        ) {
                            
                            if viewModel.validateUser() {
                                if viewModel.isEditing {
                                    viewModel.updateUser()
                                }else{
                                    viewModel.saveUser()
                                }
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        
                        // MARK: Cancel Button
                        if viewModel.isEditing {
                            BaseButton(
                                title: "Cancel",
                                backgroundColor: Color.red.opacity(0.1),
                                foregroundColor: .red
                            ) {
                                viewModel.resetForm()
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 3)
                    .padding(.horizontal)
                    .animation(.easeInOut(duration: 0.2), value: viewModel.fieldErrors)
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitle(viewModel.isEditing ? "Edit User" : "Add User", displayMode: .inline)
    }
    
}
