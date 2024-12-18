require('dotenv').config();  // Memuat variabel lingkungan dari file .env
const mongoose = require('mongoose');

// Ambil URL koneksi MongoDB dari variabel lingkungan
const dbUri = process.env.DB_URI;

// Cek apakah DB_URI ada di .env
if (!dbUri) {
    console.error('DB_URI is not defined in the .env file');
    process.exit(1);  // Hentikan aplikasi jika DB_URI tidak ditemukan
}

const connectToDb = async () => {
    try {
        // Koneksi ke MongoDB menggunakan Mongoose
        await mongoose.connect(dbUri);
        console.log('Database connected successfully');
    } catch (error) {
        console.error('Error connecting to the database:', error);
    }
};

module.exports = connectToDb;
