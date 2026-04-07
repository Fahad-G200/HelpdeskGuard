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
                .dynamicTypeSize(.xSmall ... .accessibility5)
                .environmentObject(AuthStore())
                .environmentObject(TicketStore())
        }
        .modelContainer(for: TicketEntity.self)
    }
}


