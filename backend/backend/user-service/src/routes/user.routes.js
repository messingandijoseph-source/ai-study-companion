//the routing layer 
/*const express = require("express");
const userController = require("../controllers/user.controller");

const router = express.Router();

router.post("/register", (req, res) =>
  userController.register(req, res)
);

module.exports = router;  */


const express = require('express');

module.exports = (userService) => {
  const router = express.Router();

  router.post('/', async (req, res) => {
    const user = await userService.createUser(req.body);
    res.status(201).json(user);
  });

  router.get('/', async (req, res) => {
    const users = await userService.getAllUsers();
    res.json(users);
  });

  router.get('/:id', async (req, res) => {
    const user = await userService.getUserById(req.params.id);
    res.json(user);
  });

  router.delete('/:id', async (req, res) => {
    await userService.deleteUser(req.params.id);
    res.status(204).end();
  });

  return router;
};

