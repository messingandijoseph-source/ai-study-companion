//the routing layer 
const express = require("express");
const userController = require("../controllers/user.controller");

const router = express.Router();

router.post("/register", (req, res) =>
  userController.register(req, res)
);

module.exports = router;
