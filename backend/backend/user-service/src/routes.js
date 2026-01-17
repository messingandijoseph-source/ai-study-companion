const express = require("express");
const router = express.Router();
const pool = require("./db");

// Health check
router.get("/health", (req, res) => {
  res.json({ status: "User Service running" });
});

// Register user (simple version)
router.post("/register", async (req, res) => {
  const { email, password } = req.body;

  try {
    const result = await pool.query(
      "INSERT INTO users(email, password) VALUES($1, $2) RETURNING id",
      [email, password]
    );
    res.status(201).json({ userId: result.rows[0].id });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
