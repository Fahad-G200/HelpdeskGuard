//
//  HelpdeskGuardApp.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 02/03/2026.
//

import SwiftUI
import SwiftData

@main
struct HelpdeskGuardApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TicketEntity.self)
    }
}


