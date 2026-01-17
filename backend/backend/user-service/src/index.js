const express = require("express");
const routes = require("./routes");
require("dotenv").config();

const app = express();
app.use(express.json());
app.use("/api/users", routes);

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`User Service running on port ${PORT}`);
});
