# Watch messages
docker compose -f docker/docker-compose.yml exec kafka /usr/bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic user-login --from-beginning
