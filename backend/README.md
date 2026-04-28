# HelpdeskGuard – Backend

Enkel REST API-server skrevet i Node.js med Express og MySQL.

---

## Krav

- [Node.js](https://nodejs.org/) (v18 eller nyere)
- [MySQL](https://dev.mysql.com/downloads/) (v8 eller nyere)

---

## Oppsett (første gang)

### 1. Opprett databasen

```bash
mysql -u root -p < schema.sql
```

### 2. Opprett .env-fil

```bash
cp .env.example .env
```

Åpne `.env` og fyll inn dine MySQL-opplysninger:

```
DB_HOST=127.0.0.1
DB_USER=ditt_brukernavn
DB_PASSWORD=ditt_passord
DB_NAME=helpdeskguard
PORT=3000
JWT_SECRET=bytt_meg_til_en_lang_tilfeldig_streng
```

### 3. Installer avhengigheter

```bash
npm install
```

### 4. Start serveren

```bash
npm start
```

Serveren kjører nå på `http://localhost:3000`.

---

## API-endepunkter

| Metode | URL                     | Auth         | Beskrivelse                        |
|--------|-------------------------|--------------|------------------------------------|
| GET    | `/health`               | –            | Sjekker server og databasestatus   |
| POST   | `/registrer`            | –            | Oppretter ny bruker                |
| POST   | `/logginn`              | –            | Logger inn, returnerer JWT-token   |
| GET    | `/saker`                | Bearer-token | Henter alle saker for brukeren     |
| POST   | `/saker`                | Bearer-token | Oppretter ny helpdesk-sak          |
| PATCH  | `/saker/:id/lost`       | Bearer-token | Markerer en sak som løst           |
| DELETE | `/brukere/meg`          | Bearer-token | Sletter innlogget bruker og saker  |

---

## Eksempel med curl

```bash
# Sjekk at serveren kjører (skal gi: {"status":"ok","database":"tilkoblet"})
curl http://localhost:3000/health

# Registrer bruker
curl -X POST http://localhost:3000/registrer \
  -H "Content-Type: application/json" \
  -d '{"epost":"test@test.no","passord":"Passord123"}'

# Logg inn og lagre token i en variabel
TOKEN=$(curl -s -X POST http://localhost:3000/logginn \
  -H "Content-Type: application/json" \
  -d '{"epost":"test@test.no","passord":"Passord123"}' \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['token'])")

# Opprett ny sak (krever token)
curl -X POST http://localhost:3000/saker \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"tittel":"PC virker ikke","beskrivelse":"Skjermen er svart","kategori":"Maskinvare","prioritet":"Høy"}'

# Hent alle saker for innlogget bruker (krever token)
curl -H "Authorization: Bearer $TOKEN" http://localhost:3000/saker

# Marker sak som løst (erstatt 1 med faktisk sak-ID)
curl -X PATCH http://localhost:3000/saker/1/lost \
  -H "Authorization: Bearer $TOKEN"

# Slett innlogget bruker og alle dens saker (krever token)
curl -X DELETE http://localhost:3000/brukere/meg \
  -H "Authorization: Bearer $TOKEN"
```

---

## Sikkerhet

- Passord lagres **aldri** i klartekst – de hashes med bcrypt (10 runder).
- Databaseopplysninger lagres i `.env` som **ikke** committes til Git.
- JWT-token brukes for å beskytte endepunkter som krever innlogging.
- Rate limiting begrenser antall forsøk (20 for auth, 100 for API per 15 min).
- Fremmednøkkel med `ON DELETE CASCADE` sikrer at saker slettes når brukeren slettes.
