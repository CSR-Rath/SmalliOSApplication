//
//  UserViewModel.swift
//  SmalliOSApp
//
//  Created by Rath! on 14/10/25.
//

import Foundation
import SwiftUI

final class UserViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var users: [UserModel] = []
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    
    @Published var fieldErrors: [String: String] = [:]
    @Published var generalErrorMessage: String?
    
    // MARK: - Private properties
    private let userDefaultsService = UserDefaultsService()
    private var editingUser: UserModel?
    
    var isEditing: Bool { editingUser != nil }
    
    // MARK: - Init
    init() {
        loadUsers()
    }
    
    // MARK: - Load users
    func loadUsers() {
        users = userDefaultsService.loadUsers().reversed()
    }
    
    // MARK: - Save User
    
    func saveUser() {
        var users = userDefaultsService.loadUsers()
    
        let newUser = UserModel(
            firstName: firstName,
            lastName: lastName
        )
        
        // Save email securely
        KeychainManager.shared.save(email, for: newUser.id.uuidString)
        
        // Save to UserDefaults
        users.append(newUser)
        userDefaultsService.saveUsers(users)
        
        clearForm()
        
        // Reload Users
        loadUsers()
    }
    
    func updateUser() {
        guard let editingUser = editingUser else { return }
        
        // Updated email securely
        KeychainManager.shared.save(email, for: editingUser.id.uuidString)
        
        // Update user
        let updatedUser = UserModel(
            id: editingUser.id,
            firstName: firstName,
            lastName: lastName
        )
        userDefaultsService.updateUser(updatedUser)
      
        clearForm()
        loadUsers()
    }
    
    // MARK: - Delete user
    func deleteUser(_ user: UserModel) {
        userDefaultsService.deleteUser(user)
        KeychainManager.shared.delete(for: user.id.uuidString)
        loadUsers()
    }
    
    // MARK: - Edit user
    func setupEditForm(_ user: UserModel) {
        fieldErrors = [:]
        editingUser = user
        firstName = user.firstName
        lastName = user.lastName
        email = getEmail(uuid: user.id)
    }
    
    func cancelEditing() {
        clearForm()
    }
    
    // MARK: - reset form
    private func clearForm() {
        firstName = ""
        lastName = ""
        email = ""
        editingUser = nil
        fieldErrors = [:]
    }
    
    func getEmail(uuid: UUID) -> String {
        KeychainManager.shared.get(for: uuid.uuidString) ?? ""
    }
    
    @discardableResult
    func validateUser() -> Bool {
        var errors: [String: String] = [:]
        
        // Validate first name
        if firstName.isBlank {
            errors["firstName"] = "First name is required."
        } else if !firstName.isValidName {
            errors["firstName"] = "First name must be 2–30 letters only."
        }
        
        // Validate last name
        if lastName.isBlank {
            errors["lastName"] = "Last name is required."
        } else if !lastName.isValidName {
            errors["lastName"] = "Last name must be 2–30 letters only."
        }
        
        // Validate email
        if email.isBlank {
            errors["email"] = "Email is required."
        } else if !email.isValidEmail {
            errors["email"] = "Please enter a valid email address."
        }
        
        fieldErrors = errors
        generalErrorMessage = errors.isEmpty ? nil : "Please check the highlighted fields."
        
        return errors.isEmpty
    }
}
