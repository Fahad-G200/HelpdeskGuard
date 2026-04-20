# Refleksjon – HelpdeskGuard

## Hva fungerte bra
Prosjektet fungerte best nar jeg delte arbeidet i mindre deler: autentisering, UI, dokumentasjon og drift. Dette gjorde det lettere a holde oversikt og levere en fungerende v1.0.

Jeg fikk god nytte av Git/GitHub for a dokumentere fremdrift og endringer over tid.

## Hva var vanskelig
Det vanskeligste var a balansere rask fremdrift med god sikkerhet. Enkle valg ga fart i utviklingen, men gjorde at sikkerhetsnivaet ble svakere enn onsket.

Jeg opplevde ogsa utfordringer med merge/rebase-konflikter og med a holde dokumentasjon helt synkron med faktisk funksjonalitet.

## Hvorfor det var vanskelig
Flere deler paavirket hverandre samtidig: lagring, validering og brukerflyt. Nar en del ble endret, matte dokumentasjon og andre filer oppdateres med en gang for a unnga motsetninger.

## Hva jeg laerte
- Strukturert arbeid i SwiftUI med tydelig ansvar per fil.
- Praktisk bruk av Git, inkludert konflikthandtering.
- At dokumentasjon er like viktig som kode i tverrfaglig vurdering.
- At sikkerhet bor planlegges tidlig, ikke bare pa slutten.

## Hva jeg ville gjort annerledes
- Definert avgrensning og sikkerhetsniva enda tydeligere helt i starten.
- Laget en enkel sporbar testlogg tidligere i perioden.
- Oppdatert dokumentasjon fortlopende etter hver arbeidsokt.

## Videre utvikling
- Koble TicketStore tydeligere til UI-flyten.
- Lage visning av registrerte saker i appen.
- Videreutvikle sikkerhetsniva i losningen.
