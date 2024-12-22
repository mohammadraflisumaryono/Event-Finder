const express = require('express');
const bodyParser = require('body-parser');
const UserRoute = require('./routes/UserRoute');
const EventRoute = require('./routes/EventRoute');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(bodyParser.json());

app.use('/api', UserRoute);
app.use('/api', EventRoute);

module.exports = app;
