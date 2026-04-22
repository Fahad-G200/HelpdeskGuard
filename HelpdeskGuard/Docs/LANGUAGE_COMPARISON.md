# Programmeringsspråk-sammenligning – HelpdeskGuard

## Oversikt

Dette dokumentet sammenligner programmeringsspråkene og teknologiene brukt i HelpdeskGuard, og begrunner valgene som er tatt.

---

## iOS-klient: Swift vs. andre alternativer

| Kriterium | Swift | Kotlin (Android) | React Native | Flutter |
|----------|-------|-----------------|-------------|---------|
| Platform | iOS/macOS | Android | iOS + Android | iOS + Android |
| Ytelse | Svært høy | Høy | Middels | Høy |
| UI-rammeverk | SwiftUI | Jetpack Compose | React | Dart/Widgets |
| Apple-integrasjon | Innebygd | Nei | Begrenset | Begrenset |
| Sikkerhet | Sterk typekontroll | Sterk typekontroll | Dynamisk | Sterk typekontroll |
| Læringsterskel | Middels | Middels | Lav (JS-kjennskap) | Middels |

### Valg: Swift + SwiftUI
**Begrunnelse**: Prosjektet er en iOS-app. Swift er Apples offisielle språk og gir best ytelse, sikkerhet og tilgang til iOS-funksjoner. SwiftUI gjør det enkelt å bygge moderne UI med lite kode og god støtte for universell utforming (dynamisk tekststørrelse, VoiceOver).

---

## Backend: Node.js vs. andre alternativer

| Kriterium | Node.js (valgt) | Python/FastAPI | Go | Java/Spring |
|-----------|----------------|----------------|----|-----------  |
| Ytelse | Høy (event-loop) | God | Svært høy | God |
| Kodevolum | Lite | Lite | Middels | Mye |
| JWT-støtte | Innebygd (jsonwebtoken) | God (PyJWT) | God | God |
| MySQL-støtte | mysql2-pakke | SQLAlchemy | go-sql-driver | JDBC/Hibernate |
| Læringsterskel | Lav (JavaScript) | Lav (Python) | Middels | Høy |
| Egnethet for prototyper | Svært god | Svært god | Middels | Lav |

### Valg: Node.js + Express
**Begrunnelse**: Node.js er lett å sette opp, har et enormt pakke-økosystem (npm), og JavaScript er et språk mange kjenner fra før. Express gjør det enkelt å lage REST API med minimal kode. bcrypt, jsonwebtoken og express-rate-limit er modne og veldokumenterte pakker.

**Tidligere brukte vi FastAPI (Python)** – skiftet til Node.js for bedre integrasjon med MySQL2-pakken og enklere asynkron håndtering uten ekstra server (uvicorn).

---

## Database: MySQL vs. andre alternativer

| Kriterium | MySQL (valgt) | SQLite | PostgreSQL | MongoDB |
|----------|--------------|--------|-----------|---------|
| Type | Relasjonell | Relasjonell (fil) | Relasjonell | Dokument (NoSQL) |
| Ytelse | God | God (liten skala) | Svært god | God |
| CASCADE-sletting | Støttet | Støttet | Støttet | Nei (manuelt) |
| Flerbrukerstøtte | Ja | Begrenset | Ja | Ja |
| Oppsett | Krever server | Ingen server | Krever server | Krever server |
| Egnethet | Produksjon | Prototyper | Produksjon | Fleksible data |

### Valg: MySQL
**Begrunnelse**: MySQL er industristandard for relasjonsdatabaser, støtter `FOREIGN KEY ... ON DELETE CASCADE` (nyttig for å slette brukerens saker automatisk), og er godt støttet av `mysql2`-pakken i Node.js. SQLite ble vurdert for enkelhet, men MySQL er bedre egnet for flerbrukermiljøer.

---

## Programmeringsspråk – sammendrag

| Lag | Teknologi | Språk | Begrunnelse |
|----|-----------|-------|------------|
| iOS-app | SwiftUI | Swift | Apple-native, typesikker, moderne async/await |
| API-server | Express | JavaScript (Node.js) | Enkelt, stort pakke-økosystem, asynkron |
| Database | MySQL | SQL | Relasjonell, CASCADE, industristandard |
| Driftskript | Bash | Shell | Standard på Ubuntu, enkel automatisering |

---

## Asynkron programmering: Swift async/await vs. callbacks

I dette prosjektet brukes **async/await** i Swift for nettverkskall. Dette er en moderne tilnærming som er lettere å lese enn eldre callback-basert kode.

```swift
// Gammelt mønster (callbacks) – vanskelig å lese
URLSession.shared.dataTask(with: req) { data, resp, err in
    // Kode her
}.resume()

// Nytt mønster (async/await) – lettere å lese og forstå
let (data, resp) = try await URLSession.shared.data(for: req)
```

async/await er nå standardmåten å skrive asynkron kode i Swift (fra Swift 5.5/iOS 15).
