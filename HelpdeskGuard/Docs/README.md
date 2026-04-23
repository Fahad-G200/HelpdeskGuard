# HelpdeskGuard
Versjon 1.1  
Prosjektperiode: Mars–April 2026

---

## Introduksjon
HelpdeskGuard er et tverrfaglig skoleprosjekt i VG2 IT (Drift, Brukerstøtte og Utvikling). Prosjektet er en fungerende helpdesk-app for iOS, koblet mot en Node.js/MySQL-backend med JWT-autentisering.

---

## Hvordan kjøre prosjektet

### Backend (Node.js + MySQL)
1. Sørg for at MySQL kjører lokalt (f.eks. via Homebrew: `brew services start mysql`)
2. Opprett database og tabeller: `mysql -u root -p < backend/schema.sql`
3. Kopier miljøfil og fyll inn dine verdier: `cp backend/.env.example backend/.env`
4. Installer avhengigheter: `cd backend && npm install`
5. Start serveren: `node server.js`
6. Test at den kjører: `curl http://localhost:3000/health`

### iOS-app (Xcode)
1. Åpne `HelpdeskGuard.xcodeproj` i Xcode
2. Velg iOS Simulator eller fysisk iPhone
3. Trykk Run (⌘R)
4. Registrer bruker, logg inn og opprett en ny sak

**Merk:** På fysisk iPhone må `API_URL` i `API.swift` byttes til din maskins LAN-IP (f.eks. `http://192.168.1.x:3000`).

---

## Hva appen gjør (v1.1)
- Registrering og innlogging av bruker (via backend med bcrypt + JWT)
- Opprettelse av sak (tittel, beskrivelse, kategori, prioritet)
- Vise liste over alle egne saker med status
- Markere sak som løst (knapp direkte i saklisten)
- Logg ut og slett bruker
- Informasjonsside om personvern og regler
- Fallback til lokal lagring hvis serveren ikke er tilgjengelig

---

## Status på funksjoner
| Funksjon | Status |
|---|---|
| Registrering | ✅ Ferdig |
| Innlogging/utlogging | ✅ Ferdig |
| Opprette sak | ✅ Ferdig |
| Vise saksliste | ✅ Ferdig |
| Markere sak som løst | ✅ Ferdig |
| Backend-integrasjon (JWT) | ✅ Ferdig |
| Slette bruker | ✅ Ferdig |
| HTTPS i produksjon | 🔄 Planlagt |

---

## Teknologier brukt

| Teknologi | Bruk |
|---|---|
| SwiftUI | iOS-grensesnitt |
| Node.js + Express | REST API-backend |
| MySQL | Databaselagring |
| bcrypt | Sikker passord-hashing |
| JWT (JSON Web Token) | Autentisering mellom app og backend |
| express-rate-limit | Beskyttelse mot brute-force |
| UserDefaults | Lokal fallback-lagring |
| Git/GitHub | Versjonskontroll |

Begrunnelse for teknologivalg: Se [LANGUAGE_COMPARISON.md](LANGUAGE_COMPARISON.md)

---

## Prosjektstruktur
```
HelpdeskGuard/
├── HelpdeskGuard/         ← iOS Swift-kode
│   ├── API.swift          ← Nettverkskall mot backend
│   ├── AuthStore.swift    ← Innlogging og JWT-håndtering
│   ├── TicketStore.swift  ← Saker (hente, opprette, løse)
│   ├── Ticket.swift       ← Datamodell som matcher MySQL
│   ├── ContentView.swift  ← Navigasjon og TabView
│   ├── LoginView.swift    ← Innlogging
│   ├── RegisterView.swift ← Registrering
│   ├── NewTicketView.swift← Ny sak + saksliste
│   ├── HomeView.swift     ← Startside
│   ├── AppTheme.swift     ← Felles design
│   └── Docs/              ← All prosjektdokumentasjon
├── backend/
│   ├── server.js          ← REST API (Node.js + Express)
│   ├── schema.sql         ← MySQL-skjema
│   ├── package.json       ← Avhengigheter
│   └── .env.example       ← Miljøvariabler-mal
└── schema.sql             ← Kopi av backend/schema.sql
```

---

## Kompetansemål som dekkes

### Drift
- Planlegge og dokumentere arbeidsprosesser og IT-løsninger
- Gjennomføre risikoanalyse og foreslå tiltak
- Planlegge/drifte løsning med informasjonssikkerhet (JWT, bcrypt, rate limiting)
- Administrere brukere, tilganger og rettigheter (brukertabell, JWT-beskyttede ruter)

### Brukerstøtte
- Kartlegge behov og utvikle veiledninger (USER_GUIDE.md)
- Gjøre rede for etiske retningslinjer og lovverk (GDPR.md)
- Reflektere over intelligente systemer (AI.md)
- Rammeverk for kvalitetssikring (ITIL_QUALITY.md)

### Utvikling
- Lage og begrunne funksjonelle krav (KRAVSPESIFIKASJON.md)
- Modellere og opprette databaser (schema.sql + MySQL)
- Versjonskontroll (Git/GitHub)
- Sikkerhet i applikasjoner (JWT, bcrypt, rate limiting, GDPR)
- Testing (TEST_RAPPORT.md)
- Teknisk dokumentasjon (Docs-mappen)

---

## Dokumentasjon
- [CHANGELOG.md](CHANGELOG.md)
- [TODO.md](TODO.md)
- [AI.md](AI.md)
- [PLAN.md](PLAN.md)
- [KRAVSPESIFIKASJON.md](KRAVSPESIFIKASJON.md)
- [USER_GUIDE.md](USER_GUIDE.md)
- [REFLEKSJON.md](REFLEKSJON.md)
- [RISIKOANALYSE.md](RISIKOANALYSE.md)
- [GDPR.md](GDPR.md)
- [SECURITY.md](SECURITY.md)
- [UML_DIAGRAM.md](UML_DIAGRAM.md)
- [INFRASTRUCTURE_DIAGRAM.md](INFRASTRUCTURE_DIAGRAM.md)
- [KOMPETANSEMAPPE.md](KOMPETANSEMAPPE.md)
- [TEST_RAPPORT.md](TEST_RAPPORT.md)
- [LANGUAGE_COMPARISON.md](LANGUAGE_COMPARISON.md)
- [ITIL_QUALITY.md](ITIL_QUALITY.md)
