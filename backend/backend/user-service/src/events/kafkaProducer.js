const { Kafka } = require("kafkajs");

const kafka = new Kafka({
  clientId: "user-service",
  brokers: ["localhost:9092"]
});

const producer = kafka.producer();

async function connectProducer() {
  await producer.connect();
  console.log("Kafka Producer connected");
}

async function publishUserCreatedEvent(user) {
  await producer.send({
    topic: "user.created",
    messages: [
      {
        key: user.id,
        value: JSON.stringify({
          eventType: "UserCreated",
          payload: user,
          timestamp: new Date().toISOString()
        })
      }
    ]
  });
}

module.exports = {
  connectProducer,
  publishUserCreatedEvent
};
