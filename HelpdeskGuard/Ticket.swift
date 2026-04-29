//
//  Ticket.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 03/03/2026.
//

import Foundation

struct Ticket: Identifiable, Codable {
    var id: Int
    var bruker_id: Int
    var tittel: String
    var beskrivelse: String
    var kategori: String?
    var prioritet: String?
    var er_lost: Int
    var opprettet: Date
}


