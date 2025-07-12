
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');

const app = express();
const port = process.env.PORT || 3000; 

app.use(cors()); 
app.use(express.json());

const dbConfig = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
};

let pool; 


async function connectDB() {
    try {
        pool = mysql.createPool(dbConfig);
        await pool.getConnection(); 
        console.log('Conectado ao banco de dados MySQL!');
    } catch (err) {
        console.error('Erro ao conectar ao banco de dados:', err.message);
    
        setTimeout(connectDB, 5000); 
    }
}


app.get('/', (req, res) => {
    res.send('API Food Travel funcionando!');
});


app.get('/api/products', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM produto'); 
        res.json(rows);
    } catch (err) {
        console.error('Erro ao buscar produtos:', err);
        res.status(500).json({ message: 'Erro interno do servidor ao buscar produtos.' });
    }
});


app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
    connectDB();
});

module.exports = app;