const router = require('express').Router();
const UserControllers = require('../controllers/UserController');

router.post('/register', UserControllers.registerUser);
router.post('/login', UserControllers.loginUser);


module.exports = router;