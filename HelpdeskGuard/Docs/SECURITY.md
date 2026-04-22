# SECURITY – HelpdeskGuard (v1.0)

## Formaal
Dette dokumentet beskriver sikkerhetsnivaet i dagens prototype og hva som er avgrenset til senere faser.

## Hva som er sant i v1.0
- Appen er en prototype med enkel lokal lagring.
- Sikkerhetsnivaaet er ikke produksjonsklart.
- Dokumenterte driftstiltak (UFW, SSH-herding, Fail2Ban, overvaking) er knyttet til driftmiljo.

## Risiko i dagens losning
- Sensitiv informasjon trenger sterkere beskyttelse.
- Lokal lagring uten robust backup gir risiko for datatap.
- Appens funksjonsflyt er enklere enn et fullverdig produksjonssystem.

## Tiltak videre
- Heve sikkerhetsniva i appens datahaandtering.
- Innfore tydeligere tilgangskontroll i neste fase.
- Beholde prinsippet om minst mulig tilgang i driftmiljo.

## Viktig avgrensning
Dette prosjektet vurderes som skoleprototype (v1.0). Dokumentasjonen skal vaere etterprovbar mot faktisk funksjonalitet, og skal ikke beskrive ferdige sikkerhetsfunksjoner som ikke er implementert i appen.
