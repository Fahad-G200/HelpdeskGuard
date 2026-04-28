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

    func hentSaker() {
        guard let url = URL(string: "http://172.20.128.20:3000/saker") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Feil:", error.localizedDescription)
                return
            }

            guard let data = data else {
                print("Ingen data fra server")
                return
            }

            if let json = String(data: data, encoding: .utf8) {
                print("Saker fra server:")
                print(json)
            }
        }.resume()
    }
}

