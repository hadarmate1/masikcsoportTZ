
const express = require("express");
const mysql = require("mysql2/promise");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

const dbConfig = {
    host: process.env.DB_HOST || "127.0.0.1",
    port: process.env.DB_PORT ? Number(process.env.DB_PORT) : 3307,
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "",
    database: process.env.DB_NAME || "szerviz_db",
    waitForConnections: true,
    connectionLimit: 5
};

const pool = mysql.createPool(dbConfig);


app.get("/szolgaltatasok", async (req, res) => {
    try {
        const [adatok] = await pool.query(`
            SELECT szolgaltatasok.id,
                   szolgaltatasok.megnevezes,
                   szolgaltatasok.alapar,
                   szolgaltatasok.munkaido_perc,
                   szolgaltatasok.aktiv,
                   kategoriak.nev
            FROM szolgaltatasok
            INNER JOIN kategoriak
            ON kategoriak.id = szolgaltatasok.kategoria_id
            ORDER BY szolgaltatasok.alapar ASC
        `);

        res.status(200).json(adatok);

    } catch (hiba) {
        console.log(hiba);
        res.status(500).json({ hiba: "Adatbázis hiba" });
    }
});

app.get("/szolgaltatasok/elerheto", async (req, res) => {
    try {
        const [adatok] = await pool.query(`
            SELECT szolgaltatasok.id,
                   szolgaltatasok.kategoria_id,
                   szolgaltatasok.megnevezes,
                   szolgaltatasok.alapar,
                   szolgaltatasok.munkaido_perc,
                   szolgaltatasok.aktiv
            FROM szolgaltatasok
            WHERE szolgaltatasok.aktiv = 1
            AND szolgaltatasok.munkaido_perc <= 60
        `);

        res.status(200).json(adatok);

    } catch (hiba) {
        console.log(hiba);
        res.status(500).json({ hiba: "Adatbázis hiba" });
    }
});


app.get("/szolgaltatasok/kereses/:szoveg", async (req, res) => {
    try {
        const szoveg = req.params.szoveg;

        const [adatok] = await pool.query(`
            SELECT id, kategoria_id, megnevezes,
                   alapar, munkaido_perc, aktiv
            FROM szolgaltatasok
            WHERE megnevezes LIKE ?
        `, [`%${szoveg}%`]);

        res.status(200).json(adatok);

    } catch (hiba) {
        console.log(hiba);
        res.status(500).json({ hiba: "Adatbázis hiba" });
    }
});


app.get("/kategoriak/statisztika", async (req, res) => {
    try {
        const [adatok] = await pool.query(`
            SELECT kategoriak.nev AS "Kategória neve",
                   COUNT(szolgaltatasok.id) AS "szolgaltatasok szama",
                   ROUND(AVG(szolgaltatasok.alapar)) AS "szolgaltatasok atlag ara"
            FROM kategoriak
            INNER JOIN szolgaltatasok
            ON kategoriak.id = szolgaltatasok.kategoria_id
            GROUP BY kategoriak.nev
        `);

        res.status(200).json(adatok);

    } catch (hiba) {
        console.log(hiba);
        res.status(500).json({ hiba: "Adatbázis hiba" });
    }
});


app.get("/szolgaltatasok/dragak", async (req, res) => {
    try {
        const [adatok] = await pool.query(`
            SELECT szolgaltatasok.megnevezes,
                   szolgaltatasok.alapar,
                   szolgaltatasok.munkaido_perc
            FROM szolgaltatasok
            WHERE szolgaltatasok.alapar > 25000
            ORDER BY szolgaltatasok.munkaido_perc DESC
        `);

        res.status(200).json(adatok);

    } catch (hiba) {
        console.log(hiba);
        res.status(500).json({ hiba: "Adatbázis hiba" });
    }
});
app.post("/szolgaltatasok", async (req, res) => {
    try {
        const { kategoria_id, megnevezes, alapar, munkaido_perc, aktiv } = req.body;

        await pool.query(
            "INSERT INTO szolgaltatasok VALUES (NULL, ?, ?, ?, ?, ?)",
            [kategoria_id, megnevezes, alapar, munkaido_perc, aktiv]
        );

        res.json({ uzenet: "Sikeres hozzáadás!" });

    } catch (hiba) {
        res.status(500).json({ hiba: "Adatbázis hiba!" });
    }
});
app.put("/szolgaltatasok/:id", async (req, res) => {
    try {
        const { kategoria_id, megnevezes, alapar, munkaido_perc, aktiv } = req.body;

        await pool.query(
            "UPDATE szolgaltatasok SET kategoria_id=?, megnevezes=?, alapar=?, munkaido_perc=?, aktiv=? WHERE id=?",
            [kategoria_id, megnevezes, alapar, munkaido_perc, aktiv, req.params.id]
        );

        res.json({ uzenet: "Sikeres módosítás!" });

    } catch (hiba) {
        res.status(500).json({ hiba: "Adatbázis hiba!" });
    }
});
app.delete("/szolgaltatasok/:id", async (req, res) => {
    try {
        await pool.query(
            "DELETE FROM szolgaltatasok WHERE id=?",
            [req.params.id]
        );

        res.json({ uzenet: "Sikeres törlés!" });

    } catch (hiba) {
        res.status(500).json({ hiba: "Adatbázis hiba!" });
    }
});