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
            required: true
        },
        end: {
            type: Date,
            required: true
        }
    },
    location: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true,
        minlength: 10,
        maxlength: 1000
    },
    image: {
        type: String,
        default: 'default.jpg'
    },
    category: {
        type: String,
        enum: ['Concert', 'Seminar', 'Exhibition', 'Workshop', 'Festival', 'Other'],
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
   
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',  
        required: true  
    }
}, { timestamps: true });


const Event = mongoose.model('Event', eventSchema);

module.exports = Event;
