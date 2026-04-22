# Testrapport – HelpdeskGuard

## Oversikt

| Felt | Verdi |
|-----|------|
| Prosjekt | HelpdeskGuard |
| Versjon | v1.1 |
| Dato | 2026-04-22 |
| Testmiljø | iOS Simulator (iPhone 16), macOS, Node.js + MySQL lokalt |
| Ansvarlig | Fahad Adnan Ashraf |

---

## 1. Enhetstest (Unit Testing)

### 1.1 AuthStore – Registrering

| Test-ID | Beskrivelse | Forventet resultat | Status |
|--------|-------------|-------------------|--------|
| AUTH-01 | Registrer ny bruker med gyldig e-post og passord | Returnerer `true` | ✅ OK |
| AUTH-02 | Registrer med samme e-post to ganger | Returnerer `false` | ✅ OK |
| AUTH-03 | Registrer med tom e-post | Returnerer `false` | ✅ OK |

### 1.2 AuthStore – Innlogging

| Test-ID | Beskrivelse | Forventet resultat | Status |
|--------|-------------|-------------------|--------|
| AUTH-04 | Logg inn med korrekt e-post og passord | Returnerer `true`, setter `isLoggedIn = true` | ✅ OK |
| AUTH-05 | Logg inn med feil passord | Returnerer `false` | ✅ OK |
| AUTH-06 | Logg inn med ikke-eksisterende bruker | Returnerer `false` | ✅ OK |
| AUTH-07 | Backend returnerer JWT-token ved vellykket innlogging | `jwtToken` satt i AuthStore | ✅ OK |

### 1.3 TicketStore – Saker

| Test-ID | Beskrivelse | Forventet resultat | Status |
|--------|-------------|-------------------|--------|
| TICKET-01 | Opprett sak med tittel og beskrivelse | Returnerer `true`, sak vises i liste | ✅ OK |
| TICKET-02 | Opprett sak uten tittel | Returnerer `false` (validering i view) | ✅ OK |
| TICKET-03 | Hent saker med gyldig token | Liste oppdateres | ✅ OK |
| TICKET-04 | Hent saker uten server (server nede) | Tom liste, ingen krasj | ✅ OK |

---

## 2. Integrasjonstest (API-testing med curl)

Backend-endepunkter testet manuelt med curl.

### 2.1 POST /registrer

```bash
curl -X POST http://localhost:3000/registrer \
  -H "Content-Type: application/json" \
  -d '{"epost":"test@test.no","passord":"hemmelig123"}'
```

| Scenario | Forventet | Resultat |
|---------|----------|---------|
| Ny bruker | 201 Created | ✅ OK |
| Eksisterende e-post | 409 Conflict | ✅ OK |
| Mangler felt | 400 Bad Request | ✅ OK |

### 2.2 POST /logginn

```bash
curl -X POST http://localhost:3000/logginn \
  -H "Content-Type: application/json" \
  -d '{"epost":"test@test.no","passord":"hemmelig123"}'
```

| Scenario | Forventet | Resultat |
|---------|----------|---------|
| Korrekte opplysninger | 200 OK + JWT-token | ✅ OK |
| Feil passord | 401 Unauthorized | ✅ OK |

### 2.3 GET /saker (med JWT)

```bash
TOKEN="<jwt-fra-innlogging>"
curl http://localhost:3000/saker \
  -H "Authorization: Bearer $TOKEN"
```

| Scenario | Forventet | Resultat |
|---------|----------|---------|
| Gyldig token | 200 OK + JSON-liste | ✅ OK |
| Mangler token | 401 Unauthorized | ✅ OK |
| Ugyldig token | 401 Unauthorized | ✅ OK |

### 2.4 POST /saker (med JWT)

```bash
curl -X POST http://localhost:3000/saker \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"tittel":"PC starter ikke","beskrivelse":"Skjermen er svart","kategori":"Maskinvare","prioritet":"Høy"}'
```

| Scenario | Forventet | Resultat |
|---------|----------|---------|
| Gyldig sak | 201 Created | ✅ OK |
| Mangler tittel | 400 Bad Request | ✅ OK |

### 2.5 DELETE /brukere/meg

```bash
curl -X DELETE http://localhost:3000/brukere/meg \
  -H "Authorization: Bearer $TOKEN"
```

| Scenario | Forventet | Resultat |
|---------|----------|---------|
| Gyldig bruker | 200 OK, bruker og saker slettet | ✅ OK |

---

## 3. Systemtest (End-to-End i iOS Simulator)

| Test-ID | Scenario | Forventet | Resultat |
|--------|---------|----------|---------|
| E2E-01 | Registrer bruker via app mot backend | Bruker opprettes i MySQL | ✅ OK |
| E2E-02 | Logg inn via app, JWT hentes | `isLoggedIn = true`, token lagret | ✅ OK |
| E2E-03 | Opprett sak via app | Sak lagret i MySQL, vises i liste | ✅ OK |
| E2E-04 | Logg ut og logg inn igjen | Saker fremdeles synlige etter ny innlogging | ✅ OK |
| E2E-05 | Bruk app uten server (offline) | Lokal fallback fungerer | ✅ OK |
| E2E-06 | Tilgjengelighet – dynamisk tekststørrelse | UI skalerer korrekt | ✅ OK |

---

## 4. Sikkerhetstest

| Test-ID | Beskrivelse | Resultat |
|--------|-------------|---------|
| SEC-01 | Rate limiting – 21 forespørsler til /logginn på 15 min | Blokkert med 429 | ✅ OK |
| SEC-02 | JWT-token kan ikke forfalskes | 401 ved ugyldig signatur | ✅ OK |
| SEC-03 | Passord er aldri i klartekst i databasen | bcrypt-hash i MySQL | ✅ OK |
| SEC-04 | MySQL port 3306 ikke tilgjengelig utenfra | Connection refused fra ekstern IP | ✅ OK |

---

## 5. Oppsummering

| Testtype | Antall tester | Bestått | Feilet |
|---------|--------------|---------|--------|
| Enhetstester | 10 | 10 | 0 |
| Integrasjonstester | 9 | 9 | 0 |
| Systemtester (E2E) | 6 | 6 | 0 |
| Sikkerhetstester | 4 | 4 | 0 |
| **Totalt** | **29** | **29** | **0** |

---

## 6. Kjente begrensninger

- Testing er utført manuelt – ingen automatiserte tester (XCTest) er implementert i v1.1.
- Tester er kjørt i simulator, ikke på fysisk enhet mot lokal server (krever LAN-IP).
- Stresstest (mange samtidige brukere) er ikke gjennomført.
