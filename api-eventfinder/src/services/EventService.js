const Event = require('../models/EventModel');  // Model Event
const User = require('../models/UserModel');    // Model User
const jwt = require('jsonwebtoken');  // Untuk memverifikasi JWT

class EventService {
    // Fungsi untuk membuat Event baru
    static async createEvent(data, userId) {
        console.log(data);
        try {

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
            // hanya ambil event yang statusnya sudah approved
            const events = await Event.find({ status: 'approved' })
                .populate('userId', 'name email')
                .sort({ createdAt: -1 });
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
    console.log('Data received for update:', data);
    try {
        const event = await Event.findById(eventId);

        if (!event) {
            throw new Error('Event not found');
        }

        // Validasi kepemilikan event
        if (event.userId.toString() !== userId) {
            throw new Error('Unauthorized');
        }

        // Filter field yang valid berdasarkan schema
        const schemaPaths = Object.keys(Event.schema.paths);
        const filteredData = {};

        Object.keys(data).forEach((key) => {
            // Validasi dan perbaiki format data
            if (schemaPaths.includes(key) && key !== 'updatedAt' && key !== 'createdAt' && key !== 'userId') {
                if (key === 'date' && typeof data[key] === 'string') {
                    // Parse date to valid Date object
                    filteredData[key] = new Date(data[key]);
                } else if (key === 'ticket_price' && data[key] === undefined) {
                    // Handle undefined ticket_price by setting it to null
                    filteredData[key] = null;
                } else {
                    filteredData[key] = data[key];
                }
            } else {
                console.warn(`Field "${key}" is invalid or not updatable and will be ignored.`);
            }
        });

        console.log('Filtered data for update:', filteredData);

        // Update dengan `findOneAndUpdate`
        const updatedEvent = await Event.findOneAndUpdate(
            { _id: eventId },
            { $set: filteredData },
            { new: true, runValidators: true } // Kembalikan dokumen terbaru dan validasi input
        );

        if (!updatedEvent) {
            throw new Error('Failed to update event');
        }

        console.log('Updated event:', updatedEvent);
        return updatedEvent;
    } catch (error) {
        console.error('Error updating event:', error.message);
        throw new Error(`Failed to update event: ${error.message}`);
    }
}




    // Fungsi untuk menghapus event
    static async deleteEvent(eventId, userId) {
        // debug
        console.log('Event ID:', eventId);
        console.log('User ID:', userId);
        try {
            const event = await Event.findById(eventId);
            console.log('Event:', event);
            if (!event) {
                throw new Error('Event not found');
            }

            if (event.userId.toString() !== userId.toString()) {
                throw new Error("You are not authorized to delete this event.");
            }

            await Event.deleteOne({ _id: eventId });
            // return deleted data
            console.log('Deleted event:', event);
            return event;
        } catch (error) {
            console.error('Error deleting event:', error.message);
            throw new Error(`Error deleting event: ${error.message}`);
        }
    }

    // Function for searching events by title or description
    static async searchEvent(query) {
        try {
            // Perform case-insensitive search for title and description fields
            const events = await Event.find({
                $or: [
                    { title: { $regex: query, $options: 'i' } },
                    { description: { $regex: query, $options: 'i' } }
                ]
            }).populate('userId', 'name email');

            console.log('Search results:', events);
            return events;
        } catch (error) {
            console.error('Error searching events:', error.message);
            throw new Error(`Error searching events: ${error.message}`);
        }
    }



    // Fungsi untuk mendapatkan events berdasarkan kategori
    static async getEventsByCategory(category) {

        try {
            const events = await Event.find({ category: category, status: 'approved' })  // Hanya mengambil event yang statusnya bukan expired
                .populate('userId', 'name email');
            console.log('Fetched events by category:', events);
            return events;
        } catch (error) {
            console.error('Error fetching events by category:', error.message);
            throw new Error(`Error fetching events by category: ${error.message}`);
        }
    }

    // get all events created by a organizer
    static async getEventsByOrganizer(userId) {
        try {
            const events = await Event.find({ userId, status: { $ne: 'expired' } })  // Hanya mengambil event yang statusnya bukan expired
                .populate('userId', 'name email')
                .sort({ createdAt: -1 });
            console.log('Fetched events by organizer:', events);
            return events;
        } catch (error) {
            console.error('Error fetching events by organizer:', error.message);
            throw new Error(`Error fetching events by organizer: ${error.message}`);
        }
    }

    // Function to update event views
    static async updateEventViews(eventId) {
        try {
            const event = await Event.findById(eventId);
            if (!event) {
                throw new Error('Event not found');
            }

            event.views += 1;
            await event.save();
            console.log('Updated event views:', event);
            return event;
        }
        catch (error) {
            console.error('Error updating event views:', error.message);
            throw new Error(`Error updating event views: ${error.message}`);
        }
    }

    // Function to approve or reject an event
    static async approveEvent(eventId, status) {
        try {
            const event = await Event.findById(eventId);
            if (!event) {
                throw new Error('Event not found');
            }

            event.status = status;
            await event.save();
            console.log('Updated event status:', event);
            return event;
        } catch (error) {
            console.error('Error updating event status:', error.message);
            throw new Error(`Error updating event status: ${error.message}`);
        }
    }

    static async getTrendingEvents() {
        try {
            // Sort events by 'views' in descending order and limit to the top 3
            const events = await Event.find({ status: 'approved' })  // Hanya mengambil event yang statusnya bukan expired
                .sort({ views: -1 })
                .limit(3);
            // Log the fetched events (optional, for debugging)
            console.log('Fetched trending events:', events);

            return events;
        } catch (error) {
            console.error('Error fetching trending events:', error.message);
            throw new Error(`Error fetching trending events: ${error.message}`);
        }
    }

    //    cek semua event yang telah lewat lalu buat expired
    static async checkExpiredEvent() {
        try {
            const events = await Event.find({ status: 'approved' });
            const currentDate = new Date();
            events.forEach(async (event) => {
                if (event.endDate < currentDate) {
                    event.status = 'expired';
                    await event.save();
                }
            });
        } catch (error) {
            console.error('Error checking expired events:', error.message);
            throw new Error(`Error checking expired events: ${error.message}`);
        }
    }

    // Function to update event views
    static async updateEventViews(eventId) {
        try {
            const event = await Event.findById(eventId);
            if (!event) {
                throw new Error('Event not found');
            }
            event.views += 1;
            await event.save();
            console.log('Updated event views:', event);
            return event;
        } catch (error) {
            console.error('Error updating event views:', error.message);
            throw new Error(`Error updating event views: ${error.message}`);
        }
    }


    // get events pending
    static async getPendingEvents() {
        try {
            const events = await Event.find({ status: 'pending' })
                .populate('userId', 'name email')
                .sort({ createdAt: -1 });
            return events;
        } catch (error) {
            console.error('Error fetching pending events:', error.message);
            throw new Error(`Error fetching pending events: ${error.message}`);
        }
    }


}

module.exports = EventService;
