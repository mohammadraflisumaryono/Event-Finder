const Event = require('../models/EventModel');  // Model Event
const User = require('../models/UserModel');    // Model User
const jwt = require('jsonwebtoken');  // Untuk memverifikasi JWT

class EventService {
    // Fungsi untuk membuat Event baru
    static async createEvent(data, userId) {
        try {
            // Validasi jika userId yang dikirim sesuai dengan yang ada di JWT
            if (data.userId !== userId) {
                throw new Error("User ID tidak cocok dengan JWT");
            }

            const newEvent = new Event(data);
            await newEvent.save();
            return newEvent;
        } catch (error) {
            throw new Error(`Error creating event: ${error.message}`);
        }
    }

    // Fungsi untuk mendapatkan semua events
    static async getAllEvents() {
        try {
            const events = await Event.find().populate('userId', 'name email');
            return events;
        } catch (error) {
            throw new Error(`Error fetching events: ${error.message}`);
        }
    }

    // Fungsi untuk mendapatkan event berdasarkan ID
    static async getEventById(eventId) {
        try {
            const event = await Event.findById(eventId).populate('userId', 'name email');
            if (!event) {
                throw new Error('Event not found');
            }
            return event;
        } catch (error) {
            throw new Error(`Error fetching event: ${error.message}`);
        }
    }

    // Fungsi untuk mengupdate event
    static async updateEvent(eventId, data, userId) {
        try {
            // Pastikan userId yang mengupdate event adalah pemilik acara
            const event = await Event.findById(eventId);
            if (!event) {
                throw new Error('Event not found');
            }

            if (event.userId.toString() !== userId.toString()) {
                throw new Error("You are not authorized to update this event.");
            }

            // Mengupdate event
            Object.assign(event, data);
            await event.save();
            return event;
        } catch (error) {
            throw new Error(`Error updating event: ${error.message}`);
        }
    }

    // Fungsi untuk menghapus event
    static async deleteEvent(eventId, userId) {
        try {
            const event = await Event.findById(eventId);
            if (!event) {
                throw new Error('Event not found');
            }

            if (event.userId.toString() !== userId.toString()) {
                throw new Error("You are not authorized to delete this event.");
            }

            await event.remove();
            return { message: 'Event successfully deleted' };
        } catch (error) {
            throw new Error(`Error deleting event: ${error.message}`);
        }
    }
}

module.exports = EventService;
