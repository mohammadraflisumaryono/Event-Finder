const Event = require('../models/EventModel');  // Model Event
const User = require('../models/UserModel');    // Model User
const jwt = require('jsonwebtoken');  // Untuk memverifikasi JWT

class EventService {
    // Fungsi untuk membuat Event baru
    static async createEvent(data, userId) {
        console.log(data);
        try {
            // Menambahkan userId yang terautentikasi ke dalam data event
            data.userId = userId;  // Menyisipkan userId yang valid dari token

            const newEvent = new Event(data);
            await newEvent.save();
            console.log('New Event created:', newEvent);
            return newEvent;
        } catch (error) {
            console.error('Error creating event:', error.message);
            throw new Error(`Error creating event: ${error.message}`);
        }
    }

    // Fungsi untuk mendapatkan semua events
    static async getAllEvents() {
        try {
            const events = await Event.find().populate('userId', 'name email');
            console.log('Fetched all events:', events);
            return events;
        } catch (error) {
            console.error('Error fetching events:', error.message);
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
            console.log('Fetched event by ID:', event);
            return event;
        } catch (error) {
            console.error('Error fetching event by ID:', error.message);
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
            console.log('Updated event:', event);
            return event;
        } catch (error) {
            console.error('Error updating event:', error.message);
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
            console.log('Deleted event:', event);
            return { message: 'Event successfully deleted' };
        } catch (error) {
            console.error('Error deleting event:', error.message);
            throw new Error(`Error deleting event: ${error.message}`);
        }
    }
}

module.exports = EventService;
