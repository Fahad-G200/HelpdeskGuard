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
    
    private struct LoginResponse: Decodable {
        let token: String
        let epost: String?
    }

    init() {
        if let savedEmail = UserDefaults.standard.string(forKey: currentEmailKey),
           let savedToken = UserDefaults.standard.string(forKey: tokenKey) {
            self.currentEmail = savedEmail
            self.token = savedToken
            self.isLoggedIn = true
        }
    }

    func register(email: String, password: String) async -> (success: Bool, errorMessage: String?) {
        guard let url = URL(string: "\(baseURL)/registrer") else {
            return (false, "Ugyldig server-URL.")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["epost": email, "passord": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body) else {
            return (false, "Kunne ikke lage forespørsel.")
        }
        request.httpBody = httpBody
        
        print("URL:", url.absoluteString)
        print("Metode:", request.httpMethod ?? "")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode:", httpResponse.statusCode)
                print("response body:", String(data: data, encoding: .utf8) ?? "<ingen body>")
                
                if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                    return (true, nil)
                } else {
                    return (false, extractMessage(from: data) ?? "Registrering mislyktes. Prøv igjen.")
                }
            }
        } catch {
            print("Registreringsfeil:", error.localizedDescription)
        }
        return (false, "Kunne ikke nå serveren. Sjekk nettverkstilkoblingen.")
    }

    func login(email: String, password: String) async -> (success: Bool, errorMessage: String?) {
        guard let url = URL(string: "\(baseURL)/logginn") else {
            return (false, "Ugyldig server-URL.")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["epost": email, "passord": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body) else {
            return (false, "Kunne ikke lage forespørsel.")
        }
        request.httpBody = httpBody
        
        print("URL:", url.absoluteString)
        print("Metode:", request.httpMethod ?? "")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode:", httpResponse.statusCode)
                print("response body:", String(data: data, encoding: .utf8) ?? "<ingen body>")
                
                if httpResponse.statusCode == 200,
                   let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                    let cleanEmail = (loginResponse.epost ?? email).trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                    await MainActor.run {
                        self.currentEmail = cleanEmail
                        self.token = loginResponse.token
                        self.isLoggedIn = true
                    }
                    UserDefaults.standard.set(cleanEmail, forKey: currentEmailKey)
                    UserDefaults.standard.set(loginResponse.token, forKey: tokenKey)
                    return (true, nil)
                }
                
                return (false, extractMessage(from: data) ?? "Feil e-post eller passord. Prøv igjen.")
            }
        } catch {
            print("Innloggingsfeil:", error.localizedDescription)
        }
        return (false, "Kunne ikke nå serveren. Sjekk nettverkstilkoblingen.")
    }

    func logout() {
        currentEmail = nil
        token = nil
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: currentEmailKey)
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }

    func deleteCurrentUser() async -> (success: Bool, errorMessage: String?) {
        guard let token = self.token,
              let url = URL(string: "\(baseURL)/brukere/meg") else {
            return (false, "Du er ikke innlogget.")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("URL:", url.absoluteString)
        print("Metode:", request.httpMethod ?? "")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode:", httpResponse.statusCode)
                print("response body:", String(data: data, encoding: .utf8) ?? "<ingen body>")
                
                if httpResponse.statusCode == 200 || httpResponse.statusCode == 204 {
                    await MainActor.run { logout() }
                    return (true, nil)
                }
                
                return (false, extractMessage(from: data) ?? "Kunne ikke slette brukeren.")
            }
        } catch {
            print("Slettebruker-feil:", error.localizedDescription)
        }
        
        return (false, "Kunne ikke nå serveren. Sjekk nettverkstilkoblingen.")
    }
    
    private func extractMessage(from data: Data) -> String? {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        return json["message"] as? String ?? json["melding"] as? String
    }
}
