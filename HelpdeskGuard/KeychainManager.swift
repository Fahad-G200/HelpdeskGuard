//
//  KeychainManager.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 24/03/2026.
//

import Foundation
import Security

// KeychainManager lagrer sensitiv data trygt i Keychain i stedet for UserDefaults
struct KeychainManager {

    // Lagrer en tekst-verdi under en gitt nøkkel
    static func save(key: String, value: String) {
        let data = Data(value.utf8)
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ]
        SecItemDelete(query as CFDictionary)   // Slett gammel verdi hvis den finnes
        SecItemAdd(query as CFDictionary, nil) // Legg til ny verdi
    }

    // Henter en lagret verdi fra Keychain
    static func load(key: String) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        if let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }

    // Sletter en verdi fra Keychain
    static func delete(key: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
