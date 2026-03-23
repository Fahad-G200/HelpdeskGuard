Drift Setup – HelpdeskGuard

Oversikt

Som en del av prosjektet HelpdeskGuard er det satt opp en Linux-server for å simulere drift av et IT-system.
Serveren brukes til testing, sikkerhetstiltak og senere backend for applikasjonen.

Serveren kjører som en virtuell maskin i Proxmox.

⸻

Infrastruktur

Virtualiseringsplattform

Proxmox VE

Virtuell maskin

Navn: helpdeskguard-server
Operativsystem: Ubuntu Server 22.04 LTS
CPU: 1 core
RAM: 2 GB
Disk: 32 GB
Nettverk: vmbr0 (bridge)

Serveren fikk IP-adresse via DHCP.

Eksempel:

172.20.128.51

⸻

Installasjon av operativsystem

Ubuntu Server 22.04 ble installert via ISO i Proxmox.

Under installasjonen ble følgende konfigurert:
    •    brukerkonto opprettet
    •    servernavn satt til helpdeskguard-server
    •    OpenSSH server installert
    •    nettverk konfigurert automatisk via DHCP

⸻

Oppdatering av systemet

Etter installasjon ble systemet oppdatert.

Kommandoer brukt:

sudo apt update
sudo apt upgrade -y

Dette installerer sikkerhetsoppdateringer og oppdaterer systempakker.

⸻

SSH tilgang

SSH ble installert under installasjonen av Ubuntu Server.

Serveren kan nå nås via SSH fra andre maskiner.

Eksempel:

ssh fahad@172.20.128.51

Dette gjør det mulig å administrere serveren eksternt.

⸻

Sikring av SSH

SSH-konfigurasjonen ble oppdatert i:

/etc/ssh/sshd_config

Følgende sikkerhetsinnstillinger ble brukt:

PermitRootLogin no
PasswordAuthentication yes
PubkeyAuthentication yes

Dette betyr:
    •    root kan ikke logge inn via SSH
    •    brukere logger inn med brukernavn og passord
    •    SSH-nøkler kan brukes senere

Konfigurasjonen ble testet og reloadet:

sudo sshd -t
sudo systemctl reload ssh


⸻

Firewall (UFW)

En firewall ble aktivert for å beskytte serveren.

Installerte og konfigurerte UFW:

sudo apt install ufw
sudo ufw allow OpenSSH
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

Status kan sjekkes med:

sudo ufw status verbose

Dette gjør at:
    •    alle innkommende forbindelser blokkeres
    •    SSH-porten (22) er tillatt
    •    utgående trafikk er tillatt

⸻

Fail2Ban

Fail2Ban ble installert for å beskytte serveren mot brute-force-angrep på SSH.

Installasjon:

sudo apt install fail2ban

Fail2Ban ble startet og aktivert:

sudo systemctl enable fail2ban
sudo systemctl start fail2ban

Konfigurasjon i:

/etc/fail2ban/jail.local

Konfigurasjon brukt:

[sshd]
enabled = true
port = ssh
logpath = %(sshd_log)s
backend = systemd
maxretry = 5
findtime = 10m
bantime = 1h

Dette betyr:
    •    hvis noen feiler SSH-login 5 ganger
    •    innen 10 minutter
    •    blir IP-adressen blokkert i 1 time

Status kan sjekkes med:

sudo fail2ban-client status
sudo fail2ban-client status sshd


⸻

Status etter oppsett

Serveren har nå:
    •    Ubuntu Server installert
    •    SSH tilgang
    •    firewall aktiv
    •    Fail2Ban aktiv
    •    grunnleggende SSH-sikkerhet

Dette gir et grunnleggende sikkert serveroppsett for videre utvikling av HelpdeskGuard-systemet.

⸻

Videre arbeid

Neste steg i prosjektet:
    •    installere Docker
    •    sette opp overvåking (Uptime Kuma)
    •    koble serveren til HelpdeskGuard backend
    •    dokumentere systemarkitektur
:::

Hvis du vil, kan jeg også lage:
    •    README.md for hele prosjektet
    •    CHANGELOG.md
    •    systemarkitektur-diagram
    •    brukerstøtte-guide


