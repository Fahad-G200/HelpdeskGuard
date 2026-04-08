# HelpdeskGuard
Versjon 1.0  
Prosjektperiode: Mars 2026

---

## Introduksjon

HelpdeskGuard er et tverrfaglig IT-prosjekt utviklet i programfaget ITK02 (Drift, Brukerstøtte og Utvikling). Målet med prosjektet er å utvikle en fungerende helpdesk-applikasjon samtidig som det dokumenterer arbeidsprosess, refleksjon og faglig forståelse i alle tre programområdene.

Applikasjonen utvikles som en iOS-app i SwiftUI. Løsningen lar brukere registrere IT-problemer (saker), og legger grunnlaget for at brukerstøtte kan håndtere og følge opp disse sakene.

---

## Formål

Formålet med prosjektet er:
- Å utvikle en fungerende IT-løsning
- Å dokumentere arbeidsprosess og versjonskontroll
- Å vise forståelse for utvikling, drift og brukerstøtte
- Å forberede til tverrfaglig eksamen

---

## Kompetansemål

Prosjektet dekker minst to kompetansemål innen hvert programfag.

### Drift
- Planlegge og dokumentere IT-løsninger og arbeidsprosesser
- Vurdere informasjonssikkerhet og personvern i en IT-løsning  

Dette dokumenteres gjennom bruk av Git, struktur i prosjektet, lokal lagring med UserDefaults og refleksjon rundt personvern.

### Brukerstøtte
- Utøve brukerstøtte gjennom utvikling av sakshåndteringssystem
- Utvikle veiledning og kunnskapsbase for brukere  

Appen legger til rette for registrering av saker og en grunnleggende struktur for sakshåndtering.

### Utvikling
- Lage funksjonelle krav til IT-løsning
- Bruke versjonskontroll (Git) i utviklingsprosjekt
- Implementere brukergrensesnitt i SwiftUI  

Prosjektet ligger på GitHub og all utvikling dokumenteres i CHANGELOG.md.

---

## Struktur

Applikasjonen består av følgende hoveddeler:
- HomeView – startside og navigasjon
- NewTicketView – registrering av ny sak
- InfoView – informasjon om personvern og regler
- LoginView / RegisterView – håndtering av bruker
- TicketStore / Ticket – modell og struktur for lagring av saker

---

## Teknologi

- Swift
- SwiftUI
- Xcode
- Git og GitHub
- UserDefaults (lokal lagring)

---

## Dokumentasjon i repository

Prosjektet inneholder følgende dokumentasjon:
- README.md – prosjektbeskrivelse
- CHANGELOG.md – oversikt over endringer
- TODO.md – planlagt videre arbeid
- AI.md – dokumentasjon av bruk av kunstig intelligens
- Docs/PLAN.md – milepæler, tidslinje og kobling til kompetansemål
- Docs/USER_GUIDE.md – brukerveiledning (installasjon og bruk)
- Docs/REFLEKSJON.md – egenvurdering og videreutviklingsplan
- Docs/UML_DIAGRAM_PLACEHOLDER.md – plassholder for UML-diagram
- Docs/INFRASTRUCTURE_DIAGRAM_PLACEHOLDER.md – plassholder for infrastrukturdiagram

---

## Videre utvikling

Neste steg i prosjektet er å:
- koble TicketStore til UI
- vise liste over saker i appen
- forbedre lagring og struktur

---

## Demonstrasjon av prosjektet

For å se hvordan applikasjonen fungerer, se demonstrasjonsvideoen:  
https://youtu.be/t9wQ-nkPV-c

---

## Personvern og sikkerhet

Applikasjonen lagrer foreløpig data lokalt på enheten (UserDefaults). Det lagres kun nødvendig informasjon som brukerens e-post.

Det brukes ikke eksterne skytjenester i versjon 1.0.

For serverdelen er følgende sikkerhetstiltak planlagt eller testet i et separat miljø:
- SSH-sikring (ingen root login)
- Firewall (UFW)
- Fail2Ban
- Overvåking via Uptime Kuma

---

## Risikoanalyse (kort)

Mulige risikoer:
- Tap av data (lokal lagring uten backup)
- Manglende sikker autentisering
- Manglende kryptering

Tiltak:
- Planlagt backend (JWT)
- Planlagt HTTPS
- Fremtidig database med backup

---

## Nåværende funksjonalitet (versjon 1.0)

Dette fungerer i applikasjonen:
- Bruker kan registrere seg og logge inn
- Bruker kan opprette en sak
- Struktur for lagring av saker finnes (TicketStore)
- Grunnleggende navigasjon mellom sider
- Informasjonsside om personvern

---

## Begrensninger i versjon 1.0

- Saker vises ikke fullt ut i liste
- Ingen ekstern database
- Enkel autentisering uten kryptering
- Begrenset funksjonalitet

Dette er bevisste valg for å fokusere på læring og grunnstruktur.

---

## Status på funksjoner

| Funksjon | Status |
|--------|--------|
| Registrering | Ferdig |
| Innlogging | Ferdig |
| Opprette sak | Ferdig |
| Liste over saker | Under utvikling |
| Backend | Planlagt |

---

## Valg av teknologi

SwiftUI ble valgt fordi det gjør det enkelt å utvikle UI raskt i iOS.

UserDefaults ble brukt for enkel lagring i starten.

Git ble brukt for versjonskontroll og oversikt over endringer.

Begrensninger:
- UserDefaults er ikke sikkert for passord
- systemet er foreløpig bare en prototype

---

## Sikkerhet

I versjon 1.0 lagres passord i klartekst i UserDefaults.

Dette er ikke sikkert, men er gjort for å lage en prototype.

Plan videre:
- hashing av passord
- lagring i Keychain
- autentisering via backend

---

## Plan

### Ferdig
- Lage UI
- Registrering og login
- Opprette saker

### Jobber med
- bedre lagring av data

### Planlagt
- backend
- sikker innlogging
- visning av saker

