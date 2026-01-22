# app/event_consumer.py

def emit_event(event_type: str, payload: dict):
    print(f"[EVENT] {event_type} -> {payload}")

def start_consumer():
    print("[INFO] Event consumer started (Kafka-ready)")
