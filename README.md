# Kafka Streaming Pipeline

Real-time data processing pipeline using Kafka and Docker.

## Project Structure
```

project_root/
├── docker/
│   ├── docker-compose.yml
│   ├── docker-compose.kafka.yml
│   ├── docker-compose.monitor.yml
│   └── docker-compose.app.yml
├── config/              # Configuration files
│   ├── prometheus/      # Prometheus config and alerts
│   ├── grafana/        # Grafana dashboards and datasources
│   └── kafka/          # Kafka configuration
├── src/                # Source code
│   └── consumer/       # Kafka consumer application
└── data/               # Processed data storage (git-ignored)
│ 
├── scripts/
│   ├── start/
│   │   ├── start-all.sh
│   │   ├── start-kafka.sh
│   │   ├── start-monitoring.sh
│   │   └── start-consumer.sh
│   ├── stop/
│   │   ├── stop-all.sh
│   │   ├── stop-kafka.sh
│   │   ├── stop-monitoring.sh
│   │   └── stop-consumer.sh
│   ├── utils/
│   │   ├── check-kafka.sh
│   │   ├── check-monitoring.sh
│   │   └── cleanup.sh
│   └── dev/
│       ├── rebuild-consumer.sh
│       └── reload-config.sh
```

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




