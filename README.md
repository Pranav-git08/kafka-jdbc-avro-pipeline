# Kafka Data Pipeline: MySQL to Postgres (Avro & Schema Registry)

This project demonstrates a production-ready event streaming architecture. It automates data synchronization between a MySQL source and a PostgreSQL sink using Kafka Connect and Confluent Schema Registry.

## 🏗️ Project Architecture
* **Source Database:** MySQL (Running in Docker)
* **Sink Database:** PostgreSQL (Running in Docker)
* **Messaging:** Apache Kafka (Avro Serialization)
* **Schema Management:** Confluent Schema Registry
* **Orchestration:** Docker Compose

## 🚀 How to Run the Project
1. **Start the Infrastructure:**
   ```bash
   docker compose up -d
