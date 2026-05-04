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

## Personvern og GDPR
HelpdeskGuard behandler følgende personopplysninger i dagens løsning:
- E-postadresse (brukeridentitet)
- Passord-hash (ikke passord i klartekst)
- Helpdesk-saker (for eksempel tittel, beskrivelse, kategori, prioritet og tidspunkt)

Hvorfor bcrypt beskytter passord:
- bcrypt lagrer ikke passord i klartekst, men som hash
- bcrypt bruker salt, som gjør like passord ulike i databasen
- bcrypt er treg med vilje, som gjør brute-force og ordbokangrep vanskeligere

En reell GDPR-sjekkliste for denne typen applikasjon bør inkludere:
- Behandlingsgrunnlag og tydelig personvernerklæring
- Dataminimering (kun nødvendige data lagres)
- Rutiner for innsyn, retting og sletting
- Definerte lagringstider og sletting/arkivering
- Databehandleravtaler ved bruk av tredjeparter
- Tilgangsstyring og rollebasert tilgang
- Kryptering i transitt (HTTPS) og sikker lagring
- Avvikshåndtering og varsling ved brudd
- Risikoanalyse (DPIA ved behov)
- Logging og revisjonsspor for sikkerhetshendelser
