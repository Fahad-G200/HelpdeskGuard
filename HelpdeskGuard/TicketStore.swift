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

    func addTicket(description: String) {
        let newTicket = Ticket(
            description: description,
            date: Date(),
            isResolved: false
        )
        tickets.append(newTicket)
    }
}
                                    

