const mongoose = require('mongoose');
const { Schema } = mongoose;

// Membuat schema untuk Event dengan relasi ke User
const eventSchema = new Schema({
    title: {
        type: String,
        required: true,
        minlength: 3,
        maxlength: 100
    },
    date: {
        type: Date,
        required: true
    },
    time: {
        start: {
            type: Date,
        },
        end: {
            type: Date,
        }
    },
    location: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true,
    },
    image: {
        type: String,
        default: 'default.jpg'
    },
    category: {
        type: String,
        enum: ['Concert', 'Conference', 'Seminar', 'Workshop', 'Festival', 'Other'],
        required: true
    },
    ticket_price: {
        type: Number,
        default: null
    },
    registration_link: {
        type: String,
        default: null
    },
    status: {
        type: String,
        enum: ['pending', 'approved', 'rejected', 'expired'],
        default: 'pending'
    },
    views: {
        type: Number,
        default: 0
    },

    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Users',
        required: true
    }
}, { timestamps: true });


const Event = mongoose.model('Event', eventSchema);

module.exports = Event;
