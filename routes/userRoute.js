const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const verifyToken = require('../middlewares/authMiddleware');

router.post('/register', userController.registerUser);
router.post('/login', userController.loginUser);
// Protected routes
router.get('/', verifyToken, userController.getUserProfile);
router.put('/', verifyToken, userController.updateUser);

module.exports = router;
