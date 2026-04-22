//
//  Ticket.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 03/03/2026.
//

import Foundation

struct Ticket: Identifiable, Codable {
    var id: UUID
    var title: String
    var description: String
    var category: String
    var priority: String
    var date: Date
    var isResolved: Bool

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        category: String,
        priority: String,
        date: Date = Date(),
        isResolved: Bool = false
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.priority = priority
        self.date = date
        self.isResolved = isResolved
    }
}

