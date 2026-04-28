# Hvordan jeg koblet Xcode, serveren og MySQL sammen i HelpdeskGuard

Jeg bygget HelpdeskGuard som et komplett klient/server-system. Det betyr at appen min i Xcode ikke kobler seg direkte til databasen, men kommuniserer med backend-serveren min, som igjen snakker med MySQL.

Systemet mitt fungerer slik:

text Xcode / SwiftUI App ↓ Node.js / Express backend på Ubuntu-server ↓ MySQL database (helpdeskguard) 

Dette er en profesjonell og sikker måte å bygge systemet på.

---

# Flytting av filer fra lokal PC til server

Jeg startet med å utvikle prosjektet lokalt på Mac-en min i Xcode. Etterpå flyttet jeg backend-filene mine over til Ubuntu-serveren.

Jeg brukte kommando for filoverføring over nettverk:

bash scp -r backend fahad@172.20.128.20:~ 

Dette kopierte backend-mappen min fra Mac-en til serveren.

Dette viser at jeg kan bruke nettverk, terminal og serveradministrasjon i praksis.

---

# Innlogging på server

Etter at filene var flyttet opp, logget jeg inn på serveren med SSH:

bash ssh fahad@172.20.128.20 

Dette lot meg administrere serveren eksternt fra Mac-en min.

---

# Starte backend-serveren

Når jeg var inne på serveren, gikk jeg inn i backend-mappen og startet Node.js-serveren:

bash cd ~/backend node server.js 

Da startet API-et mitt på port 3000.

Dette var nødvendig for at Xcode-appen skulle kunne hente data.

---

# Koble backend til MySQL

I backend-koden min (server.js) koblet jeg Node.js til MySQL-databasen min.

Jeg brukte:

js const mysql = require("mysql2"); 

og koblet til databasen:

js const db = mysql.createConnection({   host: "127.0.0.1",   user: "fahad",   password: "...",   database: "helpdeskguard" }); 

Det betyr at backend-serveren min koblet seg direkte til MySQL på Ubuntu-serveren.

---

# Lage API som henter data

Jeg laget egne API-ruter, blant annet:

js app.get("/saker") 

Når denne brukes, kjører backend SQL-spørringen:

sql SELECT * FROM saker; 

Resultatet sendes tilbake som JSON.

---

# Koble Xcode til serveren

I SwiftUI-appen min brukte jeg serveradressen:

text http://172.20.128.20:3000/saker 

Det betyr at appen min i Xcode sender request til serveren min og får data tilbake.

Hele flyten er:

text SwiftUI App ↓ GET /saker ↓ Backend på Ubuntu ↓ MySQL database ↓ JSON tilbake til appen 

---

# Testing jeg gjorde

Jeg testet backend både lokalt på serveren og fra Mac-en min.

På serveren:

bash curl http://localhost:3000/health curl http://localhost:3000/saker 

Fra Mac-en:

bash curl http://172.20.128.20:3000/health curl http://172.20.128.20:3000/saker 

Når dette fungerte, visste jeg at Xcode også kunne koble seg til serveren.

---

# Problemer jeg møtte og løste

## 1. /saker fungerte ikke

Jeg fikk feilmeldingen:

text Cannot GET /saker 

Det viste seg at route manglet eller gammel server fortsatt kjørte.

Jeg løste det ved å legge inn /saker riktig og restarte Node:

bash pkill node node server.js 

---

## 2. Jeg brukte localhost feil

Jeg prøvde først:

text localhost:3000 

på Mac-en min.

Det fungerte ikke fordi localhost på Mac betyr min egen maskin, ikke serveren.

Jeg byttet derfor til:

text 172.20.128.20:3000 

---

## 3. Dobbelt app.listen()

Jeg hadde skrevet app.listen(3000) to ganger i server.js.

Dette skapte feil ved oppstart.

Jeg ryddet koden og beholdt bare én.

---

## 4. Xcode-problemer

Jeg møtte også problemer med:

- layout/full screen
- Info.plist
- duplikate filer
- compile errors

Jeg løste dette ved å rydde prosjektet og bruke Git commits for å gå tilbake når noe ble feil.

---

# Hva dette viser

Gjennom dette arbeidet viser jeg at jeg kan:

- utvikle app i Xcode
- bruke SwiftUI
- sette opp backend
- koble backend til MySQL
- bruke Linux-server
- bruke SSH
- bruke API
- bruke nettverk
- feilsøke tekniske problemer
- jobbe profesjonelt med klient/server-løsninger

---

# Kort forklaring til lærer

Jeg utviklet HelpdeskGuard som et komplett system. Appen min i Xcode kobler seg til min Ubuntu-server via API. Backend-serveren er skrevet i Node.js og koblet til MySQL. Jeg flyttet filer fra lokal PC til server, satte opp databasen, testet nettverk og løste tekniske feil underveis. Dette viser både utvikling, drift og systemforståelse.
