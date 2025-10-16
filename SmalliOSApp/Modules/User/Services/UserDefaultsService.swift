//
//  UserDefaultsService.swift
//  SmalliOSApp
//
//  Created by Rath! on 14/10/25.
//

import Foundation

class UserDefaultsService {
    private let usersKey = "storedUsers"
    
    func saveUsers(_ users: [UserModel]) {
        UserDefaults.standard.setCodable(users, forKey: usersKey)
    }
    
    func loadUsers() -> [UserModel] {
        UserDefaults.standard.codable(forKey: usersKey) ?? []
    }
    
    func deleteUser(_ user: UserModel) {
        var users = loadUsers()
        users.removeAll { $0.id == user.id }
        saveUsers(users)
    }
    
    func updateUser(_ updatedUser: UserModel) {
        var users = loadUsers()
        if let index = users.firstIndex(where: { $0.id == updatedUser.id }) {
            users[index] = updatedUser
            saveUsers(users)
        }
    }
}
