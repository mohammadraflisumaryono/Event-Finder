const cron = require('node-cron');
const EventServices = require('../services/EventService');

console.log('Starting cronjob...');

// Jadwalkan pengecekan event yang expired setiap hari pada jam 00:00
cron.schedule('0 0 * * *', async () => {
    console.log('Running check for expired events...');
    await (EventServices.checkExpiredEvent());
});


