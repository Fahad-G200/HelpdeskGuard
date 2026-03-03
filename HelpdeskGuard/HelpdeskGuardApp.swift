//
//  HelpdeskGuardApp.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 02/03/2026.
//

import SwiftUI

@main
struct HelpdeskGuardApp: App {

    @StateObject private var ticketStore = TicketStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ticketStore)
        }
    }
}


