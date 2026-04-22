//
//  TicketStore.swift
//  HelpdeskGuard
//
//  Håndterer saker – henter fra backend og oppretter nye via API.
//

import Foundation
import Combine

class TicketStore: ObservableObject {
    @Published var tickets: [Ticket] = []
    @Published var laster: Bool = false   // Viser laste-indikator i UI

    // ─────────────────────────────────────────────
    // Hent alle saker fra backend
    // ─────────────────────────────────────────────
    func lastSaker(token: String) async {
        let saker = await apiHentSaker(token: token)
        await MainActor.run {
            self.tickets = saker
        }
    }

    // ─────────────────────────────────────────────
    // Opprett ny sak via backend
    // Returnerer true hvis vellykket
    // ─────────────────────────────────────────────
    func addTicket(token: String, tittel: String, beskrivelse: String,
                   kategori: String, prioritet: String) async -> Bool {
        await MainActor.run { self.laster = true }

        let ok = await apiOpprettSak(
            token: token,
            tittel: tittel,
            beskrivelse: beskrivelse,
            kategori: kategori,
            prioritet: prioritet
        )

        if ok {
            // Oppdater listen etter vellykket oppretting
            await lastSaker(token: token)
        }

        await MainActor.run { self.laster = false }
        return ok
    }
}