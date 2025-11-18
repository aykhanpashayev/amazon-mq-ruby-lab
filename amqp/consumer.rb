# amqp/consumer.rb
#
# Simple AMQP consumer using Bunny.
# Listens on `my_queue` and prints messages as they arrive.

require "bunny"

# 1. Connect to RabbitMQ (local or Amazon MQ)
connection = Bunny.new(
  host:     "endpoint-12345678-1234-1234-1234-123456789012.mq.us-east-2.on.aws", # replace with your Amazon MQ RabbitMQ endpoint
  port:     5672,
  ssl:      true,
  username: "username", # replace with your Amazon MQ RabbitMQ username
  password: "password"  # replace with your Amazon MQ RabbitMQ password
)

begin
  # 2. Start AMQP connection & open channel
  connection.start
  channel = connection.create_channel

  # 3. Declare (or retrieve) the queue
  # durable: true so publishers & consumers match
  queue = channel.queue("my_queue", durable: true)

  puts "[*] Waiting for messages on '#{queue.name}'. Press CTRL+C to exit."

  # 4. Subscribe to the queue
  # block: true → keeps the script running and listening
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts "[x] Received: #{body}"
  end

rescue Interrupt
  puts "\n[*] Shutting down consumer…"
ensure
  # 5. Close connection cleanly even if interrupted
  connection.close if connection&.open?
end
