# mqtt/publisher.rb
#
# Simple MQTT publisher using the ruby-mqtt gem.
# Works with a local MQTT broker or Amazon MQ (MQTT protocol enabled).

require "mqtt"

# 1. Connect to the MQTT broker
# For local: localhost, default port 1883.
# For Amazon MQ: replace with your broker URL + credentials.
client = MQTT::Client.connect(
  host: "endpoint-12345678-1234-1234-1234-123456789012.mq.us-east-2.on.aws",
  port: 8883,
  ssl: true,
  username: "username",   # remove/change for your MQ broker
  password: "passcode" # remove/change for your MQ broker
)

begin
  # 2. Message content
  message = "Hello MQTT! I'll be AWS Solutions Architect Certified soon!"

  # 3. Publish the message to the topic "my_topic"
  client.publish("my_topic", message)

  puts "[x] Sent: #{message}"

rescue Interrupt
  puts "\n[*] Publisher interrupted."
ensure
  # 4. Clean disconnect so the broker closes the session properly
  client.disconnect
end
