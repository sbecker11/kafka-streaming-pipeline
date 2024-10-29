# Kafka Streaming Pipeline

Real-time data processing pipeline using Kafka and Docker.

## Project Structure
```
project_root/
├── docker/              # Docker compose files
├── config/              # Configuration files
│   ├── prometheus/      # Prometheus config and alerts
│   ├── grafana/        # Grafana dashboards and datasources
│   └── kafka/          # Kafka configuration
├── src/                # Source code
│   └── consumer/       # Kafka consumer application
└── data/               # Processed data storage (git-ignored)
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
