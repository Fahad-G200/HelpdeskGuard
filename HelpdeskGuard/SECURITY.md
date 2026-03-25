# HelpdeskGuard – Dokumentasjon av oppsett, sikring og feilsøking

## Innledning

Dette dokumentet beskriver hvordan jeg satte opp og sikret prosjektet HelpdeskGuard fra start til slutt. Prosjektet kombinerer driftsstøtte, utvikling og brukerstøtte gjennom oppsett av virtuell server i Proxmox, installasjon av Ubuntu Server, oppsett av backend og sikring av iOS-appen i Xcode.

Målet med prosjektet var å bygge en løsning for håndtering av IT-tickets, samtidig som jeg dokumenterte arbeidsprosessen og viste hvordan sikkerhet kan bygges inn i både infrastruktur, backend og app.

---

## 1. Oppsett av infrastruktur i Proxmox

Jeg startet med å opprette en virtuell maskin i Proxmox VE. Dette ga meg en isolert og kontrollert plattform for videre arbeid.

### Virtuell maskin

- Plattform: Proxmox VE
- Navn: `helpdeskguard-server`
- Operativsystem: Ubuntu Server 22.04 LTS
- CPU: 1 core
- RAM: 2048 MB
- Disk: 32 GB
- Nettverk: `vmbr0` bridge
- IP-adresse: tildelt via DHCP

Dette oppsettet viser kompetanse innen virtualisering og drift av virtuelle tjenester.

---

## 2. Installasjon av Ubuntu Server

Etter at VM-en var opprettet, installerte jeg Ubuntu Server 22.04 LTS. Under installasjonen opprettet jeg bruker og aktiverte OpenSSH slik at serveren kunne administreres via terminal.

### Installasjonssteg

1. Opprettet VM i Proxmox
2. Lastet opp Ubuntu Server ISO
3. Installerte Ubuntu Server
4. Konfigurerte bruker
5. Installerte OpenSSH server
6. Koblet serveren til nettverk via DHCP

Dette dekket grunnleggende kompetanse innen operativsysteminstallasjon og serveradministrasjon.

---

## 3. Første feil og systemreparasjon

Etter installasjonen oppstod en feil i pakkesystemet. Terminalen viste at `dpkg` var avbrutt.

### Feil som oppstod

Jeg fikk melding om at pakkesystemet var avbrutt under installasjon. Dette betydde at Ubuntu ikke var ferdig konfigurert, og at oppdateringene måtte fullføres manuelt.

### Løsning

Jeg brukte følgende kommandoer:

```bash
sudo dpkg --configure -a
sudo apt update
sudo apt upgrade -y

Refleksjon

Denne feilen viste hvor viktig det er å forstå hvordan Linux håndterer pakker og systemoppdateringer. I stedet for å reinstallere hele serveren, løste jeg problemet ved å fullføre den avbrutte konfigurasjonen. Dette viser feilsøkingskompetanse og forståelse for hvordan servere driftes i praksis.

⸻

4. Grunnleggende serversikkerhet

Etter at serveren fungerte normalt, begynte jeg å sikre den. Dette er en viktig del av driftsstøtte, fordi en server må være stabil og beskyttet før den tas i bruk til applikasjoner.

Tiltak jeg planla og delvis gjennomførte
    •    UFW firewall
    •    Fail2Ban
    •    SSH-beskyttelse
    •    Docker som isolert kjøremiljø

Selv om jeg senere utviklet mye av applikasjonen lokalt på Mac, var dette fortsatt viktig arbeid fordi det viser at jeg forstår hvordan en produksjonsserver bør sikres.

⸻

5. Installasjon av Docker

For å klargjøre serveren for tjenester og containere installerte jeg Docker.

Kommandoer

sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker

Test av Docker

sudo docker run hello-world

Dette bekreftet at Docker var installert og fungerte korrekt.

Refleksjon

Docker gjør det enklere å kjøre tjenester isolert og kontrollert. Dette er relevant for både drift og utvikling fordi backend og overvåkingsverktøy kan kjøres separat uten å blande seg inn i resten av systemet.

⸻

6. Overvåking med Uptime Kuma

For å overvåke tjenestene satte jeg opp Uptime Kuma i Docker.

Kommando

sudo docker run -d \
  --restart=always \
  -p 3001:3001 \
  -v uptime-kuma:/app/data \
  --name uptime-kuma \
  louislam/uptime-kuma

Refleksjon

Dette viser forståelse for overvåking og drift. En god IT-løsning handler ikke bare om å starte en tjeneste, men også om å kunne se om den faktisk kjører stabilt over tid.

⸻

7. Utfordring med nettverk og ekstern tilgang

Da jeg skulle teste serveren hjemmefra, oppdaget jeg at jeg ikke kunne nå den direkte. Serveren hadde en privat IP-adresse fra skolens nettverk, og jeg befant meg utenfor dette nettverket.

Problem

Jeg forsøkte å koble til serveren og API-et med den private IP-adressen, men tilkoblingen feilet.

Årsak

Serveren sto på skolens interne nettverk. Jeg satt hjemme og var derfor ikke på samme nettverk som Proxmox-serveren. Private IP-adresser fungerer normalt ikke direkte utenfra.

Refleksjon

Dette var en viktig læringssituasjon fordi jeg måtte forstå forskjellen på lokal utvikling og drift på en ekstern server. Jeg lærte at Docker og backend kan fungere perfekt, selv om nettverkstilgangen utenfra ikke gjør det. Dette handler om å skille mellom applikasjonsfeil og infrastrukturfeil.

⸻

8. Lokal utvikling på Mac

Fordi jeg ikke alltid hadde tilgang til serveren via skolens nettverk, valgte jeg å sette opp backend lokalt på Mac-en min. Dette gjorde det mulig å fortsette utviklingen av app og API hjemme.

Opprettelse av prosjektmappe

Jeg lagde en ny mappe for backend lokalt:

mkdir -p ~/helpdeskguard-api
cd ~/helpdeskguard-api
python3 -m venv venv
source venv/bin/activate
pip install fastapi uvicorn

Dette ga meg et isolert utviklingsmiljø for Python og backend.

Refleksjon

Å bruke virtuelt miljø viser god utviklingspraksis. Det gjør prosjektet mer ryddig og forhindrer konflikter med andre Python-pakker på maskinen.

⸻

9. Første FastAPI-oppsett

Jeg laget en enkel main.py for å teste at FastAPI fungerte lokalt.

Eksempel på oppstart

python -m uvicorn main:app --host 127.0.0.1 --port 8000

Feil jeg møtte

Jeg fikk flere problemer i starten:
    •    uvicorn ble ikke funnet
    •    feil Python-versjon fra Xcode ble brukt
    •    jeg prøvde å skrive URL-er direkte i terminalen
    •    jeg fikk connection refused
    •    jeg fikk address already in use
    •    jeg fikk syntax error i main.py

Hva jeg lærte

Dette var en viktig del av brukerstøtte og feilsøking. Jeg måtte forstå forskjellen mellom:
    •    terminalkommandoer og nettadresser
    •    Mac-terminal og Ubuntu-server
    •    lokal utvikling og ekstern server
    •    Python i systemet og Python i virtuelt miljø

⸻

10. Feilsøking av backend

Jeg løste flere feil underveis.

10.1 URL skrevet som kommando

Jeg skrev en nettadresse direkte i terminalen, for eksempel:

http://127.0.0.1:8000/docs

Dette ga feil fordi terminalen prøvde å kjøre adressen som en kommando.

Løsning
Jeg lærte at URL-er må åpnes i nettleser eller med kommando som:

open http://127.0.0.1:8000/docs

10.2 connection refused

Jeg fikk ERR_CONNECTION_REFUSED i nettleseren og curl feilet.

Årsak
Backend kjørte ikke.

Løsning
Jeg måtte sørge for at uvicorn faktisk kjørte i et eget terminalvindu og lot det stå åpent.

10.3 address already in use

Jeg fikk melding om at port 8000 allerede var i bruk.

Årsak
Jeg hadde allerede startet backend en gang før.

Løsning
Jeg lærte at bare én prosess kan lytte på samme port. Dette viste meg hvordan prosesser og porter fungerer i praksis.

10.4 Syntax error i main.py

Jeg hadde limt sammen gammel og ny kode i samme fil, noe som ga ugyldig Python.

Løsning
Jeg slettet hele filen og skrev inn en ren versjon av koden på nytt.

Refleksjon

Disse feilene var verdifulle fordi de tvang meg til å forstå systemet bedre. Jeg måtte bruke logisk feilsøking i stedet for bare å gjette. Dette er en viktig del av både drift og brukerstøtte.

⸻

11. Sikkerhet i backend

For å sikre backend implementerte jeg grunnleggende autentisering.

Hva jeg laget
    •    Et login-endpoint
    •    Token-basert autentisering
    •    Beskyttede API-ruter

Hvordan det fungerte

Brukeren sender brukernavn og passord til /login. Hvis innloggingen er riktig, returnerer backend et token. Dette tokenet må deretter sendes med i Authorization-headeren som Bearer-token for å få tilgang til beskyttede ruter som /tickets.

Testing

Jeg testet med curl:
    •    uten token fikk jeg Not authenticated
    •    med token fikk jeg tilgang til ticketdata

Refleksjon

Dette er viktig fordi det viser at systemet ikke er åpent for alle. Selv om dette ikke var en full produksjonsløsning med database og utløpstid på token, ga det meg en god forståelse av autentisering og tilgangskontroll i API-utvikling.

⸻

12. Sikring av iOS-appen i Xcode

Etter at backend fungerte, måtte jeg sikre selve appen. Det viktigste her var ikke en firewall i appen, men kontroll av nettverkstrafikk og sikker håndtering av autentisering.

Problem

iOS blokkerer usikre HTTP-forbindelser som standard gjennom App Transport Security (ATS). Backend min kjørte lokalt på:

http://127.0.0.1:8000

Uten å konfigurere appen ville iOS blokkere denne forbindelsen.

Løsning

Jeg la inn følgende i Info.plist:

<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsLocalNetworking</key>
    <true/>
</dict>

Hva dette betyr

Denne innstillingen gjør at appen får lov til å kommunisere med lokal backend under utvikling, uten å åpne for all usikker trafikk.

Viktig sikkerhetsvalg

Jeg brukte ikke NSAllowsArbitraryLoads = YES, fordi dette ville åpnet for alle usikre tilkoblinger og svekket sikkerheten betydelig.

Refleksjon

Dette var en viktig del av app-sikkerheten. Jeg lærte at iOS har sikkerhet bygget inn, og at man må gi minst mulig tilgang. Det betyr at jeg åpnet kun for lokal nettverkstrafikk, ikke for all ukryptert trafikk.

⸻

13. Sikker lagring med Keychain

For å sikre autentiseringstoken på iOS-siden brukte jeg Keychain.

Hvorfor Keychain
    •    Token er sensitiv informasjon
    •    Det skal ikke lagres i vanlig tekst
    •    UserDefaults er ikke sikkert nok for autentisering

Hva jeg gjorde

Jeg laget en løsning for å:
    •    lagre token i Keychain etter login
    •    hente token når appen trenger å sende API-kall
    •    eventuelt slette token ved logout

Refleksjon

Dette er et viktig steg fordi det viser at sikkerhet ikke bare handler om backend, men også om hvordan klienten håndterer sensitiv informasjon. Ved å bruke Keychain fulgte jeg en profesjonell og trygg løsning for appen.

⸻

14. Hva jeg faktisk sikret i appen

Det jeg sikret i appen var ikke en tradisjonell firewall, men disse sikkerhetslagene:

Nettverkssikkerhet
    •    iOS ATS blokkerer usikker trafikk som standard
    •    jeg åpnet bare for lokal trafikk under utvikling

Autentisering
    •    appen bruker login mot backend
    •    bare gyldig token gir tilgang til data

Sikker lagring
    •    token lagres i Keychain

Tilgangskontroll
    •    API-et blokkerer brukere uten autentisering

Refleksjon

Dette viser at app-sikkerhet må tenkes som flere lag. Det holder ikke bare å lage en fin app – man må også kontrollere hvordan den kommuniserer, hvem som får tilgang og hvordan data beskyttes.

⸻

15. Driftsperspektiv

Dette prosjektet dekker sentrale kompetansemål innen driftsstøtte.

Eksempler på drift jeg har jobbet med
    •    opprettelse av virtuell maskin i Proxmox
    •    installasjon og oppdatering av Ubuntu Server
    •    oppsett av SSH
    •    installasjon av Docker
    •    overvåking med Uptime Kuma
    •    grunnleggende firewall og fail2ban-planlegging
    •    forståelse av nettverkssegmentering og privat IP

Hva dette viser

Jeg har vist at jeg kan planlegge, sette opp og drifte en løsning i et virtuelt miljø, samt forstå hvordan nettverk og sikkerhet påvirker drift.

⸻

16. Brukerstøtteperspektiv

Dette prosjektet dekker også kompetansemål innen brukerstøtte.

Eksempler på brukerstøtte og dokumentasjon
    •    jeg dokumenterte hvilke kommandoer som ble brukt
    •    jeg forklarte hvorfor feil oppstod
    •    jeg beskrev løsninger på vanlige problemer
    •    jeg lærte å skille mellom problem i nettverk, backend og app

Typiske feil som ble dokumentert
    •    dpkg was interrupted
    •    uvicorn not found
    •    connection refused
    •    address already in use
    •    syntax error i kode
    •    URL skrevet som kommando i terminal
    •    blokkering av HTTP i iOS

Hva dette viser

Jeg har ikke bare laget løsningen, men også dokumentert den slik at andre kan forstå og bruke den. Dette er sentralt i brukerstøtte.

⸻

17. Utviklingsperspektiv

Prosjektet viser også kompetanse innen utvikling.

Det jeg utviklet
    •    backend med FastAPI
    •    login-endpoint
    •    tokenbasert autentisering
    •    beskyttede API-ruter
    •    iOS-app i SwiftUI
    •    Keychain-basert tokenlagring
    •    kobling mellom app og backend

Hva dette viser

Jeg har brukt relevante språk og verktøy til å bygge en fungerende IT-løsning med innebygd sikkerhet. Jeg har også testet løsningen og forbedret den underveis.

⸻

18. Oppsummering av feil jeg møtte og hva jeg lærte

Gjennom prosjektet møtte jeg flere feil. Disse var en viktig del av læringsprosessen.

Feil: avbrutt pakkesystem

Jeg lærte å reparere Linux-systemet uten reinstallasjon.

Feil: ingen kontakt med skole-server hjemmefra

Jeg lærte forskjellen på privat IP og tilgjengelighet over nettverk.

Feil: URL skrevet som kommando

Jeg lærte forskjellen på terminal og nettleser.

Feil: backend startet ikke

Jeg lærte å tolke feilmeldinger og sjekke prosesser, porter og syntax.

Feil: iOS blokkerte backend

Jeg lærte hvordan ATS fungerer og hvordan man gir minst mulig tilgang.

Feil: token måtte lagres sikkert

Jeg lærte at sensitiv informasjon i iOS må håndteres med Keychain.

Refleksjon

Feilene gjorde at jeg fikk bedre forståelse for både drift, utvikling og brukerstøtte. I stedet for å bare følge en oppskrift, måtte jeg forstå hvorfor ting ikke fungerte og hvordan de kunne løses på en trygg måte.

⸻

19. Konklusjon

Gjennom prosjektet har jeg bygget opp en løsning fra infrastruktur til applikasjon. Jeg startet med å opprette en virtuell maskin i Proxmox, installerte og reparerte Ubuntu Server, satte opp Docker og overvåking, utviklet backend i FastAPI og sikret iOS-appen gjennom nettverkssikkerhet og Keychain.

Det viktigste jeg har lært er at sikkerhet må bygges inn i hele løsningen:
    •    infrastrukturen må være kontrollert
    •    serveren må driftes sikkert
    •    backend må kreve autentisering
    •    appen må håndtere nettverk og data sikkert
    •    feil må dokumenteres og forstås

Dette prosjektet viser derfor både praktisk og teoretisk kompetanse innen driftsstøtte, utvikling og brukerstøtte.

⸻

20. Videre arbeid

Hvis løsningen skulle videreutvikles, ville neste steg vært:
    •    bruke HTTPS i stedet for lokal HTTP
    •    innføre JWT med utløpstid
    •    lagre brukere i database
    •    fullføre og dokumentere UFW og Fail2ban på serveren
    •    legge til logging og mer avansert overvåking
    •    utvide appen med mer robust brukerhåndtering

⸻




