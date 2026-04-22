-- HelpdeskGuard – databaseskjema
-- Kjør dette én gang for å sette opp databasen:
--   mysql -u root -p < schema.sql

CREATE DATABASE IF NOT EXISTS helpdeskguard
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE helpdeskguard;

-- Tabell for brukere
CREATE TABLE IF NOT EXISTS brukere (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  epost         VARCHAR(255) NOT NULL UNIQUE,
  passord_hash  VARCHAR(255) NOT NULL,
  opprettet     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabell for saker (helpdesk-tickets)
CREATE TABLE IF NOT EXISTS saker (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  bruker_id   INT NOT NULL,
  tittel      VARCHAR(255) NOT NULL,
  beskrivelse TEXT NOT NULL,
  kategori    VARCHAR(100) DEFAULT 'Annet',
  prioritet   VARCHAR(50)  DEFAULT 'Normal',
  er_lost     BOOLEAN      DEFAULT FALSE,
  opprettet   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_saker_bruker
    FOREIGN KEY (bruker_id) REFERENCES brukere(id)
    ON DELETE CASCADE
);
