//
//  Keychain.swift
//  SmalliOSApp
//
//  Created by Rath! on 14/10/25.
//

import Foundation
import Security

class KeychainManager {
    static let shared = KeychainManager()
    
    private init() {}
    
    // MARK: - Save dynamic field

    func save(_ value: String, for key: String) {
        guard let data = value.data(using: .utf8) else {
            print("❌ [Keychain] Failed to convert value to data.")
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        // Delete if existing
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("✅ [Keychain] Successfully saved value for key: \(key)")
        } else {
            print("❌ [Keychain] Failed to save value for key: \(key). Status code: \(status)")
        }
    }
    
    // MARK: - Get dynamic field
    func get(for key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            if let data = dataTypeRef as? Data,
               let value = String(data: data, encoding: .utf8) {
                print("✅ [Keychain] Successfully retrieved value for key: \(key)")
                return value
            } else {
                print("❌ [Keychain] Failed to decode data for key: \(key)")
                return nil
            }
        } else {
            print("❌ [Keychain] No value found for key: \(key). Status code: \(status)")
            return nil
        }
    }
    
    // MARK: - Delete dynamic field
    func delete(for key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess {
            print("🗑️ [Keychain] Successfully deleted value for key: \(key)")
        } else {
            print("❌ [Keychain] Failed to delete value for key: \(key). Status code: \(status)")
        }
    }
}


