//
//  String+Extension.swift
//  SmalliOSApp
//
//  Created by Rath! on 14/10/25.
//

import Foundation

extension String {
    
    /// Check if string is blank (empty or only whitespace/newlines)
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// Validate string as an email
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    /// Validate string as a name (English letters or Khmer Unicode, 2–30 characters)
    var isValidName: Bool {
        let nameRegex = "^[a-zA-Z\\u1780-\\u17FF]{2,30}$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: self)
    }
    
    var firstInitial: String {
         return self.first.map { String($0).uppercased() } ?? ""
     }
    
}


extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
    
    var isNilOrEmpty: Bool {
        return self?.isBlank ?? true
    }
}
