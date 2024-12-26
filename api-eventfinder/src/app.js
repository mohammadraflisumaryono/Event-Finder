const express = require('express');
const bodyParser = require('body-parser');
const UserRoute = require('./routes/UserRoute');
const EventRoute = require('./routes/EventRoute');
const cors = require('cors');

const app = express();
app.use(cors());

// Atur batas ukuran payload pada body-parser
app.use(bodyParser.json({ limit: '20mb' })); // Tingkatkan sesuai kebutuhan
app.use(bodyParser.urlencoded({ extended: true, limit: '20mb' }));


app.use('/api', UserRoute);
app.use('/api', EventRoute);

module.exports = app;
