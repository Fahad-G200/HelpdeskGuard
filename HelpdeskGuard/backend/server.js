require("dotenv").config();

const express = require("express");
const mysql = require("mysql2");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

if (!process.env.DB_PASSWORD) {
  console.error("Feil: DB_PASSWORD er ikke satt. Opprett en .env-fil basert på .env.example");
  process.exit(1);
}

if (!process.env.JWT_SECRET) {
  console.error("Feil: JWT_SECRET er ikke satt. Legg til JWT_SECRET i .env-filen.");
  process.exit(1);
}

const JWT_SECRET = process.env.JWT_SECRET;

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

// Middleware: sjekker at forespørselen har en gyldig JWT-token
function krevAuth(req, res, neste) {
  const header = req.headers["authorization"];
  if (!header || !header.startsWith("Bearer ")) {
    return res.status(401).json({ melding: "Ikke autentisert. Logg inn først." });
  }
  const token = header.split(" ")[1];
  try {
    const data = jwt.verify(token, JWT_SECRET);
    req.bruker = data; // inneholder bruker_id og epost
    neste();
  } catch {
    return res.status(401).json({ melding: "Token er ugyldig eller utløpt. Logg inn på nytt." });
  }
}

// POST /registrer – oppretter ny bruker med bcrypt-hashet passord
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

// POST /logginn – verifiserer passord og returnerer en JWT-token
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

    // Lag en JWT-token som utløper etter 7 dager
    const token = jwt.sign(
      { bruker_id: bruker.id, epost: bruker.epost },
      JWT_SECRET,
      { expiresIn: "7d" }
    );

    res.json({ melding: "Innlogging vellykket", token, epost: bruker.epost });
  });
});

// POST /saker – oppretter en ny sak (bruker_id hentes fra token, ikke fra klienten)
app.post("/saker", krevAuth, (req, res) => {
  const bruker_id = req.bruker.bruker_id;
  const { tittel, beskrivelse, kategori, prioritet } = req.body;

  if (!tittel || !beskrivelse) {
    return res.status(400).json({ melding: "tittel og beskrivelse er påkrevd" });
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

// GET /saker – henter kun sakene som tilhører den innloggede brukeren (fra token)
app.get("/saker", krevAuth, (req, res) => {
  const bruker_id = req.bruker.bruker_id;

  const sql = "SELECT * FROM saker WHERE bruker_id = ? ORDER BY opprettet DESC";
  db.query(sql, [bruker_id], (feil, rader) => {
    if (feil) {
      return res.status(500).json({ melding: "Kunne ikke hente saker" });
    }
    res.json(rader);
  });
});

// PATCH /saker/:sak_id/lost – marker sak som løst, kun eieren kan gjøre dette
app.patch("/saker/:sak_id/lost", krevAuth, (req, res) => {
  const sak_id = req.params.sak_id;
  const bruker_id = req.bruker.bruker_id;

  const sql = "UPDATE saker SET er_lost = TRUE WHERE id = ? AND bruker_id = ?";
  db.query(sql, [sak_id, bruker_id], (feil, resultat) => {
    if (feil) {
      return res.status(500).json({ melding: "Kunne ikke oppdatere sak" });
    }
    if (resultat.affectedRows === 0) {
      return res.status(404).json({ melding: "Saken ble ikke funnet eller tilhører en annen bruker" });
    }
    res.json({ melding: "Sak markert som løst" });
  });
});

// DELETE /brukere/meg – sletter den innloggede brukerens konto
app.delete("/brukere/meg", krevAuth, (req, res) => {
  const bruker_id = req.bruker.bruker_id;

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
