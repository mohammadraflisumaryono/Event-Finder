const express = require('express');
const bodyParser = require('body-parser');
const UserRoute = require('./routes/UserRoute');

const app = express();
app.use(bodyParser.json());

app.use('/api', UserRoute);

module.exports = app;
