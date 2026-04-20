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
    var tittel: String
    var descriptionText: String
    var kategori: String
    var prioritet: String
    var date: Date
    var isResolved: Bool

    init(tittel: String, descriptionText: String, kategori: String, prioritet: String, date: Date = .now, isResolved: Bool = false) {
        self.id = UUID()
        self.tittel = tittel
        self.descriptionText = descriptionText
        self.kategori = kategori
        self.prioritet = prioritet
        self.date = date
        self.isResolved = isResolved
    }
}
