# HelpdeskGuard
Versjon 1.1  
Prosjektperiode: Mars–April 2026

## Introduksjon
HelpdeskGuard er et tverrfaglig skoleprosjekt (VG2 IT) som demonstrerer en helpdesk-løsning med iOS-klient, Node.js/Express-backend og MySQL-database. Prosjektet dokumenterer også plan, risiko, drift og refleksjon.

## Arkitektur (dagens løsning)
- Frontend/klient: SwiftUI-app i Xcode
- Mellomledd: Node.js / Express backend (kjører på Ubuntu-server)
- Database: MySQL på samme server, database-navn: `helpdeskguard`
- Kommunikasjon: REST API mellom app og backend
- Viktig: iOS-appen kobler ikke direkte til MySQL

Flyt:

## API-eksempler (curl)
JWT-flyt for beskyttede endepunkter:

1. Logg inn og hent token:
```bash
curl -X POST http://172.20.128.20:3000/logginn \
  -H "Content-Type: application/json" \
  -d '{"epost":"bruker@eksempel.no","passord":"hemlig123"}'
```

Forventet svar:
```json
{
  "token": "...",
  "epost": "bruker@eksempel.no"
}
```

2. Bruk token for alle beskyttede endepunkter (`/saker`, osv.):
```bash
curl -X GET http://172.20.128.20:3000/saker \
  -H "Authorization: Bearer <token>"
```

```bash
curl -X POST http://172.20.128.20:3000/saker \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <token>" \
  -d '{"tittel":"PC starter ikke","beskrivelse":"Svart skjerm ved oppstart","kategori":"Maskinvare","prioritet":"Høy"}'
```

```bash
curl -X DELETE http://172.20.128.20:3000/brukere/meg \
  -H "Authorization: Bearer <token>"
```
