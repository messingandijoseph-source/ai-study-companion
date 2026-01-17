//service layer pattern (buisness logic)

const userRepository = require("../repositories/user.repository");
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
