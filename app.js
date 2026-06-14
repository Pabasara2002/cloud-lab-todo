const express = require('express');
const Database = require('better-sqlite3');
const path = require('path');

const app = express();
const PORT = 3000;

// FIX: Dynamically targets 'todos.db' relative to the directory where app.js runs
const db = new Database(path.join(__dirname, 'todos.db'));

// Initialise database schema
db.exec(`CREATE TABLE IF NOT EXISTS todos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    task TEXT NOT NULL,
    done INTEGER DEFAULT 0
)`);

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// API routes
app.get('/api/todos', (req, res) => {
    res.json(db.prepare('SELECT * FROM todos').all());
});

app.post('/api/todos', (req, res) => {
    const { task } = req.body;
    const result = db.prepare('INSERT INTO todos (task) VALUES (?)').run(task);
    res.json({ id: result.lastInsertRowid, task, done: 0 });
});

app.patch('/api/todos/:id', (req, res) => {
    db.prepare('UPDATE todos SET done = 1 WHERE id = ?').run(req.params.id);
    res.json({ updated: true });
});

// Root path confirmation route
app.get('/', (req, res) => {
    res.send('To-Do App Backend is running successfully!');
});

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
