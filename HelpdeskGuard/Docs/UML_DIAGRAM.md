# UML-diagram – HelpdeskGuard

## Klassediagram (ASCII)

```
┌──────────────────────────────────────┐
│              AuthStore               │
│──────────────────────────────────────│
│ + isLoggedIn: Bool                   │
│ + currentEmail: String?              │
│ + jwtToken: String?                  │
│──────────────────────────────────────│
│ + register(epost, passord) async     │
│ + login(epost, passord) async        │
│ + logout()                           │
│ + deleteCurrentUser()                │
│ - localLoadUsers()                   │
│ - localSaveUsers()                   │
└──────────────┬───────────────────────┘
               │ bruker token
               ▼
┌──────────────────────────────────────┐
│              TicketStore             │
│──────────────────────────────────────│
│ + tickets: [Ticket]                  │
│ + laster: Bool                       │
│──────────────────────────────────────│
│ + lastSaker(token) async             │
│ + addTicket(token, tittel, ...) async│
└──────────────┬───────────────────────┘
               │ inneholder
               ▼
┌──────────────────────────────────────┐
│               Ticket                 │
│──────────────────────────────────────│
│ + id: Int                            │
│ + tittel: String                     │
│ + beskrivelse: String                │
│ + kategori: String                   │
│ + prioritet: String                  │
│ + status: String                     │
│ + opprettet: String                  │
└──────────────────────────────────────┘

┌──────────────────────────────────────┐
│           API.swift (funksjoner)     │
│──────────────────────────────────────│
│ + apiRegistrer(epost, passord) async │
│ + apiLogginn(epost, passord) async   │
│ + apiHentSaker(token) async          │
│ + apiOpprettSak(token, ...) async    │
└──────────────────────────────────────┘
```

## Sekvensdiagram – Innlogging

```
iOS-app          AuthStore         API.swift         Backend
   │                  │                │                 │
   │── login() ──────►│                │                 │
   │                  │── apiLogginn()─►│                 │
   │                  │                │─── POST /logginn►│
   │                  │                │                 │
   │                  │                │◄── JWT-token ───│
   │                  │◄── token ──────│                 │
   │                  │ lagrer token   │                 │
   │◄── isLoggedIn ───│                │                 │
   │                  │                │                 │
```

## Sekvensdiagram – Opprett sak

```
iOS-app       NewTicketView      TicketStore        API.swift       Backend
   │                │                 │                 │               │
   │── Trykk ──────►│                 │                 │               │
   │                │── addTicket()──►│                 │               │
   │                │                 │── apiOpprettSak►│               │
   │                │                 │                 │─ POST /saker ►│
   │                │                 │                 │               │
   │                │                 │                 │◄── 201 OK ───│
   │                │                 │◄── true ────────│               │
   │                │                 │── lastSaker() ──►│               │
   │                │                 │◄── [Ticket] ────│               │
   │◄── oppdatert liste ─────────────│                 │               │
```