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
                // Mengambil string time dan mengonversinya ke objek dengan properti start dan end
                eventTime = JSON.parse(time); // pastikan waktu dalam format JSON yang valid
            } catch (error) {
                return res.status(400).json({
                    status: 'error',
                    data: null,
                    message: 'Invalid time format, should be a valid JSON string'
                });
            }
        } else if (typeof time === 'object' && time !== null) {
            eventTime = time; // time sudah berupa object
        } else {
            return res.status(400).json({
                status: 'error',
                data: null,
                message: 'Time should be a valid object or JSON string'
            });
        }

        // Pastikan time.start dan time.end dalam format tanggal
        if (!eventTime.start || !eventTime.end) {
            return res.status(400).json({
                status: 'error',
                data: null,
                message: 'Start time and end time are required'
            });
        }

        // Pastikan start dan end adalah tanggal yang valid
        const startDate = new Date(eventTime.start);
        const endDate = new Date(eventTime.end);

        if (isNaN(startDate) || isNaN(endDate)) {
            return res.status(400).json({
                status: 'error',
                data: null,
                message: 'Start time or end time is invalid'
            });
        }

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

        // Menyimpan hanya nama file gambar
        let imageFileName = null;
        if (req.file) {
            // Mendapatkan nama file gambar yang diupload (tanpa path lengkap)
            imageFileName = req.file.filename; // hanya nama file yang disimpan
        }

        // Menyiapkan data event dengan userId
        const eventData = {
            title,
            date,
            time: { start: startDate, end: endDate },
            location,
            description,
            image: imageFileName, // Menyimpan hanya nama file
            category,
            ticket_price,
            registration_link,
            status: 'pending',
            views: 0,
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
};
