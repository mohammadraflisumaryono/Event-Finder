const EventService = require('../services/EventService');
const verifyToken = require('../middlewares/AuthMiddleware');

// Fungsi untuk membuat Event baru
exports.createEvent = async (req, res) => {
    try {
        // Mendapatkan data dari body
        const { title, date, time, location, description, image, category, ticket_price, registration_link } = req.body;

        // Dapatkan userId dari req.user (dari middleware verifyToken)
        const userId = req.user._id;

        console.log('User ID:', userId);

        if (!userId) {
            return res.status(400).json({ message: 'User not authenticated' });
        }

        // Menyiapkan data event dengan userId
        const eventData = {
            title,
            date,
            time,
            location,
            description,
            image,
            category,
            ticket_price,
            registration_link,
            userId  // Menyertakan userId yang sudah didapatkan dari JWT
        };

        // Membuat event dengan data yang sudah diproses
        const newEvent = await EventService.createEvent(eventData, userId);
        res.status(201).json({ message: 'Event created successfully', event: newEvent });
    } catch (error) {
        console.error('Error creating event:', error);
        res.status(500).json({ message: 'Failed to create event', error: error.message });
    }
};


// Fungsi untuk mendapatkan semua Event
exports.getAllEvents = async (req, res) => {
    try {
        const events = await EventService.getAllEvents();
        res.status(200).json(events);
    } catch (error) {
        console.error('Error fetching events:', error);
        res.status(500).json({ message: 'Error fetching events', error: error.message });
    }
};

// Fungsi untuk mendapatkan event berdasarkan ID
exports.getEventById = async (req, res) => {
    try {
        const eventId = req.params.eventId;
        const event = await EventService.getEventById(eventId);
        res.status(200).json(event);
    } catch (error) {
        console.error('Error fetching event:', error);
        res.status(500).json({ message: 'Error fetching event', error: error.message });
    }
};

// Fungsi untuk mengupdate Event
exports.updateEvent = async (req, res) => {
    try {
        const eventId = req.params.eventId;
        const data = req.body;
        const userId = req.user._id;  // Mengambil userId dari req.user

        const updatedEvent = await EventService.updateEvent(eventId, data, userId);
        res.status(200).json({ message: 'Event updated successfully', event: updatedEvent });
    } catch (error) {
        console.error('Error updating event:', error);
        res.status(500).json({ message: 'Failed to update event', error: error.message });
    }
};

// Fungsi untuk menghapus Event
exports.deleteEvent = async (req, res) => {
    try {
        const eventId = req.params.eventId;
        const userId = req.user._id;  // Mengambil userId dari req.user

        const response = await EventService.deleteEvent(eventId, userId);
        res.status(200).json(response);
    } catch (error) {
        console.error('Error deleting event:', error);
        res.status(500).json({ message: 'Failed to delete event', error: error.message });
    }
};
