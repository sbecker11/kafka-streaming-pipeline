

docker compose -f docker/docker-compose.yml exec kafka /usr/bin/kafka-topics \
    --bootstrap-server localhost:9092 \
    --create \
    --topic user-login \
    --partitions 1 \
    --replication-factor 1
