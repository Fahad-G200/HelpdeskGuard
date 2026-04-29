//
//  Ticket.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 03/03/2026.
//

import Foundation

struct Ticket: Identifiable, Codable {
    var id: UUID
    var description: String
    var date: Date
    var isResolved: Bool

    init(id: UUID = UUID(), description: String, date: Date = Date(), isResolved: Bool = false) {
        self.id = id
        self.description = description
        self.date = date
        self.isResolved = isResolved
    }
}


