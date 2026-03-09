#!/bin/bash

# 1. Create Source Connector (MySQL -> Kafka)
curl -X POST http://localhost:8083/connectors -H "Content-Type: application/json" -d '{
  "name": "source-sales-pipeline",
  "config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
    "connection.url": "jdbc:mysql://mysql:3306/source_db",
    "connection.user": "connect_user",
    "connection.password": "connect_password",
    "table.whitelist": "sales",
    "mode": "incrementing",
    "incrementing.column.name": "sale_id",
    "topic.prefix": "delta_",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://schema-registry:8081",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.schema.registry.url": "http://schema-registry:8081"
  }
}'

# 2. Create Sink Connector (Kafka -> Postgres)
curl -X POST http://localhost:8083/connectors -H "Content-Type: application/json" -d '{
  "name": "sink-sales-delivery",
  "config": {
    "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
    "topics": "delta_sales",
    "connection.url": "jdbc:postgresql://postgres:5432/sink_db",
    "connection.user": "connect_user",
    "connection.password": "connect_password",
    "auto.create": "true",
    "insert.mode": "insert",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://schema-registry:8081",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.schema.registry.url": "http://schema-registry:8081"
  }
}'
