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
    @Published var lastErrorMessage: String? = nil

    private let ticketsKey = "helpdeskguard_tickets"

    init() {
        loadTickets()
    }

    func addTicket(title: String, description: String, category: String, priority: String) -> Bool {
        let cleanTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanDescription = description.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !cleanTitle.isEmpty, !cleanDescription.isEmpty else {
            lastErrorMessage = "Tittel og beskrivelse må fylles ut."
            return false
        }

        let newTicket = Ticket(
            title: cleanTitle,
            description: cleanDescription,
            category: category,
            priority: priority
        )
        tickets.append(newTicket)
        if saveTickets() {
            lastErrorMessage = nil
            return true
        }

        tickets.removeLast()
        return false
    }

    func ticket(for id: UUID) -> Ticket? {
        tickets.first(where: { $0.id == id })
    }

    func markTicketAsResolved(id: UUID) {
        guard let index = tickets.firstIndex(where: { $0.id == id }) else { return }
        let previousValue = tickets[index].isResolved
        tickets[index].isResolved = true
        if !saveTickets() {
            tickets[index].isResolved = previousValue
        }
    }

    @discardableResult
    private func saveTickets() -> Bool {
        do {
            let encoded = try JSONEncoder().encode(tickets)
            UserDefaults.standard.set(encoded, forKey: ticketsKey)
            lastErrorMessage = nil
            return true
        } catch {
            let message = "Kunne ikke lagre saker: \(error.localizedDescription)"
            lastErrorMessage = message
            print(message)
            return false
        }
    }

    private func loadTickets() {
        guard let data = UserDefaults.standard.data(forKey: ticketsKey) else {
            tickets = []
            lastErrorMessage = nil
            return
        }

        do {
            tickets = try JSONDecoder().decode([Ticket].self, from: data)
            lastErrorMessage = nil
        } catch {
            let message = "Kunne ikke lese lagrede saker: \(error.localizedDescription)"
            lastErrorMessage = message
            print(message)
            tickets = []
        }
    }
}
                                    
