# amqp/publisher.rb
#
# Simple AMQP publisher using Bunny.
# Works with a local RabbitMQ broker (localhost) or Amazon MQ for RabbitMQ
# if you switch the connection settings.

require "bunny"

# 1. Create a connection to the broker
# For local RabbitMQ (default settings):
connection = Bunny.new(
  host:     "endpoint-12345678-1234-1234-1234-123456789012.mq.us-east-2.on.aws", # replace with your Amazon MQ RabbitMQ endpoint
  port:     5672,
  ssl:      true,
  username: "username", # replace with your Amazon MQ RabbitMQ username
  password: "password"  # replace with your Amazon MQ RabbitMQ password
)

begin
  # 2. Open TCP connection + AMQP handshake
  connection.start

  # 3. Create a channel (a "virtual pipe" over the connection)
  channel = connection.create_channel

  # 4. Declare (or get) a queue named "my_queue"
  # durable: true -> queue survives broker restart
  queue = channel.queue("my_queue", durable: true)

  # 5. Define the message you want to send
  message = "Preparations are ongoing for AWS Solutions Architect Certification!"

  # 6. Publish the message to the default exchange, routed by queue name
  channel.default_exchange.publish(
    message,
    routing_key: queue.name, # send message to "my_queue"
    persistent: true         # mark message as persistent (survives restart if queue is durable)
  )

  # 7. Log to console so you see it ran
  puts "[x] Sent: #{message}"
ensure
  # 8. Always close the connection (even if something went wrong)
  connection.close if connection&.open?
end
