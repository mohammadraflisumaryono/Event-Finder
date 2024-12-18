// models/UserModel.js
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const { Schema } = mongoose;

const userSchema = new Schema({
    name: {
        type: String,
        required: [true, 'Name is required'],
        minlength: 3,
        maxlength: 50
    },
    email: {
        type: String,
        required: [true, 'Email is required'],
        unique: true,
        lowercase: true
    },
    phone_number: {
        type: String,
        default: null
    },
    password: {
        type: String,
        required: [true, 'Password is required'],
        minlength: 6,
        maxlength: 20
    },
});

// Hash password sebelum disimpan
userSchema.pre('save', async function (next) {
    const user = this;
    if (user.isModified('password')) {
        user.password = await bcrypt.hash(user.password, 8);
    }
    next();
});


// Method untuk membandingkan password
userSchema.methods.comparePassword = async function (password) {
    return bcrypt.compare(password, this.password);
};


// Model untuk user
const UserModel = mongoose.model('Users', userSchema);



module.exports = UserModel;
