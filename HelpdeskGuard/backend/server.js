require("dotenv").config();

const express = require("express");
const mysql = require("mysql2");
const bcrypt = require("bcrypt");

const app = express();
app.use(express.json());

const db = mysql.createConnection({
  host: process.env.DB_HOST || "127.0.0.1",
  user: process.env.DB_USER || "fahad",
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME || "helpdeskguard",
});

db.connect((feil) => {
  if (feil) {
    console.error("Klarte ikke å koble til MySQL:", feil.message);
    process.exit(1);
  }
  console.log("Koblet til MySQL-databasen!");
});

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

app.post("/saker", (req, res) => {
  const { bruker_id, tittel, beskrivelse, kategori, prioritet } = req.body;

  if (!bruker_id || !tittel || !beskrivelse) {
    return res.status(400).json({ melding: "bruker_id, tittel og beskrivelse er påkrevd" });
  }

  const sql = "INSERT INTO saker (bruker_id, tittel, beskrivelse, kategori, prioritet) VALUES (?, ?, ?, ?, ?)";
  const verdier = [bruker_id, tittel, beskrivelse, kategori || "Annet", prioritet || "Normal"];

  db.query(sql, verdier, (feil, resultat) => {
    if (feil) {
      return res.status(500).json({ melding: "Kunne ikke opprette sak" });
    }
    res.status(201).json({ melding: "Sak opprettet", sak_id: resultat.insertId });
  });
});

app.get("/saker/:bruker_id", (req, res) => {
  const bruker_id = req.params.bruker_id;

  const sql = "SELECT * FROM saker WHERE bruker_id = ? ORDER BY opprettet DESC";
  db.query(sql, [bruker_id], (feil, rader) => {
    if (feil) {
      return res.status(500).json({ melding: "Kunne ikke hente saker" });
    }
    res.json(rader);
  });
});

app.patch("/saker/:sak_id/lost", (req, res) => {
  const sak_id = req.params.sak_id;

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

app.delete("/brukere/:bruker_id", (req, res) => {
  const bruker_id = req.params.bruker_id;

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

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`HelpdeskGuard API kjører på http://localhost:${PORT}`);
});
