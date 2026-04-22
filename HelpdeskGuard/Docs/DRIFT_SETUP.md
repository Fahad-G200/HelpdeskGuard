# Drift Setup – HelpdeskGuard

## Oversikt
Som del av prosjektet er det satt opp et driftmiljø for å trene på serverdrift, sikring og overvåking.

Miljøet er dokumentert som faglig arbeid i Drift, og er avgrenset fra appens v1.0-funksjoner.

## Infrastruktur
- Virtualisering: Proxmox VE
- VM-navn: `helpdeskguard-server`
- Operativsystem: Ubuntu Server 22.04 LTS
- Nettverk: bridge (`vmbr0`), IP via DHCP

## Grunnoppsett
- Oppdatert systempakker
- Aktivert SSH for administrasjon
- Grunnleggende hardening av SSH

Eksempel på kommandoer brukt:
```bash
sudo apt update
sudo apt upgrade -y
sudo sshd -t
sudo systemctl reload ssh
```

## Sikring
- UFW konfigurert med default deny incoming
- SSH tillatt
- Fail2Ban aktivert for å redusere brute-force-risiko

Eksempel på kommandoer brukt:
```bash
sudo ufw allow OpenSSH
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo fail2ban-client status
```

## Nettverkssegmentering

Nettverkssegmentering betyr å dele nettverket i separate soner slik at en kompromitert del ikke gir tilgang til alt.

### Soner i HelpdeskGuard

| Sone | Hva er der | Tilgang |
|------|-----------|---------|
| Klient-sone | iOS-app (iPhone/Simulator) | Kan nå API på port 3000 |
| DMZ (Demilitarisert sone) | Node.js API-server | Port 3000 inn, port 3306 bare internt |
| Intern sone | MySQL-database | Ingen direkte tilgang fra nett |
| Administrasjon | SSH-tilgang, Uptime Kuma | Kun admin-brukere, begrenset IP |

### Praktisk oppsett med UFW

```bash
# Tillat kun nødvendige porter
sudo ufw allow 22/tcp    # SSH
sudo ufw allow 3000/tcp  # Node.js API

# MySQL eksponeres IKKE – kun lokal tilgang
# MySQL lytter på 127.0.0.1 i /etc/mysql/mysql.conf.d/mysqld.cnf
```

### Konsept: VLAN-segmentering (fremtidig utvidelse)

I et produksjonsmiljø kan man bruke VLAN (Virtual Local Area Network) for å isolere trafikk:
- **VLAN 10** – Klientnett (brukere og apper)
- **VLAN 20** – Servernett (API og database)
- **VLAN 30** – Administrasjonsnet (SSH, overvåking)

Trafikk mellom VLAN kontrolleres av en ruter/brannmur med ACL-regler (Access Control Lists).

## Status
Gjennomført i driftmiljø:
- Ubuntu-oppsett
- SSH-tilgang
- UFW med portregler
- Fail2Ban
- Node.js + MySQL backend

Planlagt videre:
- VLAN-segmentering i Proxmox
- HTTPS med Let's Encrypt
- Tettere kobling mellom driftmiljø og neste appfase
