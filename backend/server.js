// HelpdeskGuard – Backend API
// Node.js + Express + MySQL + JWT
// Start: node server.js  (etter at du har satt opp .env og kjørt schema.sql)

require("dotenv").config();
const express   = require("express");
const mysql     = require("mysql2");
const bcrypt    = require("bcrypt");
const jwt       = require("jsonwebtoken");
const rateLimit = require("express-rate-limit");

const app = express();
app.use(express.json());

// -------------------------------------------------------------------
// Status-konstanter
// -------------------------------------------------------------------
const STATUS_APEN  = "Åpen";
const STATUS_LOST  = "Løst";

// -------------------------------------------------------------------
// Rate limiting
// -------------------------------------------------------------------
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 20,
  message: { melding: "For mange forespørsler, prøv igjen om litt" },
});

const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
  message: { melding: "For mange forespørsler, prøv igjen om litt" },
});

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
// JWT-middleware – beskytter ruter som krever innlogging
// -------------------------------------------------------------------
function kreverInnlogging(req, res, next) {
  const autorisasjon = req.headers["authorization"];
  if (!autorisasjon || !autorisasjon.startsWith("Bearer ")) {
    return res.status(401).json({ melding: "Mangler eller ugyldig token" });
  }
  const token = autorisasjon.slice(7);
  try {
    req.bruker = jwt.verify(token, process.env.JWT_SECRET);
    next();
  } catch (err) {
    return res.status(401).json({ melding: "Token er ugyldig eller utløpt" });
  }
}

// -------------------------------------------------------------------
// GET /health  – sjekker at serveren kjører
// -------------------------------------------------------------------
app.get("/health", (_req, res) => {
  res.json({ status: "ok" });
});

// -------------------------------------------------------------------
// POST /registrer  – oppretter ny bruker
// Body: { epost, passord }
// -------------------------------------------------------------------
app.post("/registrer", authLimiter, async (req, res) => {
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
// POST /logginn  – logger inn og returnerer JWT-token
// Body: { epost, passord }
// -------------------------------------------------------------------
app.post("/logginn", authLimiter, (req, res) => {
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

    const token = jwt.sign(
      { bruker_id: bruker.id, epost: bruker.epost },
      process.env.JWT_SECRET,
      { expiresIn: "7d" }
    );

    res.json({ melding: "Innlogging vellykket", token });
  });
});

// -------------------------------------------------------------------
// GET /saker  – henter alle saker for innlogget bruker (JWT)
// -------------------------------------------------------------------
app.get("/saker", apiLimiter, kreverInnlogging, (req, res) => {
  const sql = "SELECT * FROM saker WHERE bruker_id = ? ORDER BY opprettet DESC";
  db.query(sql, [req.bruker.bruker_id], (feil, rader) => {
    if (feil) {
      return res.status(500).json({ melding: "Kunne ikke hente saker" });
    }
    res.json(rader);
  });
});

// -------------------------------------------------------------------
// POST /saker  – oppretter en ny helpdesk-sak (JWT)
// Body: { tittel, beskrivelse, kategori, prioritet }
// -------------------------------------------------------------------
app.post("/saker", apiLimiter, kreverInnlogging, (req, res) => {
  const { tittel, beskrivelse, kategori, prioritet } = req.body;

  if (!tittel || !beskrivelse) {
    return res.status(400).json({ melding: "tittel og beskrivelse er påkrevd" });
  }

  const sql =
    "INSERT INTO saker (bruker_id, tittel, beskrivelse, kategori, prioritet, status) VALUES (?, ?, ?, ?, ?, ?)";
  const verdier = [req.bruker.bruker_id, tittel, beskrivelse, kategori || "Annet", prioritet || "Normal", STATUS_APEN];

  db.query(sql, verdier, (feil, resultat) => {
    if (feil) {
      return res.status(500).json({ melding: "Kunne ikke opprette sak" });
    }
    res.status(201).json({ melding: "Sak opprettet", sak_id: resultat.insertId });
  });
});

// -------------------------------------------------------------------
// PATCH /saker/:id/lost  – markerer en sak som løst (JWT)
// -------------------------------------------------------------------
app.patch("/saker/:id/lost", apiLimiter, kreverInnlogging, (req, res) => {
  const { id } = req.params;

  const sql = "UPDATE saker SET status = ? WHERE id = ? AND bruker_id = ?";
  db.query(sql, [STATUS_LOST, id, req.bruker.bruker_id], (feil, resultat) => {
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
// DELETE /brukere/meg  – sletter innlogget bruker (og dens saker via CASCADE)
// -------------------------------------------------------------------
app.delete("/brukere/meg", apiLimiter, kreverInnlogging, (req, res) => {
  const sql = "DELETE FROM brukere WHERE id = ?";
  db.query(sql, [req.bruker.bruker_id], (feil, resultat) => {
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

