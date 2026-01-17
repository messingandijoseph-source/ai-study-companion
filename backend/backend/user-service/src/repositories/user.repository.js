//repository pattern (data access)
const pool = require("../db/pg.client");
const { randomUUID } = require("crypto");

class UserRepository {
  async createUser(email, passwordHash) {
    const id = randomUUID();

    await pool.query(
      `INSERT INTO users (id, email, password_hash)
       VALUES ($1, $2, $3)`,
      [id, email, passwordHash]
    );

    return { id, email };
  }

  async findByEmail(email) {
    const result = await pool.query(
      `SELECT * FROM users WHERE email = $1`,
      [email]
    );
    return result.rows[0];
  }
}

module.exports = new UserRepository();
