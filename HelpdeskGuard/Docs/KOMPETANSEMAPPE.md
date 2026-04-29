# Kompetansemapping – HelpdeskGuard (v1.1)

Dette dokumentet kobler kompetansemål til konkret arbeid og bevis i prosjektet.

## Driftsstøtte
- Planlegge og dokumentere IT-løsninger
  - Oppdatert arkitektur og drift i README.md (SwiftUI → Node.js/Express → MySQL)
  - Serveroppstart og helsesjekk dokumentert
  - Bevis: README.md, CHANGELOG.md
- Sette opp og drifte tjenester på server
  - Node.js-backend kjører på Ubuntu, MySQL-database `helpdeskguard`
  - Start/stopp og helsesjekk med `node server.js` og `GET /health`
  - Bevis: README.md, Mysql.md
- Informasjonssikkerhet i drift
  - Avgrensninger og videre tiltak (HTTPS, backup, hardening)
  - Bevis: SECURITY.md, RISIKOANALYSE.md

## Brukerstøtte
- Utarbeide brukerveiledning og feilsøking
  - Beskriver brukerflyt og hvordan data hentes via API
  - Bevis: Docs/USER_GUIDE.md (oppdatert), README.md
- Kommunisere tydelig med riktig terminologi
  - Frontend/klient vs. backend/mellomledd vs. database
  - Bevis: README.md, Docs/REFLEKSJON.md

## Utvikling
- Krav, design og implementasjon
  - SwiftUI-app som klient, REST-API i backend, MySQL-database
  - Bevis: README.md, Docs/PLAN.md, Docs/KRAVSPESIFIKASJON.md
- Versjonskontroll og endringslogg
  - Kontinuerlig dokumentert i CHANGELOG.md
  - Bevis: CHANGELOG.md, git-logg
- Teknisk dokumentasjon
  - Oppdatert og ryddet dokumentasjon, kodeblokker og kommandoer
  - Bevis: README.md, PROJECT_STRUCTURE.md, Mysql.md

## Oppsummering
Prosjektet demonstrerer helhetlig kompetanse i driftsstøtte, brukerstøtte og utvikling gjennom en fungerende klient/server-prototype med dokumentert oppsett, testing og feilsøking.
