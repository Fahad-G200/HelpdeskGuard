//
//  TicketEntity.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 05/03/2026.
//

import Foundation
import SwiftData

// TicketEntity er databasemodellen – SwiftData lagrer dette lokalt på enheten
@Model
final class TicketEntity {
    var id: UUID
    var title: String
    var descriptionText: String
    var category: String
    var priority: String
    var date: Date
    var isResolved: Bool

    init(title: String, descriptionText: String, category: String = "Programvare", priority: String = "Vanlig") {
        self.id = UUID()
        self.title = title
        self.descriptionText = descriptionText
        self.category = category
        self.priority = priority
        self.date = Date()
        self.isResolved = false
    }
}
