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
    private let ticketsKey = "helpdeskguard_tickets_v2"

    init() {
        loadTickets()
    }

    func addTicket(title: String, description: String, category: String, priority: String) -> Bool {
        let cleanTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanDescription = description.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !cleanTitle.isEmpty, !cleanDescription.isEmpty else {
            return false
        }

        let newTicket = Ticket(
            title: cleanTitle,
            description: cleanDescription,
            category: category,
            priority: priority
        )
        tickets.append(newTicket)
        saveTickets()
        return true
    }

    func ticket(for id: UUID) -> Ticket? {
        tickets.first(where: { $0.id == id })
    }

    func markTicketAsResolved(id: UUID) {
        guard let index = tickets.firstIndex(where: { $0.id == id }) else { return }
        tickets[index].isResolved = true
        saveTickets()
    }

    private func saveTickets() {
        guard let encoded = try? JSONEncoder().encode(tickets) else { return }
        UserDefaults.standard.set(encoded, forKey: ticketsKey)
    }

    private func loadTickets() {
        guard
            let data = UserDefaults.standard.data(forKey: ticketsKey),
            let decoded = try? JSONDecoder().decode([Ticket].self, from: data)
        else {
            tickets = []
            return
        }

        tickets = decoded
    }
}
                                    
