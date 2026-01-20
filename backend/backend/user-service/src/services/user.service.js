//service layer pattern (buisness logic)

/*const userRepository = require("../repositories/user.repository");
const crypto = require("crypto");

class UserService {
  async registerUser(email, password) {
    const existing = await userRepository.findByEmail(email);
    if (existing) {
      throw new Error("User already exists");
    }

    const passwordHash = crypto
      .createHash("sha256")
      .update(password)
      .digest("hex");

    return userRepository.createUser(email, passwordHash);
  }
}

module.exports = new UserService(); 


// pattern used is service layer and benefit is
// is clean business logic seperation

class UserService {
  constructor(userRepository) {
    this.userRepository = userRepository;
  }

  async createUser(userData) {
    return this.userRepository.create(userData);
  }

  async getUserById(id) {
    return this.userRepository.findById(id);
  }

  async getAllUsers() {
    return this.userRepository.findAll();
  }

  async deleteUser(id) {
    return this.userRepository.delete(id);
  }
}

module.exports = UserService;



const { publishUserCreatedEvent } = require('../events/kafkaProducer');

class UserService {
  constructor(userRepository) {
    this.userRepository = userRepository;
  }

  async createUser(userData) {
    const user = await this.userRepository.create(userData);

    // Fire-and-forget event
    await publishUserCreatedEvent({
      id: user.id,
      email: user.email,
      createdAt: user.created_at,
    });

    return user;
  }

  async getAllUsers() {
    return this.userRepository.findAll();
  }
}

module.exports = UserService;       */

const bcrypt = require("bcrypt");

class UserService {
  constructor(userRepository, eventBus) {
    this.userRepository = userRepository;
    this.eventBus = eventBus;
  }

  async createUser({ email, password }) {
    // 1. Hash password
    const passwordHash = await bcrypt.hash(password, 10);

    // 2. Persist user
    const user = await this.userRepository.create({
      email,
      passwordHash
    });

    return user;
  }

  async getAllUsers() {
    return this.userRepository.findAll();
  }
}

module.exports = UserService;

