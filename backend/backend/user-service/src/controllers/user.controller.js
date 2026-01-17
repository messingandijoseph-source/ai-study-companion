//controller pattern for http handling

const userService = require("../services/user.service");

class UserController {
  async register(req, res) {
    try {
      const { email, password } = req.body;
      const user = await userService.registerUser(email, password);
      res.status(201).json(user);
    } catch (err) {
      res.status(400).json({ error: err.message });
    }
  }
}

module.exports = new UserController();
