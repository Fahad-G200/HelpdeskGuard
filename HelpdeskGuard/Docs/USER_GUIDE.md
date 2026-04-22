# Brukerveiledning – HelpdeskGuard

## Forutsetninger
- Backend (Node.js + MySQL) må kjøre lokalt på port 3000 for full funksjonalitet.
- Appen fungerer i begrenset modus (lokal lagring) uten server.

## Slik bruker du appen

1. Åpne appen.
2. Trykk **"Har du ikke konto? Registrer deg"**.
3. Skriv inn e-post og passord, trykk **"Opprett bruker"**.
   - Appen prøver å registrere deg på backend-serveren.
   - Hvis serveren ikke kjører, lagres brukeren lokalt som fallback.
4. Logg inn med e-post og passord.
   - Vellykket innlogging fra backend gir deg et JWT-token.
5. Gå til fanen **"Saker"**.
6. Fyll inn tittel og beskrivelse.
7. Velg kategori og prioritet.
8. Trykk **"Send inn sak"** – saken sendes til backend og lagres i MySQL.
9. Listen over dine saker vises automatisk under skjemaet.

## Hva appen gjør i v1.1
- Registrering og innlogging via Node.js-backend med JWT.
- Fallback til lokal lagring hvis serveren ikke er tilgjengelig.
- Opprette og hente saker fra MySQL-database via REST API.
- Navigasjon mellom Hjem, Saker, Konto og Informasjon.

## Feilsøking

| Problem | Mulig årsak | Løsning |
|---------|-------------|---------|
| Får ikke logget inn | Feil e-post/passord | Kontroller inndata og prøv igjen |
| Saken ble ikke sendt | Serveren er nede | Start backend: `node server.js` i backend-mappen |
| Simulatoren kan ikke koble | Feil URL | Sjekk at `API_URL` i `API.swift` er `http://localhost:3000` |
| Fysisk enhet kan ikke koble | Bruker localhost | Bytt `API_URL` til maskinens LAN-IP, f.eks. `http://192.168.1.x:3000` |
| Registrering feiler | E-post finnes allerede | Bruk annen e-post eller logg inn |

## Personvern
- Data lagres i MySQL-databasen på lokal server.
- JWT-token lagres i `UserDefaults` på enheten.
- Du kan slette brukeren din fra Konto-siden.
- Se `GDPR.md` for mer informasjon om personvern.
