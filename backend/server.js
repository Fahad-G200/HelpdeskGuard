// HelpdeskGuard – Backend API
// Node.js + Express + MySQL
// Start: node server.js  (etter at du har satt opp .env og kjørt schema.sql)

require("dotenv").config();
const express = require("express");
const mysql = require("mysql2");
const bcrypt = require("bcrypt");

const app = express();
app.use(express.json());

// -------------------------------------------------------------------
// Databasetilkobling – verdiene leses fra .env-filen
// -------------------------------------------------------------------
const db = mysql.createConnection({
  host:     process.env.DB_HOST     || "127.0.0.1",
  user:     process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME     || "helpdeskguard",
});

db.connect((feil) => {
  if (feil) {
    console.error("Klarte ikke å koble til MySQL:", feil.message);
    process.exit(1);
  }
  console.log("Koblet til MySQL-databasen!");
});

// -------------------------------------------------------------------
// POST /registrer  – oppretter ny bruker
// Body: { epost, passord }
// -------------------------------------------------------------------
app.post("/registrer", async (req, res) => {
  const { epost, passord } = req.body;

  if (!epost || !passord) {
    return res.status(400).json({ melding: "Epost og passord er påkrevd" });
  }

  const passordHash = await bcrypt.hash(passord, 10);

  const sql = "INSERT INTO brukere (epost, passord_hash) VALUES (?, ?)";
  db.query(sql, [epost.toLowerCase(), passordHash], (feil, resultat) => {
    if (feil) {
      if (feil.errno === 1062) {
        return res.status(409).json({ melding: "E-postadressen er allerede registrert" });
      }
      return res.status(500).json({ melding: "Noe gikk galt på serveren" });
    }
    res.status(201).json({ melding: "Bruker opprettet", bruker_id: resultat.insertId });
  });
});

// -------------------------------------------------------------------
// POST /logginn  – logger inn en bruker
// Body: { epost, passord }
// -------------------------------------------------------------------
app.post("/logginn", (req, res) => {
  const { epost, passord } = req.body;

  if (!epost || !passord) {
    return res.status(400).json({ melding: "Epost og passord er påkrevd" });
  }

  const sql = "SELECT * FROM brukere WHERE epost = ?";
  db.query(sql, [epost.toLowerCase()], async (feil, rader) => {
    if (feil) {
      return res.status(500).json({ melding: "Noe gikk galt på serveren" });
    }

    if (rader.length === 0) {
      return res.status(401).json({ melding: "Feil e-post eller passord" });
    }

    const bruker = rader[0];
    const passordStemmer = await bcrypt.compare(passord, bruker.passord_hash);

    if (!passordStemmer) {
      return res.status(401).json({ melding: "Feil e-post eller passord" });
    }

    res.json({ melding: "Innlogging vellykket", bruker_id: bruker.id, epost: bruker.epost });
  });
});

// -------------------------------------------------------------------
// POST /saker  – oppretter en ny helpdesk-sak
// Body: { bruker_id, tittel, beskrivelse, kategori, prioritet }
// -------------------------------------------------------------------
app.post("/saker", (req, res) => {
  const { bruker_id, tittel, beskrivelse, kategori, prioritet } = req.body;

  if (!bruker_id || !tittel || !beskrivelse) {
    return res.status(400).json({ melding: "bruker_id, tittel og beskrivelse er påkrevd" });
  }

  const sql =
    "INSERT INTO saker (bruker_id, tittel, beskrivelse, kategori, prioritet) VALUES (?, ?, ?, ?, ?)";
  const verdier = [bruker_id, tittel, beskrivelse, kategori || "Annet", prioritet || "Normal"];

  db.query(sql, verdier, (feil, resultat) => {
    if (feil) {
      return res.status(500).json({ melding: "Kunne ikke opprette sak" });
    }
    res.status(201).json({ melding: "Sak opprettet", sak_id: resultat.insertId });
  });
});

// -------------------------------------------------------------------
// GET /saker/:bruker_id  – henter alle saker for en bruker
// -------------------------------------------------------------------
app.get("/saker/:bruker_id", (req, res) => {
  const { bruker_id } = req.params;

  const sql = "SELECT * FROM saker WHERE bruker_id = ? ORDER BY opprettet DESC";
  db.query(sql, [bruker_id], (feil, rader) => {
    if (feil) {
      return res.status(500).json({ melding: "Kunne ikke hente saker" });
    }
    res.json(rader);
  });
});

// -------------------------------------------------------------------
// PATCH /saker/:sak_id/lost  – markerer en sak som løst
// -------------------------------------------------------------------
app.patch("/saker/:sak_id/lost", (req, res) => {
  const { sak_id } = req.params;

  const sql = "UPDATE saker SET er_lost = TRUE WHERE id = ?";
  db.query(sql, [sak_id], (feil, resultat) => {
    if (feil) {
      return res.status(500).json({ melding: "Kunne ikke oppdatere sak" });
    }
    if (resultat.affectedRows === 0) {
      return res.status(404).json({ melding: "Saken ble ikke funnet" });
    }
    res.json({ melding: "Sak markert som løst" });
  });
});

// -------------------------------------------------------------------
// DELETE /brukere/:bruker_id  – sletter en bruker (og dens saker via CASCADE)
// -------------------------------------------------------------------
app.delete("/brukere/:bruker_id", (req, res) => {
  const { bruker_id } = req.params;

  const sql = "DELETE FROM brukere WHERE id = ?";
  db.query(sql, [bruker_id], (feil, resultat) => {
    if (feil) {
      return res.status(500).json({ melding: "Kunne ikke slette bruker" });
    }
    if (resultat.affectedRows === 0) {
      return res.status(404).json({ melding: "Brukeren ble ikke funnet" });
    }
    res.json({ melding: "Bruker slettet" });
  });
});

// -------------------------------------------------------------------
// Start serveren
// -------------------------------------------------------------------
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`HelpdeskGuard API kjører på http://localhost:${PORT}`);
});
