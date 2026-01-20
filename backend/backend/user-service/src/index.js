require('dotenv').config();

const express = require('express');
const dbClient = require('./db/pg.client');
const UserRepository = require('./repositories/user.repository');
const UserService = require('./services/user.service');
const userRoutes = require('./routes/user.routes');
const { initKafkaProducer } = require('./events/kafkaProducer');

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
    timestamp: new Date().toISOString(),
  });
});

/**
 * ============================
 * Bootstrap
 * ============================
 */
const PORT = process.env.PORT || 3000;

async function startServer() {
  try {
    await dbClient.connect();
    console.log('✅ PostgreSQL connected');

    // Kafka is OPTIONAL
    initKafkaProducer();

    app.listen(PORT, () => {
      console.log(`🚀 User Service running on port ${PORT}`);
    });
  } catch (error) {
    console.error('❌ Failed to start User Service:', error);
    process.exit(1);
  }
}

startServer();

module.exports = app;
