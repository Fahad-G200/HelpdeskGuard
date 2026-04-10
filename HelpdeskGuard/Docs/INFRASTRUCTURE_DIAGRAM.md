# Infrastrukturdiagram – HelpdeskGuard

```mermaid
graph TD
    A[iOS App / SwiftUI] -->|Login / Tickets| B[FastAPI Backend]
    B --> C[SQLite Database]
    B --> D[Docker Container]
    D --> E[Ubuntu Server 22.04]
    E --> F[Proxmox VE]
    G[Uptime Kuma] -->|overvåker| D
    H[UFW Firewall] -->|beskytter| E
    I[Fail2Ban] -->|beskytter SSH| E
```

## Komponenter

| Komponent | Rolle |
|--------|--------|
| iOS App | Brukergrensesnitt |
| FastAPI | Backend API |
| SQLite | Databaselagring |
| Docker | Kjøremiljø |
| Ubuntu | Server |
| Proxmox | Virtualisering |
| Uptime Kuma | Overvåking |
| UFW | Brannmur |
| Fail2Ban | Beskyttelse mot angrep |
