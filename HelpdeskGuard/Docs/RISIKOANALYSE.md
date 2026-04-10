# Risikoanalyse – HelpdeskGuard

| Risiko | Sannsynlighet | Konsekvens | Risikonivå | Tiltak |
|--------|-------------|-----------|-----------|--------|
| Passord i klartekst | 4 | 5 | Kritisk | Plan: hashing + Keychain |
| Tap av data | 3 | 4 | Hoy | Plan: database/backup |
| Manglende HTTPS | 3 | 4 | Hoy | Plan: TLS/SSL |
| Brute-force SSH | 2 | 5 | Hoy | Fail2Ban + hardening |
| Uautorisert tilgang | 2 | 4 | Middels | Bedre autentisering |
| Server nede | 2 | 3 | Middels | Overvaking |
| GDPR-brudd | 2 | 4 | Middels | Dataminimering og dokumentasjon |
| Nettverksproblemer | 3 | 3 | Middels | Lokal testing + feilsoking |

## Hva dette betyr for prosjektet
To risikoer treffer appen direkte i versjon 1.0:
1. Passord i klartekst: hvis enheten kompromitteres, kan brukerdata leses ut.
2. Tap av data: fordi lagring er lokal uten backup, kan data forsvinne ved reinstallasjon eller feil.

Dette viser at prosjektet fungerer funksjonelt, men at sikkerhet og robusthet maa forbedres for neste versjon.
