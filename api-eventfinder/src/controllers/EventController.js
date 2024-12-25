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
            return res.status(400).json({
                status: 'error',
                data: null,
                message: 'User not authenticated'
            });
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
        res.status(201).json({
            status: 'success',
            data: newEvent,
            message: 'Event created successfully'
        });
    } catch (error) {
        console.error('Error creating event:', error);
        res.status(500).json({
            status: 'error',
            data: null,
            message: `Failed to create event: ${error.message}`
        });
    }
};

// Fungsi untuk mendapatkan semua Event
exports.getAllEvents = async (req, res) => {
    try {
        const events = await EventService.getAllEvents();
        res.status(200).json({
            status: 'success',
            data: events,
            message: 'Events fetched successfully'
        });
    } catch (error) {
        console.error('Error fetching events:', error);
        res.status(500).json({
            status: 'error',
            data: null,
            message: `Error fetching events: ${error.message}`
        });
    }
};

// Fungsi untuk mendapatkan event berdasarkan ID
exports.getEventById = async (req, res) => {
    try {
        const eventId = req.params.eventId;
        const event = await EventService.getEventById(eventId);
        res.status(200).json({
            status: 'success',
            data: event,
            message: 'Event fetched successfully'
        });
    } catch (error) {
        console.error('Error fetching event:', error);
        res.status(500).json({
            status: 'error',
            data: null,
            message: `Error fetching event: ${error.message}`
        });
    }
};

// Fungsi untuk mengupdate Event
exports.updateEvent = async (req, res) => {
    try {
        const eventId = req.params.eventId;
        const data = req.body;
        const userId = req.user._id;  // Mengambil userId dari req.user

        const updatedEvent = await EventService.updateEvent(eventId, data, userId);
        res.status(200).json({
            status: 'success',
            data: updatedEvent,
            message: 'Event updated successfully'
        });
    } catch (error) {
        console.error('Error updating event:', error);
        res.status(500).json({
            status: 'error',
            data: null,
            message: `Failed to update event: ${error.message}`
        });
    }
};

// Fungsi untuk menghapus Event
exports.deleteEvent = async (req, res) => {
    try {
        const eventId = req.params.eventId;
        const userId = req.user._id;  // Mengambil userId dari req.user

        const response = await EventService.deleteEvent(eventId, userId);
        res.status(200).json({
            status: 'success',
            data: response,
            message: 'Event deleted successfully'
        });
    } catch (error) {
        console.error('Error deleting event:', error);
        res.status(500).json({
            status: 'error',
            data: null,
            message: `Failed to delete event: ${error.message}`
        });
    }
};

exports.searchEvent = async (req, res) => {
    try {
        // Access the query parameter `q`
        const query = req.query.q;

        // Check if the query parameter is provided
        if (!query || query.trim() === '') {
            return res.status(400).json({
                status: 'error',
                data: null,
                message: 'Search query is required'
            });
        }

        // Call the search function from EventService
        const events = await EventService.searchEvent(query);
        res.status(200).json({
            status: 'success',
            data: events,
            message: 'Events fetched successfully'
        });
    } catch (error) {
        console.error('Error fetching events:', error);
        res.status(500).json({
            status: 'error',
            data: null,
            message: `Error fetching events: ${error.message}`
        });
    }
};


// Fungsi untuk mendapatkan event berdasarkan kategori
exports.eventByCategory = async (req, res) => {
    try {
        const category = req.params.category;
        const events = await EventService.getEventsByCategory(category);
        res.status(200).json({
            status: 'success',
            data: events,
            message: 'Events fetched successfully'
        });
    } catch (error) {
        console.error('Error fetching events:', error);
        res.status(500).json({
            status: 'error',
            data: null,
            message: `Error fetching events: ${error.message}`
        });
    }
};