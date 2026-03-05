//
//  Ticket.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 03/03/2026.
//

import Foundation

struct Ticket: Identifiable {
    let id = UUID()
    var description: String
    var date: Date
    var isResolved: Bool
}


