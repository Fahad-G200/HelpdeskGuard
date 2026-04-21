# Server Hardening – HelpdeskGuard

## Mal
Redusere angrepsflate i driftmiljoet som brukes i prosjektet.

## Tiltak som er gjennomfort
1. UFW firewall
- Innkommende trafikk blokkeres som standard
- Kun nodvendige porter tillates (OpenSSH)

2. SSH-herding
- Root-login via SSH deaktivert
- Konfigurasjon validert etter endring

3. Fail2Ban
- Beskytter SSH mot gjentatte feilede innloggingsforsok
- Aktiv overvaking av sshd-jail

## Kontrollpunkter
Eksempler pa verifisering:
```bash
sudo ufw status verbose
sudo systemctl status ssh
sudo fail2ban-client status
sudo fail2ban-client status sshd
```

## Avgrensning
Dette dokumentet beskriver driftmiljo og sikkerhetstiltak rundt server.
Det betyr ikke at alle sikkerhetstiltak er implementert i selve iOS-appen i v1.0.

## Neste steg
- Strammere tilgangsstyring i videre driftfase
- Bedre dokumentasjon av rutiner for hendelseshaandtering
