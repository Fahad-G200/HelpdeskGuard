README.md

HelpdeskGuard
Versjon 1.0
Prosjektperiode: Mars 2026

⸻

Introduksjon

HelpdeskGuard er et tverrfaglig IT-prosjekt utviklet i programfaget ITK02 (Drift, Brukerstøtte og Utvikling). Målet med prosjektet er å utvikle en fungerende helpdesk-applikasjon samtidig som det dokumenterer arbeidsprosess, refleksjon og faglig forståelse i alle tre programområdene.

Applikasjonen utvikles som en iOS-app i SwiftUI. Løsningen lar brukere registrere IT-problemer (saker), og legger grunnlaget for at brukerstøtte kan håndtere og følge opp disse sakene.

⸻

Formål

Formålet med prosjektet er:
    •    Å utvikle en fungerende IT-løsning
    •    Å dokumentere arbeidsprosess og versjonskontroll
    •    Å vise forståelse for utvikling, drift og brukerstøtte
    •    Å forberede til tverrfaglig eksamen

⸻

Kompetansemål

Prosjektet dekker minst to kompetansemål innen hvert programfag.

Drift
    •    Planlegge og dokumentere IT-løsninger og arbeidsprosesser
    •    Vurdere informasjonssikkerhet og personvern i en IT-løsning

Dette dokumenteres gjennom struktur, risikoanalyse og refleksjon rundt datalagring.

Brukerstøtte
    •    Utøve brukerstøtte gjennom utvikling av sakshåndteringssystem
    •    Utvikle veiledning og kunnskapsbase for brukere

Appen legger til rette for registrering av saker og planlagt kunnskapsbase.

Utvikling
    •    Lage funksjonelle krav til IT-løsning
    •    Bruke versjonskontroll (Git) i utviklingsprosjekt
    •    Implementere brukergrensesnitt i SwiftUI

Prosjektet ligger på GitHub og all utvikling dokumenteres i CHANGELOG.md.

⸻

Struktur

Applikasjonen består av følgende hoveddeler:
    •    HomeView – startside og navigasjon
    •    NewTicketView – registrering av ny sak
    •    TicketsView – liste over registrerte saker (under utvikling)
    •    KnowledgeBaseView – kunnskapsbase (planlagt)

⸻

Teknologi
    •    Swift
    •    SwiftUI
    •    Xcode
    •    Git og GitHub

⸻

Dokumentasjon i repository

Prosjektet inneholder følgende dokumentasjon:
    •    README.md – prosjektbeskrivelse
    •    CHANGELOG.md – oversikt over endringer
    •    TODO.md – planlagt videre arbeid
    •    AI.md – dokumentasjon av bruk av kunstig intelligens

⸻

Videre utvikling

Neste steg i prosjektet er å implementere en Ticket-modell og TicketStore for å kunne lagre og vise registrerte saker i appen.


##Demonstrasjon av prosjektet

For å se hvordan applikasjonen fungerer, se demonstrasjonsvideoen:
https://youtu.be/t9wQ-nkPV-c

⸻

## Personvern og sikkerhet

Applikasjonen lagrer foreløpig data lokalt på enheten (UserDefaults). Det lagres kun nødvendig informasjon som brukerens e-post og registrerte saker.

Det brukes ikke eksterne skytjenester i versjon 1.0, noe som reduserer risiko for datalekkasjer.

For serverdelen er følgende sikkerhetstiltak implementert:
- SSH-sikring (ingen root login)
- Firewall (UFW)
- Fail2Ban for beskyttelse mot brute-force
- Overvåking via Uptime Kuma

## Risikoanalyse (kort)

Mulige risikoer i systemet:
- Tap av data (lokal lagring uten backup)
- Uautorisert tilgang hvis autentisering ikke er ferdig implementert
- Manglende kryptering (HTTPS ikke implementert ennå)

Tiltak:
- Plan om backend med sikker autentisering (JWT)
- Plan om HTTPS i produksjon
- Fremtidig lagring i database med backup

⸻

## Nåværende funksjonalitet (versjon 1.0)

Dette fungerer i applikasjonen:
- Bruker kan registrere seg og logge inn
- Bruker kan opprette en sak (ticket)
- Saker lagres lokalt i appen
- Bruker kan se liste over saker
- Grunnleggende navigasjon mellom sider

Dette viser et fungerende konsept som kan videreutvikles i senere versjoner.
