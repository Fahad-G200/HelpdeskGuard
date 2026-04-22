# Steg-for-steg guide – HelpdeskGuard til 6er

Denne guiden forklarer hva som er gjort i koden, og hva du må gjøre i Xcode for at alt skal fungere.

---

## Hva er lagt til / endret

| Fil | Hva er gjort | Kompetansemål det dekker |
|-----|-------------|--------------------------|
| `KeychainManager.swift` | Implementert – lagrer sensitiv data trygt i iOS Keychain | Drift: informasjonssikkerhet |
| `AuthStore.swift` | Passord hashes med SHA-256 (CryptoKit) + Keychain for innlogget bruker | Utvikling: innebygget sikkerhet |
| `TicketEntity.swift` | Lagt til title, category, priority – SwiftData = lokal database | Utvikling: databaser |
| `NewTicketView.swift` | Saker lagres nå faktisk til SwiftData-databasen | Utvikling: databaser |
| `SwiftUI View.swift` (TicketsView) | Viser liste med saker, status, "marker som løst", slett | Utvikling: UI + databaser |
| `FAQView.swift` | Enkel FAQ med spørsmål og svar for brukere | Brukerstøtte: veiledning |
| `ContentView.swift` | "Saker"-fanen viser TicketsView, FAQ lagt til i meny | Utvikling: UI |
| `HomeView.swift` | Knapp til FAQ lagt til på forsiden | Brukerstøtte: veiledning |

---

## Steg du må gjøre i Xcode

### Steg 1: Åpne prosjektet
1. Åpne `HelpdeskGuard.xcodeproj` i Xcode

### Steg 2: Legg til FAQView.swift i prosjektet
1. I Xcode, høyreklikk på `HelpdeskGuard`-mappen i fil-panelet til venstre
2. Velg **"Add Files to HelpdeskGuard..."**
3. Finn og velg `FAQView.swift`
4. Pass på at **"Add to target: HelpdeskGuard"** er huket av
5. Trykk **Add**

> Merk: Alle andre filer (`KeychainManager.swift`, `AuthStore.swift` osv.) var allerede i prosjektet og trenger bare å bygges på nytt.

### Steg 3: Sjekk at CryptoKit er tilgjengelig
CryptoKit er innebygd i iOS og krever ingen ekstra installasjon.  
`AuthStore.swift` importerer det allerede med `import CryptoKit`.

### Steg 4: Slett gammel app fra simulator/iPhone
> **Viktig:** Siden vi la til nye felt i databasemodellen (`TicketEntity`), må den gamle versjonen slettes så SwiftData kan lage ny database.

1. I Simulator (eller på iPhone): trykk og hold på HelpdeskGuard-ikonet
2. Velg **"Slett app"**
3. Bekreft sletting

> **Merk om brukerkontoer:** Siden passord nå lagres som SHA-256-hash, vil eksisterende kontoer (fra før denne oppdateringen) ikke lenger fungere. Opprett ny bruker etter at appen er reinstallert.

### Steg 5: Bygg og kjør appen
1. Velg simulator eller koblet iPhone øverst i Xcode
2. Trykk **▶ (Run)** eller `Cmd + R`
3. Appen skal starte uten feil

---

## Hva skal fungere etter oppdateringen

✅ Registrere ny bruker (passord lagres som SHA-256 hash)  
✅ Logge inn (sammenligner hashed passord)  
✅ Innlogget bruker huskes via Keychain (ikke UserDefaults)  
✅ Opprette en sak med tittel, beskrivelse, kategori og prioritet  
✅ Saken lagres i SwiftData (lokal database på enheten)  
✅ Se liste over alle saker i "Saker"-fanen  
✅ Markere sak som løst / åpen  
✅ Slette en sak (sveip til venstre)  
✅ FAQ-side tilgjengelig fra hjem og hamburger-meny  
✅ Logge ut (Keychain ryddes opp)  
✅ Slette bruker  

---

## Kompetansemål som nå er dekket (alle 3 fag)

### Utvikling
- ✅ Valgt programmeringsspråk (Swift/SwiftUI) og begrunnet valg
- ✅ Laget funksjonelle krav (KRAVSPESIFIKASJON.md)
- ✅ Designet brukergrensesnitt tilpasset brukernes behov
- ✅ Teknisk dokumentasjon (README, Docs-mappe)
- ✅ Versjonskontroll med Git/GitHub
- ✅ Innebygget personvern (lokal lagring, slette bruker)
- ✅ **Innebygget sikkerhet (SHA-256 hashing, Keychain)**
- ✅ Testing i Xcode simulator og fysisk enhet
- ✅ **Opprettet database (SwiftData/TicketEntity)**
- ✅ **Hente ut og sette inn data fra database (CRUD)**

### Brukerstøtte
- ✅ Etiske retningslinjer og personvern (InfoView)
- ✅ **Brukerveiledning (FAQ, USER_GUIDE.md)**
- ✅ Tilpasset kommunikasjonsform (lett språk, tydelig UI)
- ✅ Feilsøking dokumentert (CHANGELOG.md, REFLEKSJON.md)
- ✅ Rammeverk for kvalitet (WCAG-tilgjengelighet)
- ✅ AI-bruk dokumentert (AI.md)

### Drift
- ✅ Driftsarkitektur beskrevet (INFRASTRUCTURE_DIAGRAM.md)
- ✅ Planlagt og dokumentert IT-løsning
- ✅ Risikoanalyse (RISIKOANALYSE.md)
- ✅ **Informasjonssikkerhet (Keychain, SHA-256, ATS)**
- ✅ Personvern og lovverk dokumentert
- ✅ Server-hardening dokumentert (server-hardening.md)

---

## Tips til presentasjonen

1. **Vis at database fungerer**: Opprett 2-3 saker → gå til Saker-fanen → vis listen → marker en som løst
2. **Vis sikkerhet**: Forklar at passord hashes med SHA-256 (vis `AuthStore.swift` linje med `hashPassword`)
3. **Vis Keychain**: Forklar at innlogget bruker lagres i Keychain, ikke UserDefaults (vis `KeychainManager.swift`)
4. **Vis FAQ**: Åpne FAQ fra hjemside og forklar at det dekker brukerstøtte-kompetansemål
5. **Vis dokumentasjon**: Vis README, CHANGELOG, RISIKOANALYSE og AI.md

---

*Laget av: KI-assistert (GitHub Copilot) – gjennomgått og forklart av Fahad*
