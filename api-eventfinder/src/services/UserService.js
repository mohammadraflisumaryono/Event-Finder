const UserModel = require('../models/UserModel');
const jwt = require('jsonwebtoken');


class UserServices {
    static async registerUser(name, email, password, role = "organizer") {
        try {
            const user = new UserModel({ name, email, password, role });
            await user.save();
            return user;
        } catch (error) {
            throw new Error(error);
        }
    }



    static async checkUser(email) {
        try {
            const user = await UserModel.findOne({ email });
            return user;
        }
        catch (error) {
            throw new Error(error);
        }
    }

    static async generateToken(tokenData, secretKey, expiresIn) {
        try {
            return jwt.sign(tokenData, secretKey, { expiresIn });
        } catch (error) {
            throw new Error(error);
        }
    }
}

module.exports = UserServices;
