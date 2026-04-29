# HelpdeskGuard
Versjon 1.1  
Prosjektperiode: Mars–April 2026

## Introduksjon
HelpdeskGuard er et tverrfaglig skoleprosjekt (VG2 IT) som demonstrerer en helpdesk-løsning med iOS-klient, Node.js/Express-backend og MySQL-database. Prosjektet dokumenterer også plan, risiko, drift og refleksjon.

## Arkitektur (dagens løsning)
- Frontend/klient: SwiftUI-app i Xcode
- Mellomledd: Node.js / Express backend (kjører på Ubuntu-server)
- Database: MySQL på samme server, database-navn: `helpdeskguard`
- Kommunikasjon: REST API mellom app og backend
- Viktig: iOS-appen kobler ikke direkte til MySQL

Flyt:
