//here a composition route pattern is applied
//where all the dependencies are wired in one place
/*require("dotenv").config();
const express = require("express");
const cors = require("cors");
const userRoutes = require("./routes/user.routes");

const app = express();
//wiring kafka into user service
const { connectProducer, publishUserCreatedEvent } = require("./events/kafkaProducer");

connectProducer();


app.use(cors());
app.use(express.json());

app.use("/api/users", userRoutes);

app.get("/health", (_, res) => {
  res.json({ status: "UP", service: "user-service" });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () =>
  console.log(`User Service running on port ${PORT}`)
);   */


/*
 * User Service – Application Entry Point
 * -------------------------------------
 * Responsibilities:
 * - Bootstrap Express server
 * - Initialize database
 * - Initialize Kafka producer (non-blocking)
 * - Wire dependencies (DI)
 * - Expose health endpoint
 */

require('dotenv').config();

const express = require('express');
const dbClient = require('./db/pg.client');
const UserRepository = require('./repositories/user.repository');
const UserService = require('./services/user.service');
const userRoutes = require('./routes/user.routes');
const { initKafkaProducer } = require('./events/kafkaProducer');
const producer = require('./events/kafkaProducer');

const app = express();
app.use(express.json());

/**
 * ============================
 * Dependency Injection
 * ============================
 */
const userRepository = new UserRepository(dbClient);
const userService = new UserService(userRepository);

/**
 * ============================
 * Routes
 * ============================
 */
app.use('/api/users', userRoutes(userService));

app.get('/health', (_, res) => {
  res.status(200).json({
    status: 'UP',
    service: 'user-service',
    timestamp: new Date().toISOString()
  });
});

/**
 * ============================
 * Server Bootstrap
 * ============================
 */
const PORT = process.env.PORT || 3000;

async function startServer() {
  try {
    // 1. Ensure DB connectivity
    await dbClient.connect();
    console.log('✅ PostgreSQL connected');


    // 3. Start HTTP server
    app.listen(PORT, () => {
      console.log(`🚀 User Service running on port ${PORT}`);
    });

  } catch (error) {
    console.error('❌ Failed to start User Service:', error);
    process.exit(1);
  }


 


    // 2. Initialize Kafka (non-blocking)
    /*initKafkaProducer()
      .then(() => console.log('✅ Kafka producer ready'))
      .catch(err =>
            console.error(
          '⚠️ Kafka unavailable (service running without events):',
          err.message
        )
      );
    */
  
  let kafkaReady = false;

  async function initKafkaProducer() {
    try {
      await producer.connect();
      kafkaReady = true;
      console.log("✅ Kafka producer connected");
    } catch (error) {
      kafkaReady = false;
      console.error(
        "⚠️ Kafka not available, continuing without events:",
        error.message
      );
    }
  }

  function isKafkaReady() {
    return kafkaReady;
  }

  module.exports = {
    initKafkaProducer,
    isKafkaReady,
    producer
  };



   
  
}
startServer();

module.exports = app;


