# mqtt/consumer.rb
#
# Simple MQTT consumer using the ruby-mqtt gem.
# Subscribes to "my_topic" and prints incoming messages.

require "mqtt"

# 1. Connect to the MQTT broker (local or Amazon MQ)
client = MQTT::Client.connect(
  host: "endpoint-12345678-1234-1234-1234-123456789012.mq.us-east-2.on.aws",
  port: 8883,
  ssl: true,
  username: "username",   # remove/change for your MQ broker
  password: "passcode" # remove/change for your MQ broker
)

begin
  puts "[*] Subscribed to 'my_topic'. Waiting for messages... (CTRL+C to exit)"

  # 2. Subscribe and block until messages arrive
  # client.get(topic) -> yields [topic, payload]
  client.get("my_topic") do |topic, message|
    puts "[x] Received on #{topic}: #{message}"
  end

rescue Interrupt
  puts "\n[*] Consumer interrupted. Closing connection..."
ensure
  # 3. Clean disconnect even if CTRL+C happens
  client.disconnect
end
