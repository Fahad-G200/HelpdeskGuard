# ITIL-kvalitetsrammeverk – HelpdeskGuard

## Hva er ITIL?

ITIL (Information Technology Infrastructure Library) er et rammeverk for IT-tjenestestyring (ITSM). Det gir beste praksis for hvordan IT-tjenester planlegges, leveres, støttes og forbedres.

I dette prosjektet bruker vi ITIL-prinsipper for å strukturere helpdesk-prosessene i HelpdeskGuard.

---

## ITIL 4 – Sentrale prinsipper brukt i HelpdeskGuard

| ITIL-prinsipp | Anvendelse i HelpdeskGuard |
|--------------|--------------------------|
| **Fokuser på verdi** | Appen gir brukere enkel tilgang til å registrere IT-problemer |
| **Start der du er** | Vi bygger videre på eksisterende SwiftUI-kodebase |
| **Jobb iterativt med tilbakemelding** | Funksjonalitet legges til i versjoner (v1.0 → v1.1) |
| **Tenk og arbeid helhetlig** | Frontend, backend, database og drift sees i sammenheng |
| **Hold det enkelt** | Koden er skrevet med norske kommentarer for forståelse |
| **Optimaliser og automatiser** | Rate limiting, JWT og bcrypt automatiserer sikkerhet |

---

## ITIL Tjenestelivssyklus

### 1. Tjenestestrategi
- **Mål**: Gi IT-brukere en enkel kanal for å rapportere problemer.
- **Målgruppe**: Studenter og IT-ansatte på skolen.
- **Forretningsverdi**: Raskere feilretting, bedre oversikt over IT-problemer.

### 2. Tjenestedesign
- REST API med klare endepunkter (registrer, logginn, saker).
- Brukergrensesnitt tilpasset universell utforming (WCAG).
- Sikkerhet designet inn fra starten (security by design).

### 3. Tjenesteutvikling (Service Transition)
- Git brukes for versjonskontroll og sporing av endringer.
- CHANGELOG.md dokumenterer alle endringer.
- Testing gjennomføres manuelt i simulator og på fysisk enhet.

### 4. Tjenestedrift (Service Operation)
- Uptime Kuma overvåker at API-serveren er tilgjengelig.
- Fail2Ban og UFW beskytter serveren.
- Logger i Node.js hjelper med feilsøking.

### 5. Kontinuerlig forbedring
- Tilbakemelding fra testing brukes til å prioritere neste funksjonalitet.
- Risikoanalyse (RISIKOANALYSE.md) identifiserer forbedringsområder.

---

## Incident Management (Hendelseshåndtering)

Slik håndteres hendelser i HelpdeskGuard:

```
Bruker opplever problem
        │
        ▼
Bruker registrerer sak i appen (tittel, beskrivelse, kategori, prioritet)
        │
        ▼
Saken lagres i MySQL via API
        │
        ▼
IT-ansatt ser saken og håndterer problemet
        │
        ▼
Saken markeres som løst: PATCH /saker/:id/lost
        │
        ▼
Bruker ser oppdatert status i appen
```

---

## Service Desk – Kategorier og prioriteter

| Kategori | Eksempel |
|---------|---------|
| Programvare | App krasjer, feil i program |
| Maskinvare | PC slår seg ikke på, skjerm fungerer ikke |
| Nettverk | Ingen internettilgang, Wi-Fi fungerer ikke |
| Annet | Passordproblemer, generelle spørsmål |

| Prioritet | Responstid (mål) | Eksempel |
|---------|-----------------|---------|
| Høy | Umiddelbart | Server nede, sikkerhetsbrudd |
| Normal | Samme dag | Program fungerer ikke |
| Lav | Innen 3 dager | Kosmetiske problemer |

---

## KPI-er (Key Performance Indicators)

Målbare kvalitetsindikatorer for helpdesk-tjenesten:

| KPI | Mål | Hvordan måles |
|----|-----|--------------|
| Antall åpne saker | Under 10 | Telling i database |
| Løsningshastighet | 80% løst innen 24t | Tidsstempel i saker-tabell |
| Systemtilgjengelighet | 99% oppetid | Uptime Kuma |
| Brukerregistreringer | Stiger over tid | Telling i brukere-tabell |

---

## Avgrensning

Dette er en skoleprototype. ITIL-prinsippene er beskrevet konseptuelt. Et fullstendig ITSM-system vil kreve dedikert ITSM-programvare (f.eks. ServiceNow, Jira Service Management).
