//
//  UserModel.swift
//  SmalliOSApp
//
//  Created by Rath! on 14/10/25.
//

import Foundation

struct UserModel: Identifiable, Codable, Equatable {
    let id: UUID
    var firstName: String
    var lastName: String
    
    init(id: UUID = UUID(), firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }

}
