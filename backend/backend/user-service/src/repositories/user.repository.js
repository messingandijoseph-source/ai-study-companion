//repository pattern (data access)
/*const pool = require("../db/pg.client");
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

module.exports = new UserRepository();*/

//patern used is the repository having as benefit that DB
//can change without touching logic
/*class UserRepository {
  constructor(dbClient) {
    this.db = dbClient;
  }

  async create(user) {
    const { name, email } = user;
    const result = await this.db.query(
      'INSERT INTO users(name, email) VALUES($1, $2) RETURNING *',
      [name, email]
    );
    return result.rows[0];
  }

  async findById(id) {
    const result = await this.db.query(
      'SELECT * FROM users WHERE id = $1',
      [id]
    );
    return result.rows[0];
  }

  async findAll() {
    const result = await this.db.query('SELECT * FROM users');
    return result.rows;
  }

  async delete(id) {
    await this.db.query('DELETE FROM users WHERE id = $1', [id]);
    return true;
  }
}

module.exports = UserRepository;
*/


const { v4: uuidv4 } = require("uuid");

class UserRepository {
  constructor(db) {
    this.db = db;
  }

  async create({ email, passwordHash }) {
    const query = `
      INSERT INTO users (id, email, password_hash)
      VALUES ($1, $2, $3)
      RETURNING id, email, created_at;
    `;

    const { rows } = await this.db.query(query, [
      uuidv4(),
      email,
      passwordHash
    ]);

    return rows[0];
  }

  async findByEmail(email) {
    const { rows } = await this.db.query(
      "SELECT * FROM users WHERE email = $1",
      [email]
    );
    return rows[0];
  }

  async findAll() {
    const { rows } = await this.db.query(
      "SELECT id, email, created_at FROM users"
    );
    return rows;
  }
}

module.exports = UserRepository;
