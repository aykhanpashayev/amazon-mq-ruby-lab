# Amazon MQ Messaging Lab (Ruby)

This repo is a hands-on lab where I explored three different messaging protocols on Amazon MQ using simple Ruby clients:

- AMQP (RabbitMQ engine)
- MQTT (ActiveMQ engine)
- STOMP (ActiveMQ engine)

Each protocol lives in its own folder with its own Gemfile, publisher, and consumer.
Everything is intentionally minimal, easy to read, and focused on learning how real cloud messaging works.

## 📌 Why I Built This

I’m strengthening my cloud and distributed-systems foundation.

Messaging is a core part of modern architectures, and I wanted to understand:

- How different protocols behave
- How Amazon MQ exposes them
- How TLS-based connections work
- How publishing/consuming differs across RabbitMQ vs ActiveMQ engines

This project gave me practical experience working with three protocols, two broker engines, and AWS endpoints.

## 📂 Project Structure

Each folder is its own tiny project with its own dependencies:

```
amazon-mq-ruby-lab/
│
├── amqp/
│   ├── Gemfile
│   ├── publisher.rb
│   └── consumer.rb
│
├── mqtt/
│   ├── Gemfile
│   ├── publisher.rb
│   └── consumer.rb
│
├── stomp/
│   ├── Gemfile
│   ├── publisher.rb
│   └── consumer.rb
│
└── README.md
```

AMQP scripts connect to an Amazon MQ RabbitMQ broker.

MQTT and STOMP scripts connect to an Amazon MQ ActiveMQ broker.

## 📊 Diagram: Protocol Overview
```
   +-------------+         +-----------------------+
   |  AMQP       | ----->  Queue-based messaging   |
   |  (RabbitMQ) |         Routing keys / Exchanges |
   +-------------+         Durable queues          

   +-------------+         +-----------------------+
   |  MQTT       | ----->  Topic-based publish/     |
   | (ActiveMQ)  |         subscribe (IoT-style)    |
   +-------------+         Lightweight messaging    

   +-------------+         +-----------------------+
   |  STOMP      | ----->  Simple text frames,      |
   | (ActiveMQ)  |         easy debugging,          |
   +-------------+         good for scripting       
```
Key takeaway:

- RabbitMQ engine → AMQP only
- ActiveMQ engine → MQTT + STOMP

## 🔧 Dependencies

Each folder has its own Gemfile:

AMQP (RabbitMQ)
```
gem "bunny"
gem "pry"
```

MQTT (ActiveMQ)
```
gem "mqtt"
gem "pry"
```
STOMP (ActiveMQ)
```
gem "stomp"
gem "pry"
```

## 🚀 How to Run Each Protocol

Before running anything, update the connection settings in each script with your broker’s:
```
hostname
username/password
correct port
ssl: true for AWS
```

1️⃣ AMQP (RabbitMQ Broker)
```
cd amqp
bundle install
bundle exec ruby publisher.rb
bundle exec ruby consumer.rb
```

Default Amazon MQ ports:
AMQP TLS → 5671

2️⃣ MQTT (ActiveMQ Broker)
```
cd mqtt
bundle install
bundle exec ruby publisher.rb
bundle exec ruby consumer.rb
```

Default Amazon MQ ports:
MQTT TLS → 8883

3️⃣ STOMP (ActiveMQ Broker)
```
cd stomp
bundle install
bundle exec ruby publisher.rb
bundle exec ruby consumer.rb
```

Default Amazon MQ ports:
STOMP TLS → 61614

## 🔍 What Each Script Does

Publisher

- Connects to Amazon MQ
- Opens a secure TLS session
- Publishes a message to a topic or queue
- Logs a simple confirmation

Consumer

- Connects using the same protocol
- Subscribes to a queue/topic
- Prints incoming messages in real time
- Handles CTRL+C clean shutdown
```
Each script includes short comments—not overwhelming, just enough to explain what’s happening
```

💡 What I Learned

- RabbitMQ on Amazon MQ supports only AMQP, even though local RabbitMQ can support MQTT/STOMP plugins.
- ActiveMQ supports MQTT and STOMP, each with its own TLS port.
- Different messaging protocols have very different communication styles:
  - AMQP → queue-based, durable, structured
  - MQTT → lightweight pub/sub, IoT-style
  - STOMP → simple text frames, very easy to script

- Working with Amazon MQ requires truly understanding:
   - TLS configuration
   - Connection URIs
   - Engine differences
   - Protocol ports

This lab helped me see how production messaging systems behave behind the scenes.

## 🙌 Feel Free to Explore

The repo is intentionally simple — every script is short, readable, and easy to extend.
If you're experimenting with Amazon MQ or cloud messaging in general, you can use this project as a clean starter template.
