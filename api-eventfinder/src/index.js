// server express
const app = require('./app');
const express = require('express');
const connectToDb = require('./config/db');
const path = require('path');
const UserModel = require('./models/UserModel');

require('dotenv').config();
const port = process.env.EXPRESS_PORT || 3000;

connectToDb();
require('./config/cronjob');


app.listen(port, () => {
    console.log(`Server running on port http://localhost:${port}`);
});

app.get('/privacy-policy', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'privacy-policy.html'));
});


app.use((err, req, res, next) => {
    res.status(400).json({
        status: 'error',
        message: err.message
    });
});





