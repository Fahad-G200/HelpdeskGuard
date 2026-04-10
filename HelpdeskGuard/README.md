# HelpdeskGuard
Versjon 1.0  
Prosjektperiode: Mars-April 2026

---

## Introduksjon
HelpdeskGuard er et tverrfaglig skoleprosjekt i VG2 IT (Drift, Brukerstotte og Utvikling). Prosjektet viser hvordan en enkel helpdesk-app kan bygges i SwiftUI, samtidig som arbeid med dokumentasjon, risiko og refleksjon blir en del av leveransen.

I versjon 1.0 kan brukeren registrere konto, logge inn, opprette sak og navigere mellom hovedsidene i appen.

---

## Hvordan kjore prosjektet
1. Aapne prosjektet i Xcode.
2. Velg iOS Simulator eller fysisk iPhone.
3. Trykk Run.
4. Registrer bruker, logg inn og opprett en ny sak.

Merk: Data lagres lokalt i appen (prototype), ikke i ekstern database.

---

## Valg av teknologi
- SwiftUI: valgt for rask utvikling av iOS-grensesnitt og tydelig struktur med egne views.
- UserDefaults: valgt for enkel lokal lagring i prototypefasen.
- Docker: brukt i serverarbeid for isolert og repeterbart miljo.
- Ubuntu Server: brukt i drift-del for oppsett, sikkerhetstiltak og overvaking.

Begrunnelse: Valgene passer et skoleprosjekt der maalet er a vise helhetlig kompetanse, ikke ferdig produksjonssystem.

---

## Prosjektstruktur
- `HelpdeskGuard/` - appkode og prosjektfiler
- `HelpdeskGuard/Docs/` - plan, krav, refleksjon, risiko og veiledning
- `Products/` - bygde artefakter

Sentrale appfiler:
- `ContentView.swift` - hovednavigasjon
- `LoginView.swift` og `RegisterView.swift` - autentisering i UI
- `NewTicketView.swift` - opprettelse av sak
- `AuthStore.swift` - enkel autentiseringslogikk
- `TicketStore.swift` - struktur for sakslagring

---

## Status pa funksjoner (v1.0)
| Funksjon | Status |
|--------|--------|
| Registrering | Ferdig |
| Innlogging | Ferdig |
| Opprette sak | Ferdig |
| Vise liste over saker | Planlagt |
| Backend/API | Planlagt |

---

## Sikkerhet og personvern
I versjon 1.0 lagres passord i klartekst i UserDefaults. Dette er ikke sikkert, men er et bevisst prototypevalg.

Plan videre:
- hashing av passord
- lagring av sensitiv informasjon i Keychain
- backend-autentisering med bedre tilgangskontroll

Personvern:
- data lagres lokalt i appen
- ingen deling med ekstern skytjeneste i v1.0

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

---

## Plan vs resultat (kort)
Planen var a lage en enkel helpdesk-prototype med brukerflyt for registrering, innlogging og saksopprettelse. Dette er gjennomfort i v1.0.

Det som fortsatt er planlagt er saksliste, sterkere sikkerhet og backend-integrasjon.
