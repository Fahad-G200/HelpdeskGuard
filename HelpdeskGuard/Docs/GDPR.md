# GDPR og personvern – HelpdeskGuard

## Hva er GDPR?

GDPR (General Data Protection Regulation) er EUs personvernforordning som gjelder i Norge via EØS-avtalen. Den regulerer hvordan virksomheter samler inn, lagrer og behandler personopplysninger.

Relevant norsk lov: **Personopplysningsloven (2018)**, som implementerer GDPR i norsk rett.

---

## Hvilke personopplysninger behandler HelpdeskGuard?

| Opplysning | Kategori | Formål |
|-----------|---------|--------|
| E-postadresse | Identifikasjonsopplysning | Innlogging og kontakt |
| Passord (hashed) | Sikkerhetsopplysning | Autentisering |
| Helpdesk-saker (tittel, beskrivelse) | Innholdsopplysning | Problemhåndtering |
| Tidsstempel (opprettet) | Metadata | Sporing av aktivitet |

---

## Lovgrunnlag (GDPR artikkel 6)

Behandlingen av personopplysninger i HelpdeskGuard er basert på:
- **Artikkel 6(1)(b)**: Behandlingen er nødvendig for å oppfylle en avtale brukeren er part i (bruk av helpdesk-tjenesten).

---

## Brukerrettigheter (GDPR artikkel 15–22)

Brukere av HelpdeskGuard har følgende rettigheter:

| Rettighet | Beskrivelse | Implementert |
|-----------|-------------|-------------|
| Innsyn (art. 15) | Se hvilke data som er lagret | Vises i appen under "Konto" og "Saker" |
| Sletting (art. 17) | "Retten til å bli glemt" | `DELETE /brukere/meg` sletter bruker + alle saker (CASCADE) |
| Dataportabilitet (art. 20) | Få data i maskinlesbart format | Planlagt i fremtidig versjon |
| Retting (art. 16) | Rette feil opplysninger | Planlagt i fremtidig versjon |

---

## Datasikkerhet (GDPR artikkel 32)

Tiltak implementert for å beskytte personopplysninger:

1. **bcrypt** – passord hashes med kostfaktor 10, aldri lagret i klartekst.
2. **JWT-token** – brukes i stedet for å sende passord med hver forespørsel.
3. **MySQL kun internt** – databasen er ikke eksponert mot internett.
4. **Rate limiting** – hindrer automatiserte angrep mot innloggings-API.
5. **`.env`-fil** – hemmeligheter lagres ikke i kildekode.
6. **UFW + Fail2Ban** – serverherding mot uautorisert tilgang.

---

## Databehandleravtale

I et produksjonsmiljø vil det kreves en **databehandleravtale (DPA)** hvis tredjeparts tjenester (f.eks. skytjenester) benyttes. I dette prosjektet driftes alt lokalt – ingen tredjepart behandler dataene.

---

## Datalagring og sletting

- Personopplysninger lagres kun så lenge det er nødvendig.
- Brukeren kan selv slette kontoen og alle tilknyttede saker.
- Det finnes ingen automatisk slettefrist i v1.1 – dette er planlagt til neste fase.

---

## Avgrensning

Dette prosjektet er en skoleprototype (VG2 IT). GDPR-dokumentasjonen beskriver prinsippene og de implementerte tiltakene, men løsningen er ikke ferdigstilt for kommersiell produksjonsbruk.
