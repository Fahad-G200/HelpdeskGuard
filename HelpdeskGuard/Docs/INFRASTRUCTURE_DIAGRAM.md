# Infrastrukturdiagram – HelpdeskGuard (ASCII)

## Systemoversikt med nettverkssegmentering

```
┌─────────────────────────────────────────────────────────────────┐
│                        BRUKER / KLIENT                          │
│                                                                 │
│   ┌─────────────────┐                                          │
│   │  iOS-app         │  SwiftUI, URLSession, JWT-token          │
│   │  (iPhone/Sim.)   │                                          │
│   └────────┬────────┘                                          │
└────────────┼────────────────────────────────────────────────────┘
             │ HTTPS / HTTP (port 3000)
             │
┌────────────▼────────────────────────────────────────────────────┐
│                    DMZ – EKSPONERT SONE                         │
│                                                                 │
│   ┌─────────────────────────────────┐                          │
│   │  Node.js / Express API           │  Port 3000               │
│   │  - POST /registrer               │  JWT-autentisering        │
│   │  - POST /logginn                 │  bcrypt passord-hashing   │
│   │  - GET  /saker  (krever JWT)     │  Rate limiting            │
│   │  - POST /saker  (krever JWT)     │                          │
│   │  - PATCH /saker/:id/lost         │                          │
│   │  - DELETE /brukere/meg           │                          │
│   └───────────────┬─────────────────┘                          │
│                   │                                             │
│   ┌───────────────▼─────────────────┐                          │
│   │  UFW Brannmur                    │  Blokkerer uautoriserte  │
│   │  Fail2Ban                        │  forespørsler            │
│   └───────────────┬─────────────────┘                          │
└───────────────────┼─────────────────────────────────────────────┘
                    │ Intern nettverkstrafikk
                    │
┌───────────────────▼─────────────────────────────────────────────┐
│                    INTERN SONE – DATABASE                       │
│                                                                 │
│   ┌─────────────────────────────────┐                          │
│   │  MySQL Database                  │  Port 3306 (intern)      │
│   │  - Tabell: brukere               │  Ikke eksponert ut       │
│   │  - Tabell: saker                 │  Passord via .env        │
│   └─────────────────────────────────┘                          │
│                                                                 │
│   ┌─────────────────────────────────┐                          │
│   │  Ubuntu Server 22.04 LTS         │                          │
│   │  (Proxmox VE VM)                 │  SSH (port 22, begrenset)│
│   └─────────────────────────────────┘                          │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                    OVERVÅKING / DRIFT                           │
│                                                                 │
│   ┌──────────────┐   ┌──────────────┐   ┌──────────────┐       │
│   │ Uptime Kuma  │   │  SSH-tilgang │   │ Fail2Ban     │       │
│   │ (helsejekk)  │   │  (admin)     │   │ (beskyttelse)│       │
│   └──────────────┘   └──────────────┘   └──────────────┘       │
└─────────────────────────────────────────────────────────────────┘
```

## Nettverkssegmentering

| Sone | Innhold | Tilgang |
|------|---------|---------|
| Klient | iOS-app | Kun port 3000 ut |
| DMZ | Node.js API, UFW, Fail2Ban | Port 3000 inn, port 3306 intern |
| Intern | MySQL, Ubuntu VM | Ingen direkte tilgang utenfra |
| Drift | Uptime Kuma, SSH | Kun admin-brukere |

## Teknologikomponenter

| Komponent | Teknologi | Rolle |
|-----------|-----------|-------|
| iOS-app | SwiftUI, Swift | Brukergrensesnitt |
| API-server | Node.js + Express | Backend REST API |
| Autentisering | JWT (jsonwebtoken) | Tokensikkerhet |
| Passord | bcrypt | Hashing |
| Database | MySQL 8 | Datalagring |
| Server | Ubuntu 22.04 LTS | VM via Proxmox |
| Brannmur | UFW | Nettverkssikring |
| Angrepsblokk | Fail2Ban | SSH-beskyttelse |
| Overvåking | Uptime Kuma | Tilgjengelighet |
