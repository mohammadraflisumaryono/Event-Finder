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
app.use('/uploads', express.static(path.join(__dirname, './uploads/images')));

app.listen(port, () => {
    console.log(`Server running on port http://localhost:${port}`);
});


app.use((err, req, res, next) => {
    res.status(400).json({
        status: 'error',
        message: err.message
    });
});





