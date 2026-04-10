# Refleksjon – HelpdeskGuard

## Hva fungerte bra
Jeg fikk god struktur i prosjektet ved a dele opp ansvar i egne filer (for eksempel AuthStore, TicketStore og ulike Views). Det gjorde det enklere a forsta og videreutvikle appen.

Git fungerte bra for a dokumentere utviklingen steg for steg. Jeg fikk ogsa bedre oversikt over hva som faktisk var ferdig, og hva som bare var planlagt.

## Hva var vanskelig, og hvorfor
Innlogging og lagring var vanskelig fordi flere valg paavirket hverandre: hvor data lagres, hvordan data valideres, og hvordan UI skal oppdatere seg riktig.

Merge-konflikter i Git var utfordrende fordi samme filer ble endret i flere commits. Det ga meg erfaring med a lese konflikter, velge riktig innhold og fullfore rebase/merge korrekt.

Det var ogsa krevende a holde balansen mellom enkel prototype og god sikkerhet. En enkel losning ga rask fremdrift, men gjorde at sikkerheten ble svakere enn den burde vaere.

## Teknologivalg jeg kunne gjort annerledes
Jeg brukte UserDefaults for a komme raskt i gang. I ettertid ser jeg at Keychain burde vaert brukt tidligere for sensitive data.

Jeg kunne ogsa planlagt backend tidligere i prosjektet. Det ville gjort overgangen fra lokal prototype til mer realistisk drift enklere.

## Hva jeg har laert
- Hvordan SwiftUI brukes til a bygge tydelig og funksjonelt UI.
- Hvordan Git brukes i praksis, spesielt ved konflikter.
- Hvorfor dokumentasjon er viktig for a vise sammenheng mellom plan, valg og resultat.
- At sikkerhet maa planlegges tidlig, ikke legges pa til slutt.

## Videre utvikling
- Lage visning av registrerte saker i appen.
- Flytte sensitiv lagring til tryggere metode.
- Koble appen til backend for mer realistisk dataflyt.
- Fortsette med tydelig dokumentasjon etter hver arbeidsokt.
