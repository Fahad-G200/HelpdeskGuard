//
//  TicketStore.swift
//  HelpdeskGuard
//
//  Håndterer sakslisten ved å hente og lagre data via backend-APIet.
//  Bruker `Sak`-modellen som er definert i APIService.swift.
//

import Foundation
import Combine

@MainActor
class TicketStore: ObservableObject {

    /// Sakene som vises i appen – hentet fra backend.
    @Published var saker: [Sak] = []

    /// Sann mens vi venter på svar fra serveren.
    @Published var isLoading: Bool = false

    /// Feilmelding som vises til bruker når noe går galt.
    @Published var feilmelding: String? = nil

    // -----------------------------------------------------------------------
    // MARK: – Hent saker
    // -----------------------------------------------------------------------

    /// Henter alle saker for innlogget bruker fra backend.
    func lastSaker(token: String) async {
        isLoading   = true
        feilmelding = nil

        do {
            saker = try await apiHentSaker(token: token)
        } catch let feil as APIFeil {
            feilmelding = feil.melding
        } catch {
            feilmelding = "Kunne ikke koble til serveren. Sjekk at backend kjører."
        }

        isLoading = false
    }

    // -----------------------------------------------------------------------
    // MARK: – Opprett sak
    // -----------------------------------------------------------------------

    /// Oppretter en ny sak via API og oppdaterer listen etterpå.
    /// Returnerer `nil` ved suksess, eller en feilmelding som kan vises til bruker.
    func opprettNySak(
        token: String,
        tittel: String,
        beskrivelse: String,
        kategori: String,
        prioritet: String
    ) async -> String? {
        do {
            try await apiOpprettSak(
                token: token,
                tittel: tittel,
                beskrivelse: beskrivelse,
                kategori: kategori,
                prioritet: prioritet
            )
            // Hent oppdatert liste etter at saken er lagret
            await lastSaker(token: token)
            return nil
        } catch let feil as APIFeil {
            return feil.melding
        } catch {
            return "Noe gikk galt. Prøv igjen."
        }
    }

    // -----------------------------------------------------------------------
    // MARK: – Marker som løst
    // -----------------------------------------------------------------------

    /// Markerer en sak som løst og oppdaterer listen.
    func markerLost(token: String, sakId: Int) async {
        do {
            try await apiMarkerLost(token: token, sakId: sakId)
            await lastSaker(token: token)
        } catch let feil as APIFeil {
            feilmelding = feil.melding
        } catch {
            feilmelding = "Kunne ikke markere saken som løst. Prøv igjen."
        }
    }
}
