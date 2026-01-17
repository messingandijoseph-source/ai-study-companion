//here a composition route pattern is applied
//where all the dependencies are wired in one place
require("dotenv").config();
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
);
