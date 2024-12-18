const jwt = require('jsonwebtoken');

const verifyToken = (req, res, next) => {

    const token = req.headers['authorization']?.split(' ')[1];
    console.log(token);

    if (!token) {
        return res.status(401).json({ message: 'Token is required for authentication' });
    }

    try {
        // Verifikasi token dan simpan hasil decoding di req.user
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        console.log(decoded);
        req.user = decoded; // Menyimpan decoded token (informasi user) ke req.user
        next(); // Lanjutkan ke route handler berikutnya
    } catch (err) {
        return res.status(403).json({ message: 'Invalid or expired token' });
    }
};

module.exports = verifyToken;
