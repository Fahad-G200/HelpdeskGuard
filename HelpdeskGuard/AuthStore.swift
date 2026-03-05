//
//  AuthStore.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 05/03/2026.
//

import Foundation
import Combine

final class AuthStore: ObservableObject {

    // MARK: - App state (UI kan følge med på dette)
    @Published var isLoggedIn: Bool = false
    @Published var currentEmail: String? = nil

    // MARK: - Lagring lokalt (UserDefaults)
    private let usersKey = "helpdeskguard_users"
    private let currentEmailKey = "helpdeskguard_currentEmail"

    init() {
        // Hvis bruker var logget inn sist, kan vi huske det
        if let savedEmail = UserDefaults.standard.string(forKey: currentEmailKey) {
            self.currentEmail = savedEmail
            self.isLoggedIn = true
        }
    }

    // Henter alle brukere fra UserDefaults
    private func loadUsers() -> [String: String] {
        UserDefaults.standard.dictionary(forKey: usersKey) as? [String: String] ?? [:]
    }

    // Lagrer brukere til UserDefaults
    private func saveUsers(_ users: [String: String]) {
        UserDefaults.standard.set(users, forKey: usersKey)
    }

    // MARK: - Register
    // Returnerer true hvis registrering gikk bra
    func register(email: String, password: String) -> Bool {
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        var users = loadUsers()

        // Hvis e-post finnes fra før -> feil
        if users[cleanEmail] != nil {
            return false
        }

        // Lagre ny bruker
        users[cleanEmail] = password
        saveUsers(users)
        return true
    }

    // MARK: - Login
    // Returnerer true hvis innlogging gikk bra
    func login(email: String, password: String) -> Bool {
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let users = loadUsers()

        guard let storedPassword = users[cleanEmail], storedPassword == password else {
            return false
        }

        // Sett innlogget status
        currentEmail = cleanEmail
        isLoggedIn = true
        UserDefaults.standard.set(cleanEmail, forKey: currentEmailKey)
        return true
    }

    // MARK: - Logout
    func logout() {
        currentEmail = nil
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: currentEmailKey)
    }
}

