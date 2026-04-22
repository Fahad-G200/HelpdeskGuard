//
//  API.swift
//  HelpdeskGuard
//
//  Enkle funksjoner for nettverkskall mot Node.js-backend.
//  Bytт API_URL til maskinens LAN-IP ved bruk på fysisk iPhone.
//

import Foundation

// Basis-URL – fungerer i simulator (localhost), bytt til LAN-IP på enhet
let API_URL = "http://localhost:3000"

// ─────────────────────────────────────────────
// Registrer ny bruker – returnerer true hvis OK
// ─────────────────────────────────────────────
func apiRegistrer(epost: String, passord: String) async -> Bool {
    guard let url = URL(string: "\(API_URL)/registrer") else { return false }

    var req = URLRequest(url: url)
    req.httpMethod = "POST"
    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
    req.httpBody = try? JSONSerialization.data(withJSONObject: [
        "epost": epost,
        "passord": passord
    ])

    guard let (_, resp) = try? await URLSession.shared.data(for: req) else { return false }
    return (resp as? HTTPURLResponse)?.statusCode == 201
}

// ─────────────────────────────────────────────
// Logg inn – returnerer JWT-token, eller nil ved feil
// ─────────────────────────────────────────────
func apiLogginn(epost: String, passord: String) async -> String? {
    guard let url = URL(string: "\(API_URL)/logginn") else { return nil }

    var req = URLRequest(url: url)
    req.httpMethod = "POST"
    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
    req.httpBody = try? JSONSerialization.data(withJSONObject: [
        "epost": epost,
        "passord": passord
    ])

    guard
        let (data, resp) = try? await URLSession.shared.data(for: req),
        (resp as? HTTPURLResponse)?.statusCode == 200,
        let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
        let token = json["token"] as? String
    else { return nil }

    return token
}

// ─────────────────────────────────────────────
// Hent saker fra backend – returnerer liste av Ticket
// ─────────────────────────────────────────────
func apiHentSaker(token: String) async -> [Ticket] {
    guard let url = URL(string: "\(API_URL)/saker") else { return [] }

    var req = URLRequest(url: url)
    req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    guard
        let (data, _) = try? await URLSession.shared.data(for: req),
        let liste = try? JSONDecoder().decode([Ticket].self, from: data)
    else { return [] }

    return liste
}

// ─────────────────────────────────────────────
// Opprett ny sak – returnerer true hvis OK
// ─────────────────────────────────────────────
func apiOpprettSak(token: String, tittel: String, beskrivelse: String,
                   kategori: String, prioritet: String) async -> Bool {
    guard let url = URL(string: "\(API_URL)/saker") else { return false }

    var req = URLRequest(url: url)
    req.httpMethod = "POST"
    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
    req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    req.httpBody = try? JSONSerialization.data(withJSONObject: [
        "tittel": tittel,
        "beskrivelse": beskrivelse,
        "kategori": kategori,
        "prioritet": prioritet
    ])

    guard let (_, resp) = try? await URLSession.shared.data(for: req) else { return false }
    return (resp as? HTTPURLResponse)?.statusCode == 201
}
