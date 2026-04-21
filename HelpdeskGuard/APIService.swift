//
//  APIService.swift
//  HelpdeskGuard
//
//  Håndterer alle HTTP-forespørsler mot backend-APIet (Node.js + MySQL).
//  Saker og brukere lagres i MySQL-databasen via REST-endepunktene.
//
//  Dataflyt:  SwiftUI  →  APIService  →  Node.js (server.js)  →  MySQL
//

import Foundation

// Representerer en sak hentet fra MySQL-databasen via API
struct Sak: Identifiable, Decodable {
    let id: Int
    let bruker_id: Int
    let tittel: String
    let beskrivelse: String
    let kategori: String
    let prioritet: String
    let er_lost: Bool
    let opprettet: String
}

// Feiltyper som kan oppstå i API-kall
enum APIFeil: Error, LocalizedError {
    case ikkeAutentisert
    case serverFeil(String)
    case nettverksfeil

    var errorDescription: String? {
        switch self {
        case .ikkeAutentisert:
            return "Du er ikke logget inn. Prøv å logge inn på nytt."
        case .serverFeil(let melding):
            return melding
        case .nettverksfeil:
            return "Kunne ikke nå serveren. Sjekk at backend kjører."
        }
    }
}

final class APIService {
    static let shared = APIService()
    private init() {}

    // Adressen til Node.js-serveren. Bytt til maskinens IP ved test på fysisk iPhone.
    private let baseURL = "http://localhost:3000"

    private let tokenNøkkel = "helpdeskguard_token"
    private let epostNøkkel = "helpdeskguard_epost"

    var token: String? {
        get { UserDefaults.standard.string(forKey: tokenNøkkel) }
        set { UserDefaults.standard.set(newValue, forKey: tokenNøkkel) }
    }

    var lagretEpost: String? {
        get { UserDefaults.standard.string(forKey: epostNøkkel) }
        set { UserDefaults.standard.set(newValue, forKey: epostNøkkel) }
    }

    func loggUt() {
        token = nil
        lagretEpost = nil
    }

    // MARK: - Registrer ny bruker (POST /registrer)
    // Passordet sendes én gang og lagres som bcrypt-hash i MySQL. Det lagres aldri i appen.
    func registrer(epost: String, passord: String) async throws {
        guard let url = URL(string: "\(baseURL)/registrer") else {
            throw APIFeil.nettverksfeil
        }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONSerialization.data(withJSONObject: [
            "epost": epost.lowercased(),
            "passord": passord
        ])

        let (data, response) = try await URLSession.shared.data(for: req)
        let statusKode = (response as? HTTPURLResponse)?.statusCode ?? 0
        let svar = (try? JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
        let melding = svar["melding"] as? String ?? "Ukjent feil fra serveren."

        if statusKode == 409 {
            throw APIFeil.serverFeil("E-postadressen er allerede registrert.")
        }
        if statusKode != 201 {
            throw APIFeil.serverFeil(melding)
        }
    }

    // MARK: - Logg inn (POST /logginn)
    // Returnerer brukerens e-post og lagrer JWT-token lokalt.
    func logginn(epost: String, passord: String) async throws -> String {
        guard let url = URL(string: "\(baseURL)/logginn") else {
            throw APIFeil.nettverksfeil
        }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONSerialization.data(withJSONObject: [
            "epost": epost.lowercased(),
            "passord": passord
        ])

        let (data, response) = try await URLSession.shared.data(for: req)
        let statusKode = (response as? HTTPURLResponse)?.statusCode ?? 0
        let svar = (try? JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
        let melding = svar["melding"] as? String ?? "Ukjent feil fra serveren."

        if statusKode == 401 {
            throw APIFeil.serverFeil("Feil e-post eller passord.")
        }
        if statusKode != 200 {
            throw APIFeil.serverFeil(melding)
        }
        guard let t = svar["token"] as? String else {
            throw APIFeil.serverFeil("Serveren returnerte ingen token.")
        }

        let returEpost = svar["epost"] as? String ?? epost
        token = t
        lagretEpost = returEpost
        return returEpost
    }

    // MARK: - Send inn ny sak til MySQL (POST /saker)
    // bruker_id hentes fra JWT-token på serveren – klienten sender den ikke.
    func sendSak(tittel: String, beskrivelse: String, kategori: String, prioritet: String) async throws {
        guard let t = token else { throw APIFeil.ikkeAutentisert }
        guard let url = URL(string: "\(baseURL)/saker") else {
            throw APIFeil.nettverksfeil
        }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer \(t)", forHTTPHeaderField: "Authorization")
        req.httpBody = try JSONSerialization.data(withJSONObject: [
            "tittel": tittel,
            "beskrivelse": beskrivelse,
            "kategori": kategori,
            "prioritet": prioritet
        ])

        let (data, response) = try await URLSession.shared.data(for: req)
        let statusKode = (response as? HTTPURLResponse)?.statusCode ?? 0
        if statusKode == 401 { throw APIFeil.ikkeAutentisert }
        if statusKode != 201 {
            let svar = (try? JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
            let melding = svar["melding"] as? String ?? "Ukjent feil fra serveren."
            throw APIFeil.serverFeil(melding)
        }
    }

    // MARK: - Hent saker fra MySQL (GET /saker)
    // Returnerer bare sakene som tilhører den innloggede brukeren.
    func hentSaker() async throws -> [Sak] {
        guard let t = token else { throw APIFeil.ikkeAutentisert }
        guard let url = URL(string: "\(baseURL)/saker") else {
            throw APIFeil.nettverksfeil
        }
        var req = URLRequest(url: url)
        req.setValue("Bearer \(t)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: req)
        let statusKode = (response as? HTTPURLResponse)?.statusCode ?? 0
        if statusKode == 401 { throw APIFeil.ikkeAutentisert }
        if statusKode != 200 {
            throw APIFeil.serverFeil("Kunne ikke hente saker fra serveren.")
        }

        return try JSONDecoder().decode([Sak].self, from: data)
    }

    // MARK: - Marker sak som løst (PATCH /saker/:sak_id/lost)
    func markerSomLost(sakId: Int) async throws {
        guard let t = token else { throw APIFeil.ikkeAutentisert }
        guard let url = URL(string: "\(baseURL)/saker/\(sakId)/lost") else {
            throw APIFeil.nettverksfeil
        }
        var req = URLRequest(url: url)
        req.httpMethod = "PATCH"
        req.setValue("Bearer \(t)", forHTTPHeaderField: "Authorization")

        let (_, response) = try await URLSession.shared.data(for: req)
        let statusKode = (response as? HTTPURLResponse)?.statusCode ?? 0
        if statusKode == 401 { throw APIFeil.ikkeAutentisert }
    }

    // MARK: - Slett egen konto (DELETE /brukere/meg)
    func slettKonto() async throws {
        guard let t = token else { throw APIFeil.ikkeAutentisert }
        guard let url = URL(string: "\(baseURL)/brukere/meg") else {
            throw APIFeil.nettverksfeil
        }
        var req = URLRequest(url: url)
        req.httpMethod = "DELETE"
        req.setValue("Bearer \(t)", forHTTPHeaderField: "Authorization")

        let (_, response) = try await URLSession.shared.data(for: req)
        let statusKode = (response as? HTTPURLResponse)?.statusCode ?? 0
        if statusKode == 401 { throw APIFeil.ikkeAutentisert }
        if statusKode != 200 {
            throw APIFeil.serverFeil("Kunne ikke slette konto.")
        }
        loggUt()
    }
}
