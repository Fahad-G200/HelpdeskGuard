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

| Metode | URL                        | Beskrivelse                          |
|--------|----------------------------|--------------------------------------|
| POST   | `/registrer`               | Oppretter ny bruker                  |
| POST   | `/logginn`                 | Logger inn bruker                    |
| POST   | `/saker`                   | Oppretter ny helpdesk-sak            |
| GET    | `/saker/:bruker_id`        | Henter alle saker for en bruker      |
| PATCH  | `/saker/:sak_id/lost`      | Markerer en sak som løst             |
| DELETE | `/brukere/:bruker_id`      | Sletter bruker og tilhørende saker   |

---

## Eksempel med curl

```bash
# Registrer bruker
curl -X POST http://localhost:3000/registrer \
  -H "Content-Type: application/json" \
  -d '{"epost":"test@test.no","passord":"Passord123"}'

# Logg inn
curl -X POST http://localhost:3000/logginn \
  -H "Content-Type: application/json" \
  -d '{"epost":"test@test.no","passord":"Passord123"}'

# Opprett sak (erstatt 1 med bruker_id fra innlogging)
curl -X POST http://localhost:3000/saker \
  -H "Content-Type: application/json" \
  -d '{"bruker_id":1,"tittel":"PC virker ikke","beskrivelse":"Skjermen er svart","kategori":"Hardware","prioritet":"Høy"}'

# Hent saker
curl http://localhost:3000/saker/1

# Marker sak som løst
curl -X PATCH http://localhost:3000/saker/1/lost

# Slett bruker
curl -X DELETE http://localhost:3000/brukere/1
```

---

## Sikkerhet

- Passord lagres **aldri** i klartekst – de hashes med bcrypt (10 runder).
- Databaseopplysninger lagres i `.env` som **ikke** committes til Git.
- Fremmednøkkel med `ON DELETE CASCADE` sikrer at saker slettes når brukeren slettes.
