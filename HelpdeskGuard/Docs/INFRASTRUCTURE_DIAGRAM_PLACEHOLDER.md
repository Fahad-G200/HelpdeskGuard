# Infrastrukturdiagram – HelpdeskGuard

```
┌─────────────────────────────────────────────────────────────────┐
│                         iOS-APP (Klient)                        │
│   SwiftUI · URLSession · JWT-token · async/await                │
└──────────────────────────┬──────────────────────────────────────┘
                           │ HTTP/HTTPS port 3000
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│                      NODE.JS API (DMZ)                          │
│   Express · bcrypt · jsonwebtoken · rate-limit                  │
│   Endepunkter: /registrer  /logginn  /saker  /brukere/meg       │
└──────────────────────────┬──────────────────────────────────────┘
                           │ Port 3306 (intern)
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│                    MYSQL DATABASE (Intern sone)                  │
│   Tabeller: brukere · saker                                     │
│   Ikke eksponert mot internett                                  │
└──────────────────────────┬──────────────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────────────┐
│              UBUNTU SERVER 22.04 LTS (Proxmox VM)               │
│   UFW brannmur · Fail2Ban · SSH-herding · Uptime Kuma           │
└─────────────────────────────────────────────────────────────────┘
```

## Nettverkssegmentering

- **Klient-sone**: iOS-appen sender bare krypterte forespørsler til API.
- **DMZ**: Node.js-serveren er eksponert på port 3000. MySQL er ikke synlig utenfra.
- **Intern sone**: MySQL lytter kun på 127.0.0.1 – ikke tilgjengelig fra nett.
- **Drift-sone**: SSH begrenset, Fail2Ban blokkerer brute-force, Uptime Kuma overvåker.

## Teknologistack

| Komponent | Teknologi |
|-----------|-----------|
| iOS-app | SwiftUI + Swift |
| API | Node.js + Express |
| Passord | bcrypt |
| Token | JWT (7 dagers utløp) |
| Database | MySQL 8 |
| Server | Ubuntu 22.04 / Proxmox |
| Brannmur | UFW |
| Beskyttelse | Fail2Ban |
| Overvåking | Uptime Kuma |
