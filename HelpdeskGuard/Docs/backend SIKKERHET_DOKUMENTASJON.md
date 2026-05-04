cat > ~/backend/SIKKERHET_DOKUMENTASJON.md <<EOF
# SIKKERHETSDOKUMENTASJON – HELPDESKGUARD

Dato: (4 mai 2026)  
Server: 172.20.128.20  
Student: Fahad  

---

## 1. Sikkerhet

- Firewall (UFW) er aktiv
- Kun nødvendige porter er åpne (22, 80, 443)
- SSH er sikret med rate limiting
- Nginx brukes som reverse proxy
- Backend og database kjører lokalt

---

## 2. Systemstatus

Backend status:
$(curl -s http://127.0.0.1:3000/health)

Nginx test:
$(curl -s http://172.20.128.20/health)

Åpne porter:
$(sudo ss -tulnp | grep -E "22|80|3000|3306")

---

## 3. Arkitektur

App → Nginx → Backend → MySQL

---

## 4. Testing

- Testet med curl
- Sjekket porter med ss
- Verifisert firewall med ufw

---

## 5. Hva jeg har gjort

- Satt opp firewall
- Satt opp Nginx reverse proxy
- Kjørt backend lokalt
- Testet at alt fungerer
- Feilsøkt problemer

---

## 6. Forbedringer

- HTTPS (SSL)
- Lukke port 3000 helt eksternt
- Bedre logging og backup

---

## 7. Kort forklaring

Jeg har satt opp en sikker backend med firewall og Nginx.
Backend og database kjører lokalt, og all trafikk går gjennom Nginx.
Systemet er testet og fungerer.
EOF


