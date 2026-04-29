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
    @Published var token: String? = nil

    private let currentEmailKey = "helpdeskguard_currentEmail"
    private let tokenKey = "helpdeskguard_token"

    private let baseURL = "http://172.20.128.20:3000"

    init() {
        if let savedEmail = UserDefaults.standard.string(forKey: currentEmailKey),
           let savedToken = UserDefaults.standard.string(forKey: tokenKey) {
            self.currentEmail = savedEmail
            self.token = savedToken
            self.isLoggedIn = true
        }
    }

    func register(email: String, password: String) async -> Bool {
        guard let url = URL(string: "\(baseURL)/registrer") else { return false }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["email": email, "password": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body) else { return false }
        request.httpBody = httpBody

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                return httpResponse.statusCode == 200 || httpResponse.statusCode == 201
            }
        } catch {
            print("Registreringsfeil:", error.localizedDescription)
        }
        return false
    }

    func login(email: String, password: String) async -> Bool {
        guard let url = URL(string: "\(baseURL)/logginn") else { return false }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["email": email, "password": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body) else { return false }
        request.httpBody = httpBody

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200,
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let receivedToken = json["token"] as? String {
                let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                await MainActor.run {
                    self.currentEmail = cleanEmail
                    self.token = receivedToken
                    self.isLoggedIn = true
                }
                UserDefaults.standard.set(cleanEmail, forKey: currentEmailKey)
                UserDefaults.standard.set(receivedToken, forKey: tokenKey)
                return true
            }
        } catch {
            print("Innloggingsfeil:", error.localizedDescription)
        }
        return false
    }

    func logout() {
        currentEmail = nil
        token = nil
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: currentEmailKey)
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }

    func deleteCurrentUser() {
        logout()
    }
}
