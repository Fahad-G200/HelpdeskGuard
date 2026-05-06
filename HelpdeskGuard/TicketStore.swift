//
//  TicketStore.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 03/03/2026.
//

import Foundation
import Combine

class TicketStore: ObservableObject {
    @Published var tickets: [Ticket] = []

    private let baseURL = "http://localhost:3000"

    func hentSaker(token: String) {
        guard let url = URL(string: "\(baseURL)/saker") else { return }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Feil:", error.localizedDescription)
                return
            }

            guard let data = data else {
                print("Ingen data fra server")
                return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let hentetSaker = try? decoder.decode([Ticket].self, from: data) {
                DispatchQueue.main.async {
                    self.tickets = hentetSaker
                }
            } else if let json = String(data: data, encoding: .utf8) {
                print("Saker fra server:")
                print(json)
            }
        }.resume()
    }

    func opprettSak(tittel: String, beskrivelse: String, kategori: String, prioritet: String, token: String) async -> Bool {
        guard let url = URL(string: "\(baseURL)/saker") else { return false }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let body: [String: String] = [
            "tittel": tittel,
            "beskrivelse": beskrivelse,
            "kategori": kategori,
            "prioritet": prioritet
        ]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body) else { return false }
        request.httpBody = httpBody

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                hentSaker(token: token)
                return true
            }
        } catch {
            print("Feil ved opprettelse av sak:", error.localizedDescription)
        }
        return false
    }
}

