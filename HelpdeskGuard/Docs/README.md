# HelpdeskGuard
Versjon 1.0  
Prosjektperiode: Mars-April 2026

---

## Introduksjon
HelpdeskGuard er et tverrfaglig skoleprosjekt i VG2 IT (Drift, Brukerstotte og Utvikling). Prosjektet viser en fungerende helpdesk-prototype i iOS, kombinert med dokumentasjon av plan, risiko, drift og refleksjon.

I v1.0 kan bruker registrere konto, logge inn, opprette sak og navigere mellom hovedsider i appen.

---

## Hvordan kjore prosjektet
1. Aapne prosjektet i Xcode.
2. Velg iOS Simulator eller fysisk iPhone.
3. Trykk Run.
4. Registrer bruker, logg inn og opprett en ny sak.

Merk: Data lagres lokalt i appen i denne versjonen.

---

## Hva appen gjor i dag (v1.0)
- Registrering av bruker
- Innlogging og utlogging
- Opprettelse av sak (skjema med validering)
- Konto-side med sletting av bruker
- Informasjonsside om personvern/regler

---

## Status på funksjoner
| Funksjon | Status |
|---|---|
| Registrering | ✅ Ferdig |
| Innlogging/utlogging | ✅ Ferdig |
| Opprette sak (API) | ✅ Ferdig |
| Vise saksliste (fra server) | ✅ Ferdig |
| Markere sak som løst | ✅ Ferdig |
| Slette bruker | ✅ Ferdig |
| Backend-integrasjon i app | ✅ Ferdig |

---

## Valg av teknologi
- SwiftUI: rask utvikling av iOS-grensesnitt med tydelig struktur i egne views.
- UserDefaults: enkel lokal lagring i prototypefasen.
- Git/GitHub: versjonskontroll, sporbarhet og samarbeid.
- Ubuntu Server: driftstrening med serveroppsett og sikkerhetstiltak.
- Docker: isolert kjoremiljo for tjenester i drift/test.
- Uptime Kuma: overvaking av tjenester og tilgjengelighet.

Begrunnelse: Teknologiene er valgt for a dekke kompetanse i alle tre fag, med realistisk avgrensning for v1.0.

---

## Prosjektstruktur
- `HelpdeskGuard/` - appfiler og dokumentasjon
- `HelpdeskGuard/Docs/` - plan, krav, risiko, refleksjon og veiledning
- `Products/` - bygde artefakter

Sentrale appfiler:
- `ContentView.swift` - hovednavigasjon
- `LoginView.swift` / `RegisterView.swift` - brukerflyt
- `NewTicketView.swift` - opprettelse av sak
- `AuthStore.swift` - enkel autentiseringslogikk
- `TicketStore.swift` - datamodell for saker (ikke fullt koblet til UI)

---

## Sikkerhetsbegrensninger i v1.0
- Lagring er lokal og enkel (prototype).
- Sikkerhetsnivaaet er ikke produksjonsklart.
- Videre arbeid: sterkere lagring av sensitiv data og bedre autentisering.

---

## Dokumentasjon
- [CHANGELOG.md](CHANGELOG.md)
- [AI.md](AI.md)
- [TODO.md](TODO.md)
- [PLAN.md](Docs/PLAN.md)
- [KRAVSPESIFIKASJON.md](Docs/KRAVSPESIFIKASJON.md)
- [USER_GUIDE.md](Docs/USER_GUIDE.md)
- [REFLEKSJON.md](Docs/REFLEKSJON.md)
- [RISIKOANALYSE.md](Docs/RISIKOANALYSE.md)
- [UML_DIAGRAM.md](Docs/UML_DIAGRAM.md)
- [INFRASTRUCTURE_DIAGRAM.md](Docs/INFRASTRUCTURE_DIAGRAM.md)
- [KOMPETANSEMAPPE.md](Docs/KOMPETANSEMAPPE.md)

---

## Plan vs resultat (kort)
Planen var a levere en fungerende helpdesk-prototype med brukerflyt og saksopprettelse. Dette er levert i v1.0.

Det som gjenstar er hovedsakelig saksliste i appen, sterkere sikkerhetsimplementasjon og videre backend-arbeid.
