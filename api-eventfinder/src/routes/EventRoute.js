const express = require('express');
const router = express.Router();
const eventController = require('../controllers/EventController');
const verifyToken = require('../middlewares/AuthMiddleware'); // Assuming verifyToken middleware

// Create event
router.post('/events', verifyToken, eventController.createEvent);

// Get all events
router.get('/events', eventController.getAllEvents);

// Get event by ID
router.get('/events/:eventId', eventController.getEventById);

// Update event
router.put('/events/:eventId', verifyToken, eventController.updateEvent);

// Delete event
router.delete('/events/:eventId', verifyToken, eventController.deleteEvent);

module.exports = router;
