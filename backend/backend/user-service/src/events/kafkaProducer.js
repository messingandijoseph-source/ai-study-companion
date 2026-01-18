const { Kafka } = require('kafkajs');

let producer;

async function initKafkaProducer() {
  if (producer) return producer;

  const kafka = new Kafka({
    clientId: 'user-service',
    brokers: [process.env.KAFKA_BROKER || 'localhost:9092'],
  });

  producer = kafka.producer();
  await producer.connect();

  console.log('✅ Kafka producer connected');
  return producer;
}

module.exports = {
  initKafkaProducer,
};
