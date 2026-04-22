HelpdeskGuard/
├── HelpdeskGuardApp.swift        # Starter appen og setter opp TicketStore
├── ContentView.swift             # Hovednavigasjon (TabView mellom sider)
│
├── Models/
│   └── Ticket.swift              # Datamodell for en sak (id, description, date, status)
│
├── Store/
│   └── TicketStore.swift         # Lagrer og administrerer alle saker i appen
│
├── Views/
│   ├── HomeView.swift            # Hjem-siden med informasjon og knapp for ny sak
│   ├── NewTicketView.swift       # Skjerm for å opprette en ny sak
│   └── TicketsView.swift         # Liste over registrerte saker
│
├── Assets.xcassets               # App-ikoner og bilder
│
├── Preview Content/
│   └── Preview Assets.xcassets   # Assets brukt i SwiftUI previews
│
└── Info.plist                    # Konfigurasjon for iOS-applikasjonen
