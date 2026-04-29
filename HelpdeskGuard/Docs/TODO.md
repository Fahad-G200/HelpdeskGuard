# TODO – HelpdeskGuard

Versjon: 1.1  
Prosjektperiode: Mars–April 2026

## Ferdig
- Opprettet Git-repository og koblet til GitHub
- Implementert grunnleggende SwiftUI-struktur (TabView, NavigationStack)
- Login/Registrering (prototypisk)
- Opprettelse av sak (skjema, validering)
- Dokumentasjon oppdatert for gjeldende arkitektur
- Backend satt opp på server (Node.js/Express)
- MySQL-database på server (helpdeskguard)
- API-endepunkt `/saker` tilgjengelig
- Helsesjekk `/health` bekrefter backend + databasekobling
- Testet med curl fra server og Mac
- Ryddet opp i `server.js` (fjernet dobbelt app.listen)

## Gjenstår
- Koble appens datavisning i Xcode til backend-API (hente og vise saker via `http://172.20.128.20:3000/saker`)
- Erstatte eventuell prototypisk lokal lagring i appen med API-basert flyt
- Autentisering/autorisasjon i backend og app
- HTTPS (sertifikat og konfigurasjon)
- Backup-plan og databasevedlikehold
- Forbedret feilhåndtering i klient og server

## Mulige forbedringer
- Egen feilsøkingsvisning i appen (nettverk, API-status)
- Admin-/agentvisninger for sakshåndtering
- Logging/monitorering av backend (Uptime Kuma eller lignende)
- CI for bygg og enkle tester
- Ytterligere dokumentasjonseksempler (Postman-kolleksjon)

## Notater
- Riktig API-baseadresse: `http://172.20.128.20:3000`
- Arkitektur: SwiftUI (frontend) → Node.js/Express (backend) → MySQL (helpdeskguard)
