//
//  AuthStore.swift
//  HelpdeskGuard
//
//  Håndterer innlogging, registrering og JWT-token.
//  Prøver backend først – faller tilbake til lokal lagring hvis serveren er nede.
//

import Foundation
import Combine

final class AuthStore: ObservableObject {

    @Published var isLoggedIn: Bool = false
    @Published var currentEmail: String? = nil
    @Published var jwtToken: String? = nil   // JWT fra backend

    private let currentEmailKey = "helpdeskguard_currentEmail"
    private let jwtTokenKey     = "helpdeskguard_jwtToken"
    private let usersKey        = "helpdeskguard_users"   // Lokal fallback

    init() {
        // Gjenopprett innloggingstilstand fra forrige sesjon
        if let epost = UserDefaults.standard.string(forKey: currentEmailKey) {
            self.currentEmail = epost
            self.isLoggedIn = true
            self.jwtToken = UserDefaults.standard.string(forKey: jwtTokenKey)
        }
    }

    // ─────────────────────────────────────────────
    // REGISTRERING – prøver backend, faller tilbake til lokal
    // Returnerer true hvis vellykket
    // ─────────────────────────────────────────────
    func register(epost: String, passord: String) async -> Bool {
        let cleanEpost = epost.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        // Prøv backend
        let ok = await apiRegistrer(epost: cleanEpost, passord: passord)
        if ok { return true }

        // Fallback: lokal lagring (fungerer uten server)
        var brukere = localLoadUsers()
        if brukere[cleanEpost] != nil { return false }
        brukere[cleanEpost] = passord
        localSaveUsers(brukere)
        return true
    }

    // ─────────────────────────────────────────────
    // INNLOGGING – prøver backend, faller tilbake til lokal
    // Returnerer true hvis vellykket
    // ─────────────────────────────────────────────
    func login(epost: String, passord: String) async -> Bool {
        let cleanEpost = epost.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        // Prøv backend – hent JWT-token
        if let token = await apiLogginn(epost: cleanEpost, passord: passord) {
            jwtToken = token
            currentEmail = cleanEpost
            isLoggedIn = true
            UserDefaults.standard.set(cleanEpost, forKey: currentEmailKey)
            UserDefaults.standard.set(token, forKey: jwtTokenKey)
            return true
        }

        // Fallback: lokal innlogging (fungerer uten server)
        let brukere = localLoadUsers()
        guard let lagretPassord = brukere[cleanEpost], lagretPassord == passord else {
            return false
        }
        currentEmail = cleanEpost
        isLoggedIn = true
        UserDefaults.standard.set(cleanEpost, forKey: currentEmailKey)
        return true
    }

    // ─────────────────────────────────────────────
    // UTLOGGING
    // ─────────────────────────────────────────────
    func logout() {
        currentEmail = nil
        jwtToken = nil
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: currentEmailKey)
        UserDefaults.standard.removeObject(forKey: jwtTokenKey)
    }

    // ─────────────────────────────────────────────
    // SLETT BRUKER (lokal fallback)
    // ─────────────────────────────────────────────
    func deleteCurrentUser() {
        guard let epost = currentEmail else { return }
        var brukere = localLoadUsers()
        brukere.removeValue(forKey: epost)
        localSaveUsers(brukere)
        logout()
    }

    // ─── Hjelpemetoder for lokal lagring ───────────
    private func localLoadUsers() -> [String: String] {
        UserDefaults.standard.dictionary(forKey: usersKey) as? [String: String] ?? [:]
    }

    private func localSaveUsers(_ brukere: [String: String]) {
        UserDefaults.standard.set(brukere, forKey: usersKey)
    }
}
