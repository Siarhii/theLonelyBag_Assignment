const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

const DATA_DIR = '/app/data'; //this is the main dir for persistent storage , inside docker it should create a directory if there is none, and our ec2 directory will be mpunted as /app/data inside docker
const COUNTER_FILE = path.join(DATA_DIR, 'count.txt');

if (!fs.existsSync(DATA_DIR)) {
    fs.mkdirSync(DATA_DIR, { recursive: true });
}

app.get('/', (req, res) => {
    let count = 0;
    if (fs.existsSync(COUNTER_FILE)) {
        try {
            const data = fs.readFileSync(COUNTER_FILE, 'utf8');
            count = parseInt(data.trim());
            if (isNaN(count)) {
                count = 0;
            }
        } catch (err) {
            console.error('Error reading counter file:', err);
            count = 0;
        }
    }

    count++;
    try {
        fs.writeFileSync(COUNTER_FILE, count.toString());
    } catch (err) {
        console.error('Error writing counter file:', err);
    }

    res.send(`
    <h1>Hello from Node.js Docker on AWS EC2!</h1>
    <p>This page has been visited ${count} times.</p>
    <p>The counter value is stored in a file at: <code>${COUNTER_FILE}</code></p>
  `);
});

app.listen(PORT, () => {
    console.log(`Node.js web app listening on port ${PORT}`);
    console.log(`Data directory: ${DATA_DIR}`);
    console.log(`Counter file: ${COUNTER_FILE}`);
});