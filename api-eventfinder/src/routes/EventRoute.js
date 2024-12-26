const express = require('express');
const router = express.Router();
const eventController = require('../controllers/EventController');
const verifyToken = require('../middlewares/AuthMiddleware'); // Assuming verifyToken middleware
const upload = require('../middlewares/uploadImage');

// Create event
router.post('/events', upload.single('image'), verifyToken, eventController.createEvent);


// Get all events
router.get('/events', eventController.getAllEvents);

// Get event by ID
router.get('/events/:eventId', eventController.getEventById);

// Get event By Category
router.get('/events/category/:category', eventController.eventByCategory);

//search event
router.get('/search', eventController.searchEvent);  // Corrected route for search


// Update event
router.put('/events/:eventId', verifyToken, eventController.updateEvent);

// Delete event
router.delete('/events/:eventId', verifyToken, eventController.deleteEvent);

// Get trending events (default to top 3)
router.get('/trending', eventController.getTrendingEvent);

// Get events by organizer
router.get('/events/organizer/:userId', verifyToken, eventController.eventByOrganizer);





module.exports = router;
