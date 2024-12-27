const EventService = require('../services/EventService');
const verifyToken = require('../middlewares/AuthMiddleware');

// Fungsi untuk membuat Event baru
const path = require('path');

exports.createEvent = async (req, res) => {
    try {
        console.log('Creating event... User:', req.body);
        // Mendapatkan data dari body
        const { title, date, time, location, description, category, ticket_price, registration_link } = req.body;


        // Cek apakah time dalam bentuk string dan ubah menjadi object
        let eventTime = {};
        if (typeof time === 'string') {
            try {
                eventTime = JSON.parse(time);
            } catch (error) {
                return res.status(400).json({
                    status: 'error',
                    data: null,
                    message: 'Invalid time format, should be a valid JSON string'
                });
            }
        } else if (typeof time === 'object' && time !== null) {
            eventTime = time;
        } else {
            return res.status(400).json({
                status: 'error',
                data: null,
                message: 'Time should be a valid object or JSON string'
            });
        }

        // Validasi waktu
        if (!eventTime.start || !eventTime.end) {
            return res.status(400).json({
                status: 'error',
                data: null,
                message: 'Start time and end time are required'
            });
        }

        const startDate = new Date(eventTime.start);
        const endDate = new Date(eventTime.end);

        if (isNaN(startDate) || isNaN(endDate)) {
            return res.status(400).json({
                status: 'error',
                data: null,
                message: 'Start time or end time is invalid'
            });
        }

        // Dapatkan userId dari req.user
        const userId = req.user._id;

        console.log('User ID:', userId);

        if (!userId) {
            return res.status(400).json({
                status: 'error',
                data: null,
                message: 'User not authenticated'
            });
        }

        // Menyimpan URL gambar dari Cloudinary
        let imageUrl = null;
        if (req.file) {
            imageUrl = req.file.path; // Cloudinary memberikan URL lengkap di req.file.path
        }

        // Menyiapkan data event
        const eventData = {
            title,
            date,
            time: { start: startDate, end: endDate },
            location,
            description,
            image: imageUrl, // Menyimpan URL Cloudinary
            category,
            ticket_price,
            registration_link,
            status: 'pending',
            views: 0,
            userId
        };

        console.log('Event data:', eventData);

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

        // Cari event berdasarkan ID
        const event = await EventService.getEventById(eventId);
        if (!event) {
            return res.status(404).json({
                status: 'error',
                data: null,
                message: 'Event not found'
            });
        }

        // Tingkatkan jumlah view
        event.views += 1;
        await event.save();

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


// fungsi get tranding event
exports.getTrendingEvent = async (req, res) => {
    try {
        // Call the service to get the trending events
        const events = await EventService.getTrendingEvents();

        // Return the response with the trending events
        res.status(200).json({
            status: 'success',
            data: events,
            message: 'Trending Events fetched successfully'
        });
    } catch (error) {
        console.error('Error fetching trending events:', error);
        res.status(500).json({
            status: 'error',
            data: null,
            message: `Error fetching trending events: ${error.message}`
        });
    }


};

// Fungsi untuk mendapatkan event berdasarkan organizer
exports.eventByOrganizer = async (req, res) => {
    try {
        const userId = req.user._id;
        const events = await EventService.getEventsByOrganizer(userId);
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
}

exports.approveEvent = async (req, res) => {
    try {
        const eventId = req.params.eventId;
        const status = req.body.status;

        // require status
        if (status !== 'approved' && status !== 'rejected') {
            return res.status(400).json({
                status: 'error',
                data: null,
                message: 'Status is required'
            });
        }


        // require admin role
        if (req.user.role !== 'admin') {
            return res.status(403).json({
                status: 'error',
                data: null,
                message: 'Unauthorized to approve event'
            });
        }

        const event = await EventService.approveEvent(eventId, status);
        res.status(200).json({
            status: 'success',
            data: event,
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
}

exports.updateEventViews = async (req, res) => {
    try {
        const eventId = req.params.eventId;
        const event = await EventService.updateEventViews(eventId);
        res.status(200).json({
            status: 'success',
            data: event,
            message: 'Event views updated successfully'
        });
    } catch (error) {
        console.error('Error updating event views:', error);
        res.status(500).json({
            status: 'error',
            data: null,
            message: `Failed to update event views: ${error.message}`
        });
    }
}

exports.getEventPending = async (req, res) => {
    try {
        // cek role
        if (req.user.role !== 'admin') {
            return res.status(403).json({
                status: 'error',
                data: null,
                message: 'Unauthorized to view pending events'
            });
        }
        const events = await EventService.getPendingEvents();
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
}