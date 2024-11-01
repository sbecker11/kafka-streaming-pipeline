# Kafka Streaming Pipeline

Real-time data processing pipeline using Kafka and Docker.

## Project Structure
```
kafka-streaming-pipeline/
├── docker/
│   ├── docker-compose.yml
│   ├── docker-compose.kafka.yml
│   ├── docker-compose.monitor.yml
│   └── docker-compose.app.yml
├── config/              # Configuration files
│   ├── prometheus/      # Prometheus config and alerts
│   ├── grafana/        # Grafana dashboards and datasources
│   └── kafka/          # Kafka configuration
│       └── server.properties  # Kafka server properties
├── src/                # Source code
│   └── consumer/       # Kafka consumer application
└── data/               # Processed data storage (git-ignored)
└── scripts
    ├── dev
    │   └── rebuild-consumer.sh
    ├── kafka-commands.sh
    ├── start
    │   ├── start-kafka.sh
    │   └── start-producer.sh
    ├── stop
    │   └── stop-kafka.sh
    └── utils
        ├── check-port.sh
        ├── check-ports.sh
        ├── create-topic-if-needed.sh
        ├── describe-topic.sh
        ├── full-cleanup.sh
        ├── full-precheck.sh
        ├── full-rebuild.sh
        ├── kafka-exec.sh
        ├── kafka-log.sh
        ├── kafka-ping.sh
        ├── kafka-status.sh
        ├── list-topics.sh
        ├── producer_healthcheck.sh
        ├── start-everything.sh
        ├── wait-for-kafka.sh
        ├── wait-for-zookeeper.sh
        └── watch-messages.sh

## Prerequisites
- Docker
- Docker Compose
- Git

## Setup
1. Clone the repository:
```bash
git clone <your-repo-url>
cd kafka-streaming-pipeline
```

2. Create and configure `.env` file:
```bash
cp .env.example .env
# Edit .env with your settings
```

Problems setting up Kafka Listeners
This article was very useful.
https://rmoff.net/2018/08/02/kafka-listeners-explained/


3. Start the services:
```bash
# Start everything
docker-compose -f docker/docker-compose.yml \
               -f docker/docker-compose.kafka.yml \
               -f docker/docker-compose.monitor.yml \
               -f docker/docker-compose.app.yml up -d

# Or start specific components:
docker-compose -f docker/docker-compose.yml \
               -f docker/docker-compose.kafka.yml up -d  # Kafka only
```

## Monitoring
- Grafana: http://localhost:3000 (default: admin/admin)
- Prometheus: http://localhost:9090
- Kafka Manager: http://localhost:9000

## Development
[Add development instructions here]

## Testing
[Add testing instructions here]

## Contributing
[Add contributing guidelines here]

## License
[Add license information here]



Benefits of this structure:
* Separation of Concerns:
    Main configuration is separate from alert rules
    Alerts are grouped by component/function
    Easier to manage and update specific alert groups
* Maintainability:
    Can modify alert rules without touching main config
    Easier to version control changes
    Can enable/disable entire alert groups by adding/removing from rule_files
* Organization:
    Clear categorization of alerts
    Easier to find and update specific alerts
    Better readability
* Scalability:
    Easy to add new alert categories
    Can add recording rules separately
    Can manage rules for different environments




