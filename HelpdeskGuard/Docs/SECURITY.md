# SECURITY – HelpdeskGuard (v1.1)

## Formål
Dette dokumentet beskriver sikkerhetsnivået i dagens prototype og avgrensninger.

## Dagens løsning
- Frontend/klient: iOS-app i SwiftUI
- Mellomledd: Node.js/Express backend på Ubuntu-server
- Database: MySQL `helpdeskguard` bak backend
- Kommunikasjon: REST API (`http://172.20.128.20:3000`)
- Appen kobler ikke direkte til MySQL

## Risikoer i prototypen
- Enkel autentisering og autorisasjon (videre arbeid nødvendig)
- Manglende HTTPS i testmiljø
- Begrenset feilhåndtering og logging

## Tiltak (videre arbeid)
- Innføre robust autentisering/autorisasjon for API
- Aktivere HTTPS og sikre transport
- Backup- og gjenopprettingsrutiner for MySQL
- Hardening av server (UFW, SSH, Fail2Ban) og overvåking

## Viktig avgrensning
Dette er en skoleprototype. Dokumentasjonen beskriver faktiske funksjoner og peker på konkrete forbedringer uten å overselge sikkerhetsnivå.
