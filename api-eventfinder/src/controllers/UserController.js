// controllers/UserController.js
const UserServices = require('../services/UserService');

exports.registerUser = async (req, res, next) => {
    try {
        const { name, email, password } = req.body;

        // Periksa apakah data yang diperlukan ada
        if (!name || !email || !password) {
            return res.status(400).json({
                message: 'Name, email, and password are required'
            });
        }

        // Panggil service untuk menyimpan user
        const user = await UserServices.registerUser(name, email, password);

        // Kirim response sukses
        res.status(201).json({
            message: 'User registered successfully',
            user: user
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal Server Error', error: error.message });
    }
};


exports.loginUser = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        // Periksa apakah data yang diperlukan ada
        if (!email || !password) {
            return res.status(400).json({
                message: 'Email and password are required'
            });
        }

        // Panggil service untuk mencari user
        const user = await UserServices.checkUser(email);

        // Periksa apakah user ditemukan
        if (!user) {
            return res.status(404).json({
                message: 'User not found'
            });
        }

        // Periksa apakah password benar
        const isMatch = await user.comparePassword(password);
        if (!isMatch) {
            return res.status(400).json({
                message: 'Invalid password'
            });
        }

        //token
        let tokenData = {
            _id: user._id,
            name: user.name,
            email: user.email
        }

        const token = await UserServices.generateToken(tokenData, process.env.JWT_SECRET, '1h');

        // Kirim response sukses
        res.status(200).json({
            message: 'Login success',
            token: token
        });


    } catch (error) {
    }
};