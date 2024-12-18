const express = require('express');
const router = express.Router();
const eventController = require('../controllers/EventController');

// Rute untuk membuat event
router.post('/events', eventController.createEvent);

// Rute untuk mendapatkan semua event
router.get('/events', eventController.getAllEvents);

// Rute untuk mendapatkan event berdasarkan ID
router.get('/events/:eventId', eventController.getEventById);

// Rute untuk mengupdate event
router.put('/events/:eventId', eventController.updateEvent);

// Rute untuk menghapus event
router.delete('/events/:eventId', eventController.deleteEvent);

module.exports = router;
