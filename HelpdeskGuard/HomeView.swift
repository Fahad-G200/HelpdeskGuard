//
//  HomeView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 02/03/2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Dette er Hjem-siden")
            Text("Velkommen til HelpdeskGuard")
                .foregroundStyle(.secondary)
            
            Button("Opprett ny sak") { }
            
            // kommer senere
        }
    }
}

#Preview {
    HomeView()
}
