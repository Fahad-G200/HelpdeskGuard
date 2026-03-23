# Server Hardening – HelpdeskGuard

## Mål
Sikre Ubuntu Server 22.04 etter installasjon slik at backend for HelpdeskGuard kan kjøres på en tryggere måte.

## Utført arbeid

### 1. UFW Firewall
Jeg konfigurerte UFW for å beskytte serveren mot uønsket innkommende trafikk.

Kommandoer:
```bash
sudo ufw allow OpenSSH
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo ufw status verbose

## Sikkerhet i HelpdeskGuard

Jeg har foreløpig sikret infrastrukturen og backend-miljøet, men app-sikkerheten er ikke ferdig implementert ennå.

### Utført
- UFW firewall
- Fail2Ban
- SSH-sikring
- lokal FastAPI-backend for utvikling

### Mangler fortsatt
- innlogging i API
- autentisering med Bearer-token / JWT
- sikker lagring av token i iOS-appen
- HTTPS for produksjon

### Vurdering
Prosjektet har startet på driftssikkerhet, men neste fase er å koble sikkerheten til selve appen gjennom autentisering og sikker klientkommunikasjon.
