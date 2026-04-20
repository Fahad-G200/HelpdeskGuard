# Risikoanalyse – HelpdeskGuard

| Risiko | Sannsynlighet | Konsekvens | Risikoniva | Tiltak |
|---|---:|---:|---|---|
| For enkel lagring av sensitive opplysninger | 4 | 5 | Hoy | Strengere lagring og tydelig avgrensning i v1.0 |
| Tap av data ved lokal lagring | 3 | 4 | Hoy | Plan for mer robust lagring/backup |
| Manglende full backend-sikkerhet i appflyt | 3 | 4 | Hoy | Videreutvikle autentisering stegvis |
| Uautorisert servertilgang | 2 | 5 | Middels/Hoy | Hardening, tilgangskontroll, overvaking |
| Nedetid i testmiljo | 2 | 3 | Middels | Overvaking med Uptime Kuma |
| Dokumentasjon ute av sync med losning | 3 | 3 | Middels | Oppdatere docs hver arbeidsokt |

## Oppsummering
Risikoene viser at HelpdeskGuard fungerer som prototype, men ikke er produksjonsklar. To risikoer treffer appen direkte: enkel lagring av sensitive data og lokal lagring uten robust backup.

Dette betyr at hovedfokus i neste fase ma vaere sikkerhet og robusthet, samtidig som funksjonene som allerede finnes i v1.0 bevares.
