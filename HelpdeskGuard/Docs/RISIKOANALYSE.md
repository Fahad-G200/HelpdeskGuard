# Risikoanalyse – HelpdeskGuard (v1.1)

| Risiko | Sannsynlighet | Konsekvens | Risikonivå | Tiltak |
|---|---:|---:|---|---|
| Manglende HTTPS i testmiljø | 3 | 4 | Høy | Innføre HTTPS på backend når mulig |
| Svak autentisering/autorisasjon | 3 | 5 | Høy | Implementere sikker auth-flow og begrenset tilgang |
| Dokumentasjon ute av sync med løsning | 2 | 3 | Middels | Oppdatere docs ved endringer (README, CHANGELOG) |
| Serverfeil/nedetid | 2 | 4 | Middels/Høy | Overvåking, logging og restart-rutiner |
| Datatap i MySQL | 2 | 5 | Middels/Høy | Backup-plan og restore-testing |

## Oppsummering
Løsningen er en prototype med tydelig arkitektur: SwiftUI → Node.js/Express → MySQL. Hovedfokus videre er sikker transport (HTTPS), sterkere autentisering og rutiner for drift og backup.
