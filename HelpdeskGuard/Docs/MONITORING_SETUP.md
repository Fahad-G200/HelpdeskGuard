Monitoring Setup – HelpdeskGuard

Oversikt

Som en del av drift-oppsettet for HelpdeskGuard ble det installert et overvåkingssystem på serveren.
Formålet er å kunne overvåke tjenester og sikre stabil drift.

Overvåkingen ble satt opp ved hjelp av Docker og Uptime Kuma.

⸻

Installasjon av Docker

Docker ble installert for å kunne kjøre tjenester i containere.

Kommando brukt:

sudo apt install docker.io -y

Etter installasjonen ble Docker aktivert og startet.

sudo systemctl enable docker
sudo systemctl start docker

For å kontrollere at Docker fungerer ble følgende kommando brukt:

sudo systemctl status docker

Hvis Docker kjører riktig vil status vise:

active (running)


⸻

Test av Docker

For å teste at Docker fungerer korrekt ble en test-container kjørt.

sudo docker run hello-world

Hvis installasjonen er riktig vil Docker skrive en melding som bekrefter at systemet fungerer.

⸻

Installasjon av Uptime Kuma

Uptime Kuma er et overvåkingssystem som kan overvåke tjenester og servere.

Containeren ble startet med følgende kommando:

sudo docker run -d \
--restart=always \
-p 3001:3001 \
-v uptime-kuma:/app/data \
--name uptime-kuma \
louislam/uptime-kuma

Dette gjør følgende:
    •    starter en Docker-container
    •    åpner port 3001
    •    lagrer data i en Docker volume
    •    sørger for at containeren starter automatisk ved reboot

⸻

Tilgang til overvåkingssystemet

Overvåkingspanelet kan nås via nettleser.

Adresse:

http://SERVER_IP:3001

Eksempel:

http://172.20.128.51:3001

Når siden åpnes første gang opprettes en administratorkonto.

⸻

Hva overvåkingen brukes til

Uptime Kuma kan brukes til å overvåke:
    •    servertilgjengelighet
    •    webtjenester
    •    API-endepunkter
    •    nettverkstjenester

Dette gjør det mulig å oppdage problemer tidlig og sikre stabil drift.

⸻

Relevans for IT-drift

Dette oppsettet demonstrerer flere viktige konsepter innen IT-drift:
    •    installasjon av tjenester
    •    bruk av containerteknologi (Docker)
    •    systemovervåking
    •    administrasjon av Linux-server

⸻

Videre arbeid

Neste steg i prosjektet kan være:
    •    overvåke HelpdeskGuard backend
    •    overvåke SSH og servertilgjengelighet
    •    konfigurere varsler i Uptime Kuma
    •    dokumentere systemarkitektur
