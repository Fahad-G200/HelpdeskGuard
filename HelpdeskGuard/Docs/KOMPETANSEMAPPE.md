# Kompetansemapping – HelpdeskGuard (v1.1)

Dette dokumentet viser sammenheng mellom kompetansemål, faktisk arbeid og dokumentasjon i prosjektet.

---

## Drift

| Kompetansemål | Hva er gjort i prosjektet | Bevis |
|---|---|---|
| Planlegge og dokumentere arbeidsprosesser og IT-løsninger | Strukturert dokumentasjon av app, drift og risiko | README.md, PLAN.md, RISIKOANALYSE.md |
| Gjennomføre risikoanalyse og foreslå tiltak | Risikoer vurdert med tiltak og prioritet | RISIKOANALYSE.md |
| Planlegge/drifte løsning med informasjonssikkerhet | JWT-autentisering, bcrypt, rate limiting, GDPR-dokumentasjon | DRIFT_SETUP.md, SECURITY.md, server-hardening.md |
| Administrere brukere, tilganger og rettigheter | Brukertabell i MySQL, JWT-beskyttede ruter, kun egne saker vises | server.js, schema.sql |
| Utforske trusler mot datasikkerhet | Trusselbilde, brute-force, SQL-injection, token-lekkasje | RISIKOANALYSE.md, SECURITY.md |

---

## Brukerstøtte

| Kompetansemål | Hva er gjort i prosjektet | Bevis |
|---|---|---|
| Kartlegge behov og utvikle veiledninger | Brukerveiledning med steg-for-steg og feilsøking | USER_GUIDE.md |
| Utøve brukerstøtte og veilede i programvare | Appen har tydelige brukerflyter med forklarende tekster | LoginView.swift, RegisterView.swift, HomeView.swift |
| Gjøre rede for etiske retningslinjer og lovverk | GDPR-dokumentasjon med artikler og brukerrettigheter | GDPR.md |
| Reflektere over intelligente systemer | Drøfting av AI sin påvirkning på helpdesk og samfunn | AI.md |
| Beskrive og bruke rammeverk for kvalitetssikring | ITIL 4-prinsipper, incident management, KPI-er | ITIL_QUALITY.md |

---

## Utvikling

| Kompetansemål | Hva er gjort i prosjektet | Bevis |
|---|---|---|
| Lage og begrunne funksjonelle krav | Må-/bør-/kan-krav med status | KRAVSPESIFIKASJON.md |
| Modellere og opprette databaser | MySQL-tabeller (brukere, saker) med fremmednøkler og indekser | schema.sql, backend/schema.sql |
| Beskrive datalagringsmodeller og metoder | REST API med JSON, MySQL CRUD, JWT i header | server.js, API.swift, LANGUAGE_COMPARISON.md |
| Versjonskontroll | Endringshistorikk og arbeid over tid i Git | CHANGELOG.md, git-logg |
| Teknisk dokumentasjon | Strukturert dokumentasjon med UML, infrastruktur, krav og risiko | README.md, Docs/* |
| Sikkerhet i applikasjoner | JWT, bcrypt, rate limiting, GDPR-design | server.js, API.swift, SECURITY.md |
| Testing | Enhetstester, integrasjonstester, E2E og sikkerhetstester dokumentert | TEST_RAPPORT.md |
| Vurdere programmeringsspråk | Sammenligning av Swift, Node.js, MySQL vs alternativer | LANGUAGE_COMPARISON.md |
| Innebygget personvern | Sletting av bruker sletter alle saker (CASCADE), GDPR-dokumentasjon | schema.sql, server.js, GDPR.md |

---

## Vurdering av v1.1

Prosjektet viser fungerende konsept med:
- Komplett backend kobling: iOS → JWT → Node.js → MySQL
- Brukerne kan registrere seg, logge inn, opprette saker, se saklisten og markere saker som løst
- Alle tre fagområder er dekket med minst 2 kompetansemål hvert

Gjenstående arbeid (se TODO.md):
- HTTPS/SSL i produksjon
- Keychain for sikrere JWT-lagring
- Backend på Ubuntu Server (ikke bare lokalt)
