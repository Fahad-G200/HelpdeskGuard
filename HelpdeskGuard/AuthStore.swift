//
//  AuthStore.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 05/03/2026.
//

import Foundation
import Combine
import CryptoKit

final class AuthStore: ObservableObject {

    @Published var isLoggedIn: Bool = false
    @Published var currentEmail: String? = nil

    private let usersKey = "helpdeskguard_users"
    private let keychainKey = "helpdeskguard_current_user"

    init() {
        // Hent innlogget bruker fra Keychain når appen starter
        if let savedEmail = KeychainManager.load(key: keychainKey) {
            self.currentEmail = savedEmail
            self.isLoggedIn = true
        }
    }

    // Hasher passord med SHA-256 slik at det aldri lagres i klartekst
    private func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }

    private func loadUsers() -> [String: String] {
        UserDefaults.standard.dictionary(forKey: usersKey) as? [String: String] ?? [:]
    }

    private func saveUsers(_ users: [String: String]) {
        UserDefaults.standard.set(users, forKey: usersKey)
    }

    func register(email: String, password: String) -> Bool {
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        var users = loadUsers()

        if users[cleanEmail] != nil {
            return false
        }

        users[cleanEmail] = hashPassword(password)
        saveUsers(users)
        return true
    }

    func login(email: String, password: String) -> Bool {
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let users = loadUsers()

        guard let storedHash = users[cleanEmail], storedHash == hashPassword(password) else {
            return false
        }

        currentEmail = cleanEmail
        isLoggedIn = true
        KeychainManager.save(key: keychainKey, value: cleanEmail) // Lagre innlogget bruker i Keychain
        return true
    }

    func logout() {
        currentEmail = nil
        isLoggedIn = false
        KeychainManager.delete(key: keychainKey) // Fjern bruker fra Keychain ved utlogging
    }

    func deleteCurrentUser() {
        guard let email = currentEmail else { return }

        var users = loadUsers()
        users.removeValue(forKey: email)
        saveUsers(users)

        logout()
    }
}
