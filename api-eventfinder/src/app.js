const express = require('express');
const bodyParser = require('body-parser');
const UserRoute = require('./routes/UserRoute');
const EventRoute = require('./routes/EventRoute');
const cors = require('cors');

const app = express();

app.use(cors());

// Atur batas ukuran payload pada body-parser
app.use(bodyParser.json({ limit: '10mb' })); // Tingkatkan sesuai kebutuhan
app.use(bodyParser.urlencoded({ extended: true, limit: '10mb' }));


app.use('/api', UserRoute);
app.use('/api', EventRoute);

app.use((err, req, res, next) => {
    if (err.type === 'entity.too.large') {
        return res.status(413).send('Payload terlalu besar!');
    }
    next(err);
});

module.exports = app;
