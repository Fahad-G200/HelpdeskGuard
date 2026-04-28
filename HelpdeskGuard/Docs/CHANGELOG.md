Endringslogg

Alle endringer loggføres fortløpende for å dokumentere utviklingen av prosjektet. Datoer er i formatet ÅÅÅÅ-MM-DD.


2026-04-28
    •    Koblet iOS-appen til Node.js/Express-backend via URLSession (HTTP + JWT).
    •    Opprettet HelpdeskGuard/APIService.swift med alle nettverksfunksjoner:
         apiRegistrer, apiLoggInn, apiHentSaker, apiOpprettSak, apiMarkerLost, apiSlettBruker.
    •    Skrevet om AuthStore.swift: bruker nå bcrypt-sikret backend i stedet for klartekst i UserDefaults.
    •    Skrevet om TicketStore.swift: holder [Sak]-liste fra backend i stedet for lokal in-memory-liste.
    •    Oppdatert NewTicketView.swift: henter og viser ekte saker fra databasen, inkludert «Marker som løst».
    •    Oppdatert LoginView.swift og RegisterView.swift med async/await og loading-spinner.
    •    Oppdatert ContentView.swift: sletting av bruker er nå async og går via API.
    •    Fikset /health-endepunkt i server.js: pinger nå databasen og svarer {"status":"ok","database":"tilkoblet"}.
    •    Lagt til try-catch rundt bcrypt.hash i /registrer-endepunktet i server.js.
    •    Oppdatert backend/README.md med korrekte JWT-baserte curl-eksempler.
    •    Lagt til Info.plist med NSAppTransportSecurity for å tillate HTTP-tilkoblinger til lokal server.
    •    Opprettet README.md i prosjektroten (GitHub-forsiden) med arkitekturbeskrivelse og kompetansemål.
    •    Opprettet .gitignore i prosjektroten.
    •    KI brukt som støtte til strukturering og koding. All kode er gjennomgått og forstått av utvikler.



    •    Opprettet backend/-mappe i prosjektroten med fullstendig Node.js + Express + MySQL backend.
    •    Lagt til backend/server.js med alle API-endepunkter (registrer, logginn, saker, løst, slett bruker).
    •    Lagt til backend/schema.sql med CREATE DATABASE helpdeskguard og tabellene brukere og saker.
    •    Lagt til backend/package.json med avhengigheter: express, mysql2, bcrypt, dotenv.
    •    Lagt til backend/.env.example – databaseopplysninger lagres nå i .env og committes ikke til Git.
    •    Lagt til backend/.gitignore som ekskluderer node_modules/ og .env.
    •    Lagt til backend/README.md med oppsettsinstruksjoner og curl-eksempler for alle endepunkter.
    •    Fjernet hardkodet databasepassord – all konfigurasjon leses fra miljøvariabler via dotenv.
    •    KI brukt som støtte til strukturering og dokumentasjon. Alt er gjennomgått og forstått av utvikler.


2026-04-10
    •    Forbedret prosjektdokumentasjonen for bedre faglig sammenheng og vurderingsgrunnlag (VG2 IT).
    •    Oppdatert README.md med profesjonell introduksjon, "Hvordan kjøre prosjektet", tydelig teknologivalg og prosjektstruktur.
    •    Lagt til og oppdatert lenker til dokumentasjon i Docs-mappen i README.md.
    •    Revidert Docs/REFLEKSJON.md med dypere begrunnelser for utfordringer, tekniske valg og læringsutbytte.
    •    Oppdatert Docs/RISIKOANALYSE.md med prosjektnær vurdering og direkte kobling til risiko i appen (klartekstpassord og lokal lagring uten backup).
    •    Justert Docs/KRAVSPESIFIKASJON.md og Docs/USER_GUIDE.md for samsvar med faktisk funksjonalitet i versjon 1.0.
    •    Ryddet og harmonisert sikkerhets-/driftsdokumentasjon (SECURITY.md, DRIFT_SETUP.md, server-hardening.md) for bedre etterprovbarhet.
    •    Lagt til Docs/KOMPETANSEMAPPE.md for tydelig kobling mellom kompetansemal, arbeid og bevis.
    •    Ingen endringer i Swift-kode, app-logikk eller backend i denne oppdateringen.

2026-04-07
    •    Forbedret tilgjengelighet (WCAG) med målrettede endringer i kontrast og beskrivelser.
    •    Endret primærfarge i AppTheme.swift til Color(red: 0.0, green: 0.24, blue: 0.55) for bedre kontrast.
    •    Endret sekundærfarge i AppTheme.swift til mørkere grønn for bedre kontrast.
    •    Lagt til ny danger-farge og brukt den for feilmeldinger og destruktive handlinger.
    •    Lagt til accessibilityLabel/accessibilityHint på inputfelter (e-post, passord, tittel og beskrivelse).
    •    Lagt til accessibilityLabel på kategori- og prioritet-velgere.
    •    Ingen endringer i app-logikk, navigasjon eller layout.

2026-03-02
    •    Opprettet Git-repository og satt opp grunnstrukturen til iOS-prosjektet.
    •    Implementerte ContentView med TabView og to faner: Hjem og Saker.
    •    Opprettet HomeView med velkomsttekst og enkel struktur.
    •    La til NavigationLink fra Hjem til NewTicketView (Ny sak).
    •    Opprettet NewTicketView og la til TextField med binding til @State description slik at teksten brukeren skriver lagres i appen.


2026-03-03

Prosjektopprettelse
    •    Opprettet nytt SwiftUI-prosjekt i Xcode med navnet HelpdeskGuard.
    •    Satt opp grunnstruktur for applikasjonen i SwiftUI.

Dokumentasjon
    •    Opprettet følgende prosjektfiler:
    •    README.md
    •    CHANGELOG.md
    •    TODO.md
    •    AI.md
    •    Filene brukes til dokumentasjon av prosjektet, endringer og bruk av AI i utviklingen.

Datamodell
    •    Opprettet Ticket-struktur for å representere en sak i systemet.
    •    La til følgende egenskaper:
    •    id – unik identifikator
    •    description – beskrivelse av problemet
    •    date – dato saken ble opprettet
    •    isResolved – status for om saken er løst

State Management
    •    Opprettet TicketStore for håndtering av lagring og administrasjon av saker.
    •    Implementert funksjon for å legge til nye saker i systemet.

Brukergrensesnitt
    •    Opprettet HomeView som startside for applikasjonen.
    •    La til:
    •    Tittel på applikasjonen
    •    Kort forklaring til brukeren
    •    Knapp for å opprette ny sak

Navigasjon
    •    Implementert NavigationStack for navigasjon mellom skjermer.
    •    Lagt til NavigationLink fra hjemsiden til siden for opprettelse av saker.

Opprettelse av saker
    •    Opprettet NewTicketView.
    •    Implementert:
    •    Tekstfelt for å skrive beskrivelse av problemet
    •    Button (“Lagre sak”) for å opprette en ny ticket

Saksoversikt
    •    Opprettet TicketsView for å vise registrerte saker.
    •    Implementert List for å vise saker i en oversikt.

Forbedring av visning
    •    Endret visning av tickets slik at kun relevant informasjon vises.
    •    Fjernet rå Ticket-debugtekst fra listen.

UI-struktur
    •    Implementert TabView for navigasjon mellom:
    •    Hjem
    •    Saker

Designforbedringer
    •    Forbedret layout på hjemsiden med:
    •    bedre spacing
    •    tydeligere knapper
    •    bedre tekststruktur

Debugging og feilretting
    •    Rettet flere SwiftUI-feil relatert til:
    •    List
    •    ForEach
    •    Binding vs vanlig data
    •    feil i initialisering av Text

Testing
    •    Testet applikasjonen i iOS Simulator.
    •    Testet applikasjonen på fysisk iPhone via Xcode.

Signering og utviklingsoppsett
    •    Logget inn med Apple-ID i Xcode.
    •    Aktivert Automatically manage signing.
    •    Konfigurert Apple Development certificate.
    •    Aktivert Developer Mode på iPhone.
    •    Installert og kjørt appen direkte på fysisk enhet.

2026-03-16

Autentiseringssystem

La til et grunnleggende autentiseringssystem i HelpdeskGuard-applikasjonen.

Nye komponenter:
- AuthStore.swift
- LoginView.swift
- RegisterView.swift

Implementerte funksjoner:
- Registrering av brukere med e-post og passord
- Validering av brukerinnlogging
- Utloggingsfunksjonalitet
- Lokal lagring av brukere ved hjelp av UserDefaults
- Automatisk oppdatering av brukergrensesnittet ved hjelp av ObservableObject og @Published

Oppførsel i brukergrensesnittet:
- Innloggingsskjermen vises når brukeren ikke er autentisert
- Hovedgrensesnittet i appen vises etter vellykket innlogging
- Navigasjon fra LoginView til RegisterView for opprettelse av ny konto

Tekniske detaljer:
- Autentiseringstilstand håndteres av AuthStore
- SwiftUI EnvironmentObject brukes for å dele autentiseringstilstand i appen
- E-postinput normaliseres ved hjelp av trimming og konvertering til små bokstaver
- SecureField brukes for sikker inntasting av passord

2026-03-20

Videre utvikling og forbedringer

- Forbedret struktur i prosjektet
- Oppdatert README med tydeligere beskrivelse av kompetansemål
- Ryddet opp i TODO-listen og prioriterte videre arbeid
- Dokumentert drift (server-oppsett, sikkerhet og overvåking)
- Lagt til refleksjon rundt videre utvikling av systemet


# CHANGELOG

## 23.03.2026 – Versjon 1.0 (Hovedoppdatering)

### Lagt til

- Implementert full brukerhåndtering:
  - Registrering av bruker (RegisterView)
  - Innlogging av bruker (LoginView)
  - Uthenting av innlogget bruker (AuthStore)
  - Mulighet for å logge ut
  - Mulighet for å slette bruker

- Implementert lokal lagring:
  - Bruk av UserDefaults for lagring av brukerdata
  - Lagring av e-post og passord lokalt

- Implementert hovedstruktur i appen:
  - NavigationStack for navigasjon
  - TabView med fanene:
    - Hjem
    - Saker
    - Konto

- Implementert meny (hamburger-meny):
  - Navigasjon til:
    - Hjem
    - Saker
    - Informasjonsside
  - Mulighet for å logge ut fra meny

- Implementert InfoView:
  - Informasjon om personvern
  - Regler for bruk
  - Hva som lagres i appen
  - Grunnleggende universell utforming

- Implementert NewTicketView:
  - Skjema for å opprette ny sak
  - Input for:
    - Tittel
    - Beskrivelse
    - Kategori
    - Prioritet
  - Validering av input

- Implementert HomeView:
  - Startside med forklaring av appen
  - Navigasjon til ny sak
  - Navigasjon til informasjonsside

- Implementert UI-komponenter:
  - AppTheme (farger og spacing)
  - StorKnapp (gjenbrukbar knappestil)
  - AppKort (kort-design)
  - AppFooter (footer med informasjon)

---

### Forbedringer

- Forbedret design:
  - Konsistente farger gjennom hele appen
  - Bruk av kort (AppKort) for bedre struktur
  - Større knapper for bedre brukeropplevelse

- Forbedret navigasjon:
  - Enklere tilgang til funksjoner via TabView og meny
  - Bedre struktur mellom sider

- Forbedret brukeropplevelse:
  - Tydeligere tekster og instruksjoner
  - Feilmeldinger ved feil input
  - Bekreftelse før sletting av bruker

---

### Universell utforming (WCAG)

- Tydelige overskrifter med korrekt struktur
- Bruk av accessibility labels og hints
- Store trykkflater på knapper
- Enkel og forståelig tekst
- Kontrast mellom tekst og bakgrunn

---

### Teknisk

- Bruk av @State for dynamisk UI
- Bruk av @EnvironmentObject for delt data (AuthStore)
- Strukturert prosjekt i flere SwiftUI views
- Separasjon av ansvar (auth, UI, komponenter)

---

### Dokumentasjon

- Opprettet og oppdatert README.md
- Opprettet og oppdatert TODO.md
- Opprettet og oppdatert CHANGELOG.md
- Dokumentert bruk av KI i AI.md

---

### Status

Prosjektet er nå en fungerende versjon 1.0 som viser:
- fungerende innlogging og brukerhåndtering
- strukturert UI og navigasjon
- grunnleggende helpdesk-funksjonalitet

Videre utvikling vil fokusere på:
- lagring og visning av saker
- backend og sikkerhet
- utvidet funksjonalitet


# Changelog – HelpdeskGuard

## 25. mars 2026

### Lagt til

- Opprettet virtuell maskin i Proxmox VE
- Installert Ubuntu Server 22.04 LTS
- Konfigurert SSH-tilgang og bruker
- Oppdatert system (apt update / upgrade)
- Installert Docker og aktivert tjenesten
- Opprettet backend-prosjekt (FastAPI)
- Implementert API med følgende endepunkter:
  - GET /
  - POST /login
  - GET /tickets
  - POST /tickets
- Implementert autentisering med OAuth2 Bearer token
- Opprettet testbruker for innlogging
- Implementert beskyttelse av API-endepunkter
- Opprettet iOS-app i SwiftUI
- Koblet iOS-app mot backend API
- Konfigurert App Transport Security (ATS) i Xcode
- Aktivert lokal nettverkstilgang (Allow Local Networking)
- Strukturert prosjektmappe og filer
- Opprettet README.md, TODO.md og dokumentasjon
- Startet arbeid med sikkerhet og server hardening

---

### Endret

- Forbedret struktur i backend-kode (main.py)
- Organisert API-logikk og modeller (Ticket, Token)
- Oppdatert dokumentasjon med tydeligere forklaringer
- Justert prosjektstruktur for bedre oversikt
- Forbedret kommunikasjon mellom app og API

---

### Fikset

- dpkg-feil under oppdatering av server
- Problem med manglende ufw (ikke installert)
- SyntaxError i Python (feil sammenkobling av kode)
- "No module named uvicorn" (manglende dependency)
- "Connection refused" (server ikke startet)
- Port-konflikt (address already in use)
- Feil bruk av terminal (kjørte URL som kommando)
- Curl-feil ved manglende backend
- Autentiseringsfeil (manglende token)
- Xcode warning relatert til Document Types
- Problemer med tilkobling mellom app og API

---

### Sikkerhet

- Implementert token-basert autentisering
- Beskyttet API-endepunkter med dependency (Depends)
- Planlagt implementering av:
  - UFW firewall
  - Fail2ban
  - SSH-sikring
  - Docker isolasjon
- Konfigurert ATS i iOS for sikker nettverkstrafikk
- Forberedt bruk av Keychain for lagring av token

---

### Testing

- Testet API med curl:
  - Login (POST /login)
  - Hent tickets med token
- Verifisert autentisering fungerer korrekt
- Testet API-respons uten token (forventet feil)
- Testet lokal server (127.0.0.1:8000)
- Testet integrasjon mellom app og backend

---

### Refleksjon

Under arbeidet møtte jeg flere tekniske utfordringer som bidro til økt forståelse:

- Lærte viktigheten av å starte backend før testing
- Forstod hvordan nettverk og porter fungerer
- Erfarte hvordan små syntaksfeil kan stoppe hele systemet
- Lærte å bruke curl til feilsøking av API
- Forstod hvordan autentisering beskytter API-endepunkter
- Oppdaget viktigheten av riktig konfigurasjon i Xcode (ATS)

Arbeidet viser utvikling innen drift, utvikling og brukerstøtte, spesielt gjennom feilsøking, dokumentasjon og implementering av sikkerhet.

2026-04-20

• Fullført oppsett av lokal backend for HelpdeskGuard på macOS med Node.js, Express og MySQL.
• Opprettet og konfigurert backend-mappe med package.json, server.js og schema.sql.
• Installert nødvendige npm-avhengigheter: express, mysql2 og bcrypt.
• Tilpasset backend-konfigurasjon til lokalt utviklingsmiljø (macOS/Homebrew MySQL).
• Løst tilkoblingsfeil mot MySQL ved å bruke host 127.0.0.1 i stedet for localhost.
• Verifisert innlogging mot MySQL med lokal bruker.
• Startet API-server på port 3000.
• Testet og verifisert følgende API-endepunkter med curl:

  - POST /registrer
  - POST /logginn
  - POST /saker
  - GET /saker/:bruker_id
  - PATCH /saker/:sak_id/lost
  - DELETE /brukere/:bruker_id

• Bekreftet at brukerregistrering fungerer med bcrypt-hashing av passord.
• Bekreftet at innlogging fungerer korrekt.
• Bekreftet opprettelse og henting av saker fra database.
• Bekreftet markering av sak som løst.
• Bekreftet sletting av bruker og tilhørende saker via relasjon i databasen.
• Dokumentert MySQL-bruk, nettverkstilkobling og driftstøtte-relevante sikkerhetstiltak.
• KI brukt som støtte til feilsøking, forklaring og dokumentasjon. Alle steg er gjennomført og forstått av utvikler.
