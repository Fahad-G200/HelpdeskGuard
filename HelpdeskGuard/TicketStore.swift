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

    private let baseURL = "http://172.20.128.20:3000"

    func hentSaker(token: String) async -> (success: Bool, errorMessage: String?) {
        guard let url = URL(string: "\(baseURL)/saker") else {
            return (false, "Ugyldig server-URL.")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        print("URL:", url.absoluteString)
        print("Metode:", request.httpMethod ?? "")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode:", httpResponse.statusCode)
                print("response body:", String(data: data, encoding: .utf8) ?? "<ingen body>")
                
                if httpResponse.statusCode == 200 {
                    let decoder = JSONDecoder()
                    if let hentetSaker = try? decoder.decode([Ticket].self, from: data) {
                        await MainActor.run {
                            self.tickets = hentetSaker
                        }
                        return (true, nil)
                    }
                    return (false, "Kunne ikke tolke sakene fra serveren.")
                }
                
                return (false, extractMessage(from: data) ?? "Kunne ikke hente saker.")
            }
        } catch {
            print("Feil:", error.localizedDescription)
        }
        
        return (false, "Kunne ikke nå serveren. Sjekk nettverkstilkoblingen.")
    }

    func opprettSak(tittel: String, beskrivelse: String, kategori: String, prioritet: String, token: String) async -> (success: Bool, errorMessage: String?) {
        guard let url = URL(string: "\(baseURL)/saker") else {
            return (false, "Ugyldig server-URL.")
        }

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
                    _ = await hentSaker(token: token)
                    return (true, nil)
                }
                
                return (false, extractMessage(from: data) ?? "Kunne ikke sende inn saken.")
            }
        } catch {
            print("Feil ved opprettelse av sak:", error.localizedDescription)
        }
        return (false, "Kunne ikke nå serveren. Sjekk nettverkstilkoblingen.")
    }
    
    func clearTickets() {
        tickets = []
    }
    
    private func extractMessage(from data: Data) -> String? {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        return json["message"] as? String ?? json["melding"] as? String
    }
}
