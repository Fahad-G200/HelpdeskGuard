# SECURITY – HelpdeskGuard (v1.1)

## Formål
Dette dokumentet beskriver sikkerhetsnivået i systemet, inkludert backend med JWT-autentisering.

## Autentisering og autorisasjon
- Brukere registrerer seg med e-post og passord.
- Passord hashes med **bcrypt** (kostfaktor 10) – aldri lagret i klartekst.
- Ved innlogging returnerer backend et **JWT-token** (utløper etter 7 dager).
- Alle saker-endepunkter krever gyldig JWT i `Authorization: Bearer`-header.
- Appen lagrer token i `UserDefaults` og sender det med hver forespørsel.

## Rate limiting
- Autentiseringsendepunkter: maks **20 forespørsler per 15 min** per IP.
- API-endepunkter: maks **100 forespørsler per 15 min** per IP.

## Nettverkssikkerhet
- MySQL lytter kun på `127.0.0.1` – ikke eksponert mot internett.
- UFW brannmur blokkerer alle innkommende porter unntatt 22 (SSH) og 3000 (API).
- Fail2Ban beskytter mot SSH brute-force-angrep.

## Miljøvariabler
- Database-passord og JWT-hemmelighet lagres i `.env`-fil.
- `.env`-filen er i `.gitignore` og committes aldri til Git.

## Personvern (GDPR)
- Brukere kan slette kontoen sin via `DELETE /brukere/meg`.
- Sletting er CASCADE – alle saker tilknyttet brukeren slettes også.
- Se `GDPR.md` for fullstendig personvern-dokumentasjon.

## Risiko og begrensninger
- Løsningen er en skoleprototype – ikke produksjonsklar uten ytterligere sikkerhetstiltak.
- HTTP i stedet for HTTPS i lokalt utviklingsmiljø – HTTPS bør brukes i produksjon.
- Token lagres i `UserDefaults` – Keychain anbefales i en produksjonsapp.
- Passordstyrke valideres ikke på server-siden i v1.1 – bør legges til i neste fase.
