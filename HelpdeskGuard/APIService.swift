//
//  APIService.swift
//  HelpdeskGuard
//
//  Inneholder alle nettverksforespørsler mot Node.js-backend APIet.
//  Bytt ut baseURL nederst til IP-adressen der serveren din kjører.
//

import Foundation

// ---------------------------------------------------------------------------
// MARK: – Konfigurasjon
// ---------------------------------------------------------------------------

/// IP-adressen og porten til Node.js-serveren.
///
/// Bytt dette til din servers adresse:
///   - Simulator lokalt:   "http://localhost:3000"
///   - Fysisk iPhone:      "http://172.20.128.20:3000"  (serverens IP på nettverket)
///
/// Tips: Kjør `ipconfig getifaddr en0` (macOS) for å finne maskinens IP-adresse.
let baseURL = "http://172.20.128.20:3000"

// ---------------------------------------------------------------------------
// MARK: – Datamodeller
// ---------------------------------------------------------------------------

/// En helpdesk-sak slik den returneres fra API-et.
struct Sak: Identifiable, Decodable, Hashable {
    let id: Int
    let tittel: String
    let beskrivelse: String
    let kategori: String
    let prioritet: String
    let status: String
    let opprettet: String

    /// Forkorter datostring til ÅÅÅÅ-MM-DD for visning.
    var datoKort: String { String(opprettet.prefix(10)) }

    /// Sann hvis saken er markert som løst.
    var erLost: Bool { status == "Løst" }
}

/// Feil som kastes når et API-kall mislykkes.
struct APIFeil: Error {
    let melding: String
}

// ---------------------------------------------------------------------------
// MARK: – Privat hjelpefunksjon
// ---------------------------------------------------------------------------

/// Prøver å lese feilmeldingen som API-et returnerer i JSON-body.
private func lesAPIFeil(fra data: Data) -> String {
    let json = try? JSONSerialization.jsonObject(with: data) as? [String: String]
    return json?["melding"] ?? "Noe gikk galt"
}

// ---------------------------------------------------------------------------
// MARK: – API-funksjonar (public)
// ---------------------------------------------------------------------------

/// Registrerer en ny bruker.
/// Kaster `APIFeil` hvis e-posten allerede er i bruk eller noe annet feiler.
func apiRegistrer(epost: String, passord: String) async throws {
    let url = URL(string: "\(baseURL)/registrer")!
    var req = URLRequest(url: url)
    req.httpMethod = "POST"
    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
    req.httpBody = try JSONSerialization.data(withJSONObject: ["epost": epost, "passord": passord])

    let (data, response) = try await URLSession.shared.data(for: req)
    let kode = (response as? HTTPURLResponse)?.statusCode ?? 0

    if kode != 201 {
        throw APIFeil(melding: lesAPIFeil(fra: data))
    }
}

/// Logger inn og returnerer JWT-token.
/// Kaster `APIFeil` hvis e-post/passord er feil eller serveren ikke svarer.
func apiLoggInn(epost: String, passord: String) async throws -> String {
    let url = URL(string: "\(baseURL)/logginn")!
    var req = URLRequest(url: url)
    req.httpMethod = "POST"
    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
    req.httpBody = try JSONSerialization.data(withJSONObject: ["epost": epost, "passord": passord])

    let (data, response) = try await URLSession.shared.data(for: req)
    let kode = (response as? HTTPURLResponse)?.statusCode ?? 0

    if kode == 200 {
        struct Svar: Decodable { let token: String }
        let svar = try JSONDecoder().decode(Svar.self, from: data)
        return svar.token
    } else {
        throw APIFeil(melding: lesAPIFeil(fra: data))
    }
}

/// Henter alle saker for innlogget bruker.
/// Krever gyldig JWT-token.
func apiHentSaker(token: String) async throws -> [Sak] {
    let url = URL(string: "\(baseURL)/saker")!
    var req = URLRequest(url: url)
    req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let (data, response) = try await URLSession.shared.data(for: req)
    let kode = (response as? HTTPURLResponse)?.statusCode ?? 0

    if kode == 200 {
        return try JSONDecoder().decode([Sak].self, from: data)
    } else {
        throw APIFeil(melding: lesAPIFeil(fra: data))
    }
}

/// Oppretter en ny helpdesk-sak.
/// Krever gyldig JWT-token.
func apiOpprettSak(
    token: String,
    tittel: String,
    beskrivelse: String,
    kategori: String,
    prioritet: String
) async throws {
    let url = URL(string: "\(baseURL)/saker")!
    var req = URLRequest(url: url)
    req.httpMethod = "POST"
    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
    req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    req.httpBody = try JSONSerialization.data(withJSONObject: [
        "tittel": tittel,
        "beskrivelse": beskrivelse,
        "kategori": kategori,
        "prioritet": prioritet
    ])

    let (data, response) = try await URLSession.shared.data(for: req)
    let kode = (response as? HTTPURLResponse)?.statusCode ?? 0

    if kode != 201 {
        throw APIFeil(melding: lesAPIFeil(fra: data))
    }
}

/// Markerer en sak som løst.
/// Krever gyldig JWT-token og sak-ID.
func apiMarkerLost(token: String, sakId: Int) async throws {
    let url = URL(string: "\(baseURL)/saker/\(sakId)/lost")!
    var req = URLRequest(url: url)
    req.httpMethod = "PATCH"
    req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let (data, response) = try await URLSession.shared.data(for: req)
    let kode = (response as? HTTPURLResponse)?.statusCode ?? 0

    if kode != 200 {
        throw APIFeil(melding: lesAPIFeil(fra: data))
    }
}

/// Sletter innlogget bruker og alle dens saker (via CASCADE i databasen).
/// Krever gyldig JWT-token.
func apiSlettBruker(token: String) async throws {
    let url = URL(string: "\(baseURL)/brukere/meg")!
    var req = URLRequest(url: url)
    req.httpMethod = "DELETE"
    req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let (data, response) = try await URLSession.shared.data(for: req)
    let kode = (response as? HTTPURLResponse)?.statusCode ?? 0

    if kode != 200 {
        throw APIFeil(melding: lesAPIFeil(fra: data))
    }
}
