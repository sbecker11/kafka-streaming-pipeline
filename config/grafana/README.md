# Kafka Grafana Dashboard: Kafka Overview

This folder contains configurations for monitoring Kafka metrics using Grafana. The `dashboards/kafka-overview.json` file defines a basic dashboard for tracking key Kafka performance indicators, leveraging Prometheus as the data source.

config
└── grafana
    ├── README.md                    # Documentation for the entire Grafana setup
    ├── dashboards                   # Folder for Grafana dashboard configurations
    │   └── kafka-overview.json      # JSON file defining the Kafka Overview dashboard
    └── datasources                  # Folder for Grafana data source configurations
        └── prometheus.yml           # YAML configuration for Prometheus as a data source

## Files in This Directory

## Dashboard Panels in kafka-overview.json

### 1. Kafka Broker Messages In
- **Description**: Tracks the rate of incoming messages per second to Kafka brokers.
- **Data Source**: Prometheus query using `rate(kafka_server_brokertopicmetrics_messagesin_total[5m])`.
- **Purpose**: Helps monitor message throughput and detect spikes or dips in incoming message rates, which may indicate issues with producers or overall message flow.
- **Customizations**: 
  - Adjust the Prometheus query or time interval (e.g., change `[5m]` to a different window).
  - Modify the y-axis settings if a different unit or log base is preferred.

### 2. Kafka Broker Bytes In/Out
- **Description**: Tracks the rate of data bytes flowing into and out of Kafka brokers per second.
- **Data Source**: Prometheus queries for `bytesin_total` and `bytesout_total` metrics.
- **Purpose**: Useful for observing network load and identifying potential bottlenecks in Kafka’s data throughput.
- **Customizations**: 
  - Adjust the time interval or threshold settings to better fit your environment.
  - Set alerts based on `bytesin_total` or `bytesout_total` if you want to be notified of sudden data spikes.

## Setting Up the Dashboard

To use the dashboard:
1. Copy the `kafka-overview.json` file to Grafana’s dashboard folder or import it directly via the Grafana UI.
2. Ensure that the Prometheus data source is correctly configured (see `datasources` folder).

## Additional Customization

- **Add New Panels**: Additional panels can be added to monitor other Kafka metrics like consumer lag, partition counts, or error rates.
- **Thresholds and Alerts**: Define custom thresholds for alerts in Grafana to be notified if any metric exceeds expected levels.
- **Data Source Customization**: Ensure that the `Prometheus` data source in Grafana is correctly pointing to your Prometheus instance. Configuration can be found under `../datasources/prometheus.yml`.

## Troubleshooting

- **No Data in Panels**: Verify that Prometheus is scraping Kafka metrics and that Grafana is properly connected to Prometheus.
- **Modifying Prometheus Queries**: If you encounter issues with Prometheus queries, confirm metric names in your Prometheus instance. Some queries may need adjustment depending on the version of Kafka and Prometheus used.

## Additional Resources

- [Grafana Documentation](https://grafana.com/docs/)
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Kafka Monitoring Best Practices](https://www.confluent.io/blog/kafka-monitoring-best-practices/)

---

This README provides a guide to setting up, customizing, and troubleshooting the `kafka-overview.json` dashboard. For any custom metrics or further assistance, please reach out to your DevOps or Kafka management team.
