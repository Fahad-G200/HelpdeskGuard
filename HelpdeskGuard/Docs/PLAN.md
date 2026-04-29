# PLAN – HelpdeskGuard (v1.1)

## Mål
Bygge en stabil skoleprototype av et helpdesk-system med tydelig dokumentasjon for utvikling, drift og brukerstøtte.

## Arkitektur og avgrensning
- Frontend/klient: SwiftUI-app i Xcode
- Mellomledd: Node.js/Express backend på Ubuntu-server
- Database: MySQL (database: `helpdeskguard`)
- Kommunikasjon: REST API – appen kobler ikke direkte til MySQL
- API-baseadresse: `http://172.20.128.20:3000`

## Milepæler
1. M1 – Grunnstruktur i app (SwiftUI, navigasjon, basisvisninger)
2. M2 – Brukerflyt (registrering, innlogging, enkel kontohåndtering)
3. M3 – Saker (opprettelse av sak med validering)
4. M4 – Dokumentasjon og kvalitet (README, CHANGELOG, brukerveiledning, refleksjon)
5. M5 – Videreutvikling (saksliste via backend, sikkerhet, driftstiltak)

## Tidslinje (oversikt)
- Uke 10–11: M1–M2
- Uke 12: M3
- Uke 13–14: M4
- Uke 15+: M5

## Kobling til kompetansemål (ITK02)
- Drift: planlegging, dokumentasjon, informasjonssikkerhet
- Brukerstøtte: sakshåndtering, brukerveiledning, tydelig kommunikasjon
- Utvikling: kravforståelse, implementasjon i SwiftUI, versjonskontroll med Git

## Leveranser
- Kjørbar iOS-app (prototype)
- Backend som kjører på server og eksponerer REST-API
- MySQL-database `helpdeskguard`
- Oppdatert dokumentasjon i repository

## Status og videre arbeid
- Ferdig: appstruktur, brukerflyt (prototypisk), opprettelse av sak, backend og database, `/health` og `/saker`
- Gjenstår: hente og vise saker i appen via API, auth/HTTPS, backup og forbedret feilhåndtering
