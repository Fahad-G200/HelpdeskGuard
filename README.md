# HelpdeskGuard

**Versjon 1.0 → v2.0 (under utvikling)**  
Prosjektperiode: Mars–April 2026  
Tverrfaglig skoleprosjekt – VG2 IT (Drift, Brukerstøtte og Utvikling)

---

## Hva er HelpdeskGuard?

HelpdeskGuard er en iOS-app der brukere kan registrere IT-supporthenvendelser (helpdesk-saker), logge inn og se status på egne saker.

Systemet består av:
- **iOS-app** (SwiftUI / Xcode) – brukergrensesnitt og nettverkskall
- **Backend API** (Node.js / Express) – forretningslogikk og autentisering
- **Database** (MySQL) – lagring av brukere og saker

Appen kommuniserer **kun via backend-APIet** og aldri direkte med databasen.

---

## Arkitektur

```
iPhone (SwiftUI-app)
       │  HTTP + JWT
       ▼
Node.js / Express (port 3000)
       │  SQL
       ▼
MySQL – database: helpdeskguard
```

---

## Funksjoner (v2.0)

| Funksjon                        | Status      |
|---------------------------------|-------------|
| Registrer bruker                | ✅ Ferdig   |
| Logg inn / logg ut              | ✅ Ferdig   |
| Opprett helpdesk-sak            | ✅ Ferdig   |
| Vis liste over egne saker       | ✅ Ferdig   |
| Marker sak som løst             | ✅ Ferdig   |
| Slett bruker og alle saker      | ✅ Ferdig   |
| Passord lagret som bcrypt-hash  | ✅ Ferdig   |
| JWT-autentisering               | ✅ Ferdig   |

---

## Kompetansemål som dekkes

### Drift
- Planlegge og dokumentere IT-løsninger
- Gjennomføre risikoanalyse og foreslå tiltak
- Drifte løsning med informasjonssikkerhet (UFW, Fail2Ban, SSH)
- Databaseadministrasjon (MySQL – skjema, indekser, rettigheter)

### Brukerstøtte
- Kartlegge behov og utvikle brukerveiledninger
- Utøve brukerstøtte med tydelig brukerflyt og feilmeldinger
- Universell utforming (WCAG – kontrast, dynamisk tekststørrelse, accessibility-labels)

### Utvikling
- Lage og begrunne funksjonelle krav (kravspesifikasjon)
- Implementere REST API med autentisering og feilhåndtering
- Versjonskontroll med Git og meningsfulle commit-meldinger

---

## Kom i gang

### 1. Start backend
```bash
cd backend
cp .env.example .env   # Fyll inn MySQL-opplysninger
npm install
node server.js
```

### 2. Sjekk at serveren kjører
```bash
curl http://localhost:3000/health
# → {"status":"ok","database":"tilkoblet"}
```

### 3. Åpne iOS-appen i Xcode
- Åpne `HelpdeskGuard.xcodeproj`
- Sett riktig server-IP i `HelpdeskGuard/APIService.swift` (variabelen `baseURL`)
- Velg simulator eller fysisk iPhone og trykk **Run**

---

## Dokumentasjon

| Dokument | Beskrivelse |
|---|---|
| [CHANGELOG.md](HelpdeskGuard/Docs/CHANGELOG.md) | Endringslogg for hvert arbeid |
| [TODO.md](HelpdeskGuard/Docs/TODO.md) | Gjenværende oppgaver |
| [AI.md](HelpdeskGuard/Docs/AI.md) | KI-bruk dokumentert |
| [PLAN.md](HelpdeskGuard/Docs/PLAN.md) | Prosjektplan og milepæler |
| [KRAVSPESIFIKASJON.md](HelpdeskGuard/Docs/KRAVSPESIFIKASJON.md) | Funksjonelle og ikke-funksjonelle krav |
| [KOMPETANSEMAPPE.md](HelpdeskGuard/Docs/KOMPETANSEMAPPE.md) | Kompetansemål med bevis |
| [USER_GUIDE.md](HelpdeskGuard/Docs/USER_GUIDE.md) | Brukerveiledning |
| [REFLEKSJON.md](HelpdeskGuard/Docs/REFLEKSJON.md) | Refleksjon over prosessen |
| [RISIKOANALYSE.md](HelpdeskGuard/Docs/RISIKOANALYSE.md) | Risiko og tiltak |
| [DRIFT_SETUP.md](HelpdeskGuard/Docs/DRIFT_SETUP.md) | Serveroppsett og sikring |
| [SECURITY.md](HelpdeskGuard/Docs/SECURITY.md) | Sikkerhetsnivå og begrensninger |

---

## Bruk av KI

KI er brukt som støtte under utvikling og dokumentasjon. All bruk er dokumentert i [AI.md](HelpdeskGuard/Docs/AI.md). All kode er gjennomgått og forstått av utvikler.

---

*© 2026 HelpdeskGuard – Skoleprosjekt av Fahad*
