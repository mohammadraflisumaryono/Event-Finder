// server express
const app = require('./app');
const express = require('express');
const connectToDb = require('./config/db');
const UserModel = require('./models/UserModel');

require('dotenv').config();
const port = process.env.EXPRESS_PORT || 3000;

connectToDb();



app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});





