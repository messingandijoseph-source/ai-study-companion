const { Kafka } = require('kafkajs');

let producer = null;

async function initKafkaProducer() {
  try {
    const kafka = new Kafka({
      clientId: 'user-service',
      brokers: [process.env.KAFKA_BROKER || 'localhost:9092'],
    });

    producer = kafka.producer();
    await producer.connect();

    console.log('✅ Kafka producer connected');
  } catch (error) {
    console.warn('⚠️ Kafka not available, continuing without it');
    producer = null;
  }
}

async function publishUserCreatedEvent(payload) {
  if (!producer) return;

  await producer.send({
    topic: 'user.created',
    messages: [{ value: JSON.stringify(payload) }],
  });
}

module.exports = {
  initKafkaProducer,
  publishUserCreatedEvent,
};
