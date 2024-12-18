const EventService = require('../services/EventService');
const jwt = require('jsonwebtoken');  // Untuk memverifikasi JWT

// Fungsi untuk membuat Event baru
exports.createEvent = async (req, res) => {
    try {
        const { title, date, time, location, description, image, category, ticket_price, registration_link } = req.body;
        const token = req.headers.authorization?.split(" ")[1];  // Mendapatkan token JWT dari header

        if (!token) {
            return res.status(401).json({ message: 'Token is required for authentication' });
        }

        // Verifikasi JWT untuk mendapatkan userId
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const userId = decoded.id;  // Mendapatkan userId dari JWT

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
            userId  // Menyertakan userId dalam data
        };

        const newEvent = await EventService.createEvent(eventData, userId);
        res.status(201).json({ message: 'Event created successfully', event: newEvent });
    } catch (error) {
        res.status(500).json({ message: 'Failed to create event', error: error.message });
    }
};

// Fungsi untuk mendapatkan semua Event
exports.getAllEvents = async (req, res) => {
    try {
        const events = await EventService.getAllEvents();
        res.status(200).json(events);
    } catch (error) {
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
        res.status(500).json({ message: 'Error fetching event', error: error.message });
    }
};

// Fungsi untuk mengupdate Event
exports.updateEvent = async (req, res) => {
    try {
        const eventId = req.params.eventId;
        const data = req.body;
        const token = req.headers.authorization?.split(" ")[1];  // Mendapatkan token JWT dari header

        if (!token) {
            return res.status(401).json({ message: 'Token is required for authentication' });
        }

        // Verifikasi JWT untuk mendapatkan userId
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const userId = decoded.id;

        const updatedEvent = await EventService.updateEvent(eventId, data, userId);
        res.status(200).json({ message: 'Event updated successfully', event: updatedEvent });
    } catch (error) {
        res.status(500).json({ message: 'Failed to update event', error: error.message });
    }
};

// Fungsi untuk menghapus Event
exports.deleteEvent = async (req, res) => {
    try {
        const eventId = req.params.eventId;
        const token = req.headers.authorization?.split(" ")[1];  // Mendapatkan token JWT dari header

        if (!token) {
            return res.status(401).json({ message: 'Token is required for authentication' });
        }

        // Verifikasi JWT untuk mendapatkan userId
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const userId = decoded.id;

        const response = await EventService.deleteEvent(eventId, userId);
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ message: 'Failed to delete event', error: error.message });
    }
};
