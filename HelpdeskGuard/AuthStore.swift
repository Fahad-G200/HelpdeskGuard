//
//  AuthStore.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 05/03/2026.
//

import Foundation
import Combine

final class AuthStore: ObservableObject {

    @Published var isLoggedIn: Bool = false
    @Published var currentEmail: String? = nil

    private let usersKey = "helpdeskguard_users"
    private let currentEmailKey = "helpdeskguard_currentEmail"

    init() {
        if let savedEmail = UserDefaults.standard.string(forKey: currentEmailKey) {
            self.currentEmail = savedEmail
            self.isLoggedIn = true
        }
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

        users[cleanEmail] = password
        saveUsers(users)
        return true
    }

    func login(email: String, password: String) -> Bool {
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let users = loadUsers()

        guard let storedPassword = users[cleanEmail], storedPassword == password else {
            return false
        }

        currentEmail = cleanEmail
        isLoggedIn = true
        UserDefaults.standard.set(cleanEmail, forKey: currentEmailKey)
        return true
    }

    func logout() {
        currentEmail = nil
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: currentEmailKey)
    }
}
