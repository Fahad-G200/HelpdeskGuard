//
//  AuthStore.swift
//  HelpdeskGuard
//
//  Håndterer innlogging og registrering via backend-APIet.
//  JWT-token lagres i UserDefaults slik at brukeren forblir innlogget
//  selv etter at appen lukkes og åpnes igjen.
//

import Foundation
import Combine

@MainActor
final class AuthStore: ObservableObject {

    @Published var isLoggedIn: Bool = false
    @Published var currentEmail: String? = nil
    @Published var isLoading: Bool = false

    /// Token brukes av alle API-kall som krever autentisering.
    private(set) var token: String? = nil

    private let tokenNokkel = "helpdeskguard_token"
    private let epostNokkel = "helpdeskguard_epost"

    init() {
        // Gjenopprett sesjon fra forrige gang appen ble brukt
        token        = UserDefaults.standard.string(forKey: tokenNokkel)
        currentEmail = UserDefaults.standard.string(forKey: epostNokkel)
        isLoggedIn   = token != nil
    }

    // -----------------------------------------------------------------------
    // MARK: – Innlogging
    // -----------------------------------------------------------------------

    /// Logger inn mot backend.
    /// Returnerer `nil` ved suksess, eller en feilmelding som kan vises til bruker.
    func loggInn(epost: String, passord: String) async -> String? {
        isLoading = true
        defer { isLoading = false }

        do {
            let nyttToken = try await apiLoggInn(epost: epost, passord: passord)
            let renEpost = epost.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

            token        = nyttToken
            currentEmail = renEpost
            isLoggedIn   = true

            UserDefaults.standard.set(nyttToken, forKey: tokenNokkel)
            UserDefaults.standard.set(renEpost,  forKey: epostNokkel)

            return nil

        } catch let feil as APIFeil {
            return feil.melding
        } catch {
            return "Kunne ikke koble til serveren. Sjekk at backend kjører på \(baseURL)."
        }
    }

    // -----------------------------------------------------------------------
    // MARK: – Registrering
    // -----------------------------------------------------------------------

    /// Registrerer ny bruker og logger automatisk inn etterpå.
    /// Returnerer `nil` ved suksess, eller en feilmelding som kan vises til bruker.
    func registrer(epost: String, passord: String) async -> String? {
        isLoading = true
        defer { isLoading = false }

        do {
            try await apiRegistrer(epost: epost, passord: passord)
            // Logg inn automatisk etter vellykket registrering
            return await loggInn(epost: epost, passord: passord)
        } catch let feil as APIFeil {
            return feil.melding
        } catch {
            return "Noe gikk galt. Sjekk nettverkstilkoblingen."
        }
    }

    // -----------------------------------------------------------------------
    // MARK: – Utlogging og sletting
    // -----------------------------------------------------------------------

    /// Logger ut brukeren og fjerner lagret sesjon.
    func loggUt() {
        token        = nil
        currentEmail = nil
        isLoggedIn   = false
        UserDefaults.standard.removeObject(forKey: tokenNokkel)
        UserDefaults.standard.removeObject(forKey: epostNokkel)
    }

    /// Sletter bruker via API og logger ut ved suksess.
    /// Returnerer `nil` ved suksess, eller en feilmelding som kan vises til bruker.
    func slettKonto() async -> String? {
        guard let token = token else { return "Ikke innlogget" }
        isLoading = true
        defer { isLoading = false }

        do {
            try await apiSlettBruker(token: token)
            loggUt()
            return nil
        } catch let feil as APIFeil {
            return feil.melding
        } catch {
            return "Kunne ikke slette brukeren. Prøv igjen."
        }
    }
}

