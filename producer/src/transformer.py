from confluent_kafka import Consumer, Producer
import json
import time
import os
from geoip2.database import Reader
from sklearn.ensemble import IsolationForest  # For anomaly detection

# Configuration for Kafka consumer and producer
bootstrap_servers = os.environ.get('BOOTSTRAP_SERVERS')
group_id = "message_processor"
topic_in = "B"
topic_out = "L'"

# Kafka consumer configuration
consumer_conf = {
    'bootstrap.servers': bootstrap_servers,
    'group.id': group_id,
    'auto.offset.reset': 'earliest'
}

# Kafka producer configuration
producer_conf = {'bootstrap.servers': bootstrap_servers}

def delivery_report(err, msg):
    if err is not None:
        print('Message delivery failed: {}'.format(err))
    else:
        print('Message delivered to {} [{}]'.format(msg.topic(), msg.partition()))

# Initialize consumer and producer
consumer = Consumer(consumer_conf)
producer = Producer(producer_conf)

# GeoIP for enrichment (assuming you have a GeoLite2 database)
geoip_reader = Reader('path/to/GeoLite2-City.mmdb')

# Isolation Forest for anomaly detection
anomaly_detector = IsolationForest(contamination=0.1, random_state=42)  # 10% of data might be outliers

def process_message(msg):
    # Decode the message
    message = json.loads(msg.value().decode('utf-8'))
    
    # GeoIP Enrichment
    if 'ip' in message:
        try:
            response = geoip_reader.city(message['ip'])
            message['geo_location'] = {
                'country': response.country.name,
                'city': response.city.name,
                'latitude': response.location.latitude,
                'longitude': response.location.longitude
            }
        except:
            print(f"Failed to enrich with GeoIP for IP: {message['ip']}")

    # Anomaly Detection (simplified example)
    features = [
        message.get('app_version', '').count('.') if 'app_version' in message else 0,  # Version depth
        message.get('device_type') == 'mobile',  # Mobile vs Non-Mobile
        # Add more features based on your data
    ]
    if anomaly_detector.predict([features]) == -1:  # If anomaly
        message['is_anomaly'] = True

    # Data Transformation (e.g., standardize device type)
    if 'device_type' in message:
        message['device_type'] = message['device_type'].lower()

    # Feature Engineering (example: time since last event)
    # This would require tracking time of last event per user, not shown here

    # Produce transformed message
    producer.produce(topic_out, key=message.get('user_id'), value=json.dumps(message), callback=delivery_report)

# Poll for new messages
try:
    consumer.subscribe([topic_in])
    while True:
        msg = consumer.poll(timeout=1.0)
        if msg is None:
            continue
        if msg.error():
            print(f"Consumer error: {msg.error()}")
            continue
        process_message(msg)
        # Commit the offset if processing was successful
        consumer.commit(asynchronous=False)

except KeyboardInterrupt:
    print("Interrupt received: closing consumer")
finally:
    consumer.close()
    producer.flush()