--
//  schema.sql
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 22/04/2026.
//

CREATE DATABASE helpdeskguard;
USE helpdeskguard;

CREATE TABLE brukere (
    id INT AUTO_INCREMENT PRIMARY KEY,
    epost VARCHAR(255) UNIQUE NOT NULL,
    passord_hash VARCHAR(255) NOT NULL,
    opprettet TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE saker (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bruker_id INT NOT NULL,
    tittel VARCHAR(255) NOT NULL,
    beskrivelse TEXT NOT NULL,
    kategori VARCHAR(100),
    prioritet VARCHAR(50),
    er_lost BOOLEAN DEFAULT FALSE,
    opprettet TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bruker_id) REFERENCES brukere(id)
);

