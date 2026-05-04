# TESTLOGG – HelpdeskGuard API

Denne testloggen dokumenterer manuell testing av API-endepunktene.

| Dato | Testcase | Forventet resultat | Faktisk resultat | Status |
|---|---|---|---|---|
| 2026-05-04 | Registrering med gyldig epost | `POST /registrer` returnerer 200/201 og bruker opprettes i `brukere` | 201 opprettet, bruker synlig i database | Bestått |
| 2026-05-04 | Registrering med ugyldig epost | `POST /registrer` returnerer 4xx med feilmelding | 400 med melding om ugyldig e-post | Bestått |
| 2026-05-04 | Innlogging med feil passord | `POST /logginn` returnerer 401/4xx med feilmelding | 401 med melding om feil legitimasjon | Bestått |
| 2026-05-04 | Hente saker uten token | `GET /saker` returnerer 401/403 | 401 Unauthorized | Bestått |
| 2026-05-04 | Opprette sak uten token | `POST /saker` returnerer 401/403 | 401 Unauthorized | Bestått |
| 2026-05-04 | Hente saker med gyldig token | `GET /saker` returnerer 200 og liste med saker | 200 med gyldig JSON-liste | Bestått |
| 2026-05-04 | Opprette sak med gyldig token | `POST /saker` returnerer 200/201 og saken lagres i `saker` | 201 opprettet, sak synlig i database | Bestått |

## Kommentar
Testene er kjørt manuelt med curl og kontrollert mot API-svar samt data i MySQL.
