//
//  Ticket.swift
//  HelpdeskGuard
//
//  Oppdatert for å matche backend-responsen fra Node.js/MySQL.
//

import Foundation

// Ticket-strukturen matcher feltene i 'saker'-tabellen i databasen.
// Codable gjør at Swift automatisk kan lese JSON fra backend.
struct Ticket: Identifiable, Codable {
    let id: Int              // Auto-increment ID fra MySQL
    var tittel: String       // Tittelen på saken
    var beskrivelse: String  // Beskrivelse av problemet
    var kategori: String     // F.eks. "Programvare", "Maskinvare"
    var prioritet: String    // F.eks. "Lav", "Normal", "Høy"
    var status: String       // "Åpen" eller "Løst"
    var opprettet: String    // Tidsstempel fra MySQL (som tekst)
}


