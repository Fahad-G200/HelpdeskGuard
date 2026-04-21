# Drift Setup – HelpdeskGuard

## Oversikt
Som del av prosjektet er det satt opp et driftmiljo for a trene pa serverdrift, sikring og overvaking.

Miljoet er dokumentert som faglig arbeid i Drift, og er avgrenset fra appens v1.0-funksjoner.

## Infrastruktur
- Virtualisering: Proxmox VE
- VM-navn: `helpdeskguard-server`
- Operativsystem: Ubuntu Server 22.04 LTS
- Nettverk: bridge (`vmbr0`), IP via DHCP

## Grunnoppsett
- Oppdatert systempakker
- Aktivert SSH for administrasjon
- Grunnleggende hardening av SSH

Eksempel pa kommandoer brukt:
```bash
sudo apt update
sudo apt upgrade -y
sudo sshd -t
sudo systemctl reload ssh
```

## Sikring
- UFW konfigurert med default deny incoming
- SSH tillatt
- Fail2Ban aktivert for aa redusere brute-force-risiko

Eksempel pa kommandoer brukt:
```bash
sudo ufw allow OpenSSH
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo fail2ban-client status
```

## Status
Gjennomfort i driftmiljo:
- Ubuntu-oppsett
- SSH-tilgang
- UFW
- Fail2Ban

Planlagt videre:
- Mer detaljert logging
- Tettere kobling mellom driftmiljo og neste appfase
