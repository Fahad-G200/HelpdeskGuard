# TODO – HelpdeskGuard

Versjon: 1.1  
Oppdatert: 2026-04-23

---

## ✅ Ferdig arbeid

- [x] Opprettet Git-repository og koblet til GitHub
- [x] Implementert TabView med fanene Hjem, Saker og Konto
- [x] Opprettet HomeView
- [x] Opprettet InfoView (personvern og regler)
- [x] Opprettet LoginView og RegisterView
- [x] Implementert innlogging og registrering av bruker
- [x] Implementert lokal lagring av bruker med UserDefaults (fallback)
- [x] Implementert mulighet for å logge ut
- [x] Implementert mulighet for å slette bruker
- [x] Opprettet NewTicketView (skjema for ny sak)
- [x] Implementert TextField og SecureField med @State-binding
- [x] Implementert NavigationStack og NavigationLink
- [x] Implementert hamburger-meny
- [x] Opprettet AppTheme, AppKort og AppFooter (UI-komponenter)
- [x] Backend: Node.js + Express + MySQL (server.js, schema.sql)
- [x] Backend: JWT-autentisering med bcrypt passord-hashing
- [x] Backend: rate limiting mot brute-force
- [x] Backend-integrasjon i iOS-app (API.swift)
- [x] AuthStore: henter og lagrer JWT-token fra backend
- [x] TicketStore: henter saker fra backend via JWT
- [x] NewTicketView: viser liste over egne saker fra MySQL
- [x] Markere sak som løst (knapp i saklisten, PATCH /saker/:id/lost)
- [x] Opprettet README.md, CHANGELOG.md, AI.md, TODO.md
- [x] Opprettet PLAN.md, USER_GUIDE.md, REFLEKSJON.md i Docs/
- [x] Opprettet RISIKOANALYSE.md, KRAVSPESIFIKASJON.md
- [x] Opprettet UML_DIAGRAM.md og INFRASTRUCTURE_DIAGRAM.md
- [x] Opprettet KOMPETANSEMAPPE.md
- [x] Opprettet GDPR.md
- [x] Opprettet ITIL_QUALITY.md
- [x] Opprettet TEST_RAPPORT.md
- [x] Opprettet LANGUAGE_COMPARISON.md
- [x] Dokumentert bruk av KI (AI.md)

---

## 🔄 Gjenstående arbeid

### Funksjonalitet
- [ ] Implementere HTTPS (SSL/TLS) i backend
- [ ] Legge til søk/filter i saklisten
- [ ] Legge til kommentarer på saker
- [ ] Admin-visning (se alle brukeres saker)

### Sikkerhet
- [ ] Bruke iOS Keychain for lagring av JWT i stedet for UserDefaults
- [ ] Lage plan for backup og database

### Drift
- [ ] Sette opp backend på Ubuntu Server (ikke bare lokalt)
- [ ] Konfigurere UFW-brannmur på server
- [ ] Sette opp Uptime Kuma overvåking
- [ ] Installere Fail2ban

### Dokumentasjon
- [ ] Oppdatere CHANGELOG etter hver arbeidsøkt
- [ ] Oppdatere README ved nye funksjoner
- [ ] Forberede presentasjon av prosjektet

---

## Versjon 1.1 status

Prosjektet har:
- Fungerende innlogging med JWT mot MySQL-backend
- Opprettelse og visning av saker fra MySQL
- Mulighet for å markere sak som løst
- Lokal fallback-modus uten server
- Fullstendig dokumentasjon av drift, brukerstøtte og utvikling
