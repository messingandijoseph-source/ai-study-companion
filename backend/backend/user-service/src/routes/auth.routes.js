const express = require("express");

module.exports = (userService) => {
  const router = express.Router();

  router.post("/login", async (req, res) => {
    try {
      const { email, password } = req.body;
      const result = await userService.login({ email, password });
      res.json(result);
    } catch (err) {
      res.status(401).json({ error: err.message });
    }
  });

  return router;
};
