//
//  TicketEntity.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 05/03/2026.
//

import Foundation
import SwiftData

@Model
final class TicketEntity {
    var id: UUID
    var descriptionText: String
    var date: Date
    var isResolved: Bool

    init(descriptionText: String, date: Date = .now, isResolved: Bool = false) {
        self.id = UUID()
        self.descriptionText = descriptionText
        self.date = date
        self.isResolved = isResolved
    }
}
