const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(express.static('web'));

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'bibliotheque'
});

db.connect((err) => {
    if (err) throw err;
    console.log('Connecté à la base de données');
});

app.post('/api/inscription', (req, res) => {
    const { nom, email, mot_de_passe } = req.body;
    const sql = 'INSERT INTO utilisateurs (nom, email, mot_de_passe) VALUES (?, ?, ?)';
    db.query(sql, [nom, email, mot_de_passe], (err, result) => {
        if (err) return res.json({ success: false, error: err });
        res.json({ success: true });
    });
});

app.post('/api/login', (req, res) => {
    const { email, mot_de_passe } = req.body;
    const sql = 'SELECT id FROM utilisateurs WHERE email = ? AND mot_de_passe = ?';
    db.query(sql, [email, mot_de_passe], (err, results) => {
        if (err) return res.json({ success: false, error: err });
        if (results.length > 0) {
            res.json({ success: true });
        } else {
            res.json({ success: false });
        }
    });
});

app.get('/api/livres', (req, res) => {
    const sql = `SELECT livres.id, livres.titre, auteurs.nom AS auteur, livres.genre, livres.date_publication 
                 FROM livres 
                 JOIN auteurs ON livres.auteur_id = auteurs.id`;
    db.query(sql, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

app.post('/api/emprunter', (req, res) => {
    const { livre_id } = req.body;
    // Remplacer par la vraie logique utilisateur une fois que l'authentification est mise en place
    const utilisateur_id = 1;
    const sql = 'INSERT INTO emprunts (livre_id, utilisateur_id) VALUES (?, ?)';
    db.query(sql, [livre_id, utilisateur_id], (err, result) => {
        if (err) return res.json({ success: false, error: err });
        res.json({ success: true });
    });
});

app.get('/api/panier', (req, res) => {
    const utilisateur_id = 1;
    const sql = `SELECT livres.titre, auteurs.nom AS auteur, livres.genre, livres.date_publication, emprunts.date_emprunt, emprunts.date_retour 
                 FROM emprunts 
                 JOIN livres ON emprunts.livre_id = livres.id 
                 JOIN auteurs ON livres.auteur_id = auteurs.id 
                 WHERE emprunts.utilisateur_id = ?`;
    db.query(sql, [utilisateur_id], (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

app.listen(port, () => {
    console.log(`Serveur en cours d'exécution sur http://localhost:${port}`);
});
