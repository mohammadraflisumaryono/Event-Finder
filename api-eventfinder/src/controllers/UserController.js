const UserServices = require('../services/UserService');

exports.registerUser = async (req, res, next) => {
    try {
        const { name, email, password } = req.body;

        // Periksa apakah data yang diperlukan ada
        if (!name || !email || !password) {
            return res.status(400).json({
                status: 'error',
                data: null,
                message: 'Name, email, and password are required'
            });
        }

        // Panggil service untuk menyimpan user
        const user = await UserServices.registerUser(name, email, password);

        // Kirim response sukses
        res.status(201).json({
            status: 'success',
            data: user,
            message: 'User registered successfully'
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({
            status: 'error',
            data: null,
            message: `Internal Server Error: ${error.message}`
        });
    }
};

exports.loginUser = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        // Periksa apakah data yang diperlukan ada
        if (!email || !password) {
            return res.status(400).json({
                status: 'error',
                data: null,
                message: 'Email and password are required'
            });
        }

        // Panggil service untuk mencari user
        const user = await UserServices.checkUser(email);

        // Periksa apakah user ditemukan
        if (!user) {
            return res.status(404).json({
                status: 'error',
                data: null,
                message: 'User not found'
            });
        }

        // Periksa apakah password benar
        const isMatch = await user.comparePassword(password);
        if (!isMatch) {
            return res.status(400).json({
                status: 'error',
                data: null,
                message: 'Invalid password'
            });
        }

        // Token
        let tokenData = {
            _id: user._id,
            name: user.name,
            email: user.email
        };

        const token = await UserServices.generateToken(tokenData, process.env.JWT_SECRET, '100h');
        // get role 
        const role = user.role;
        const id = user._id;
        // Kirim response sukses
        res.status(200).json({
            status: 'success',
            data: { token, role, id },
            message: 'Login success'
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({
            status: 'error',
            data: null,
            message: `Internal Server Error: ${error.message}`
        });
    }
};
