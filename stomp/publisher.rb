# stomp/publisher.rb
#
# Simple STOMP publisher using the 'stomp' gem.
# Works with local RabbitMQ (STOMP plugin) or Amazon MQ (ActiveMQ broker).

require "stomp"

# 1. Create a STOMP connection
# For Amazon MQ (ActiveMQ), you must set correct username/password.
# For local RabbitMQ, STOMP plugin uses guest/guest by default.
client = Stomp::Client.new(
  login:    "username", # replace with your Amazon MQ ActiveMQ username
  passcode: "passcode", # replace with your Amazon MQ ActiveMQ password
  host:     "endpoint-12345678-1234-1234-1234-123456789012.mq.us-east-2.on.aws", # replace with your Amazon MQ ActiveMQ endpoint
  port:     61614,   # Default STOMP port
  ssl:      true    # Change to true for Amazon MQ TLS endpoints
)

begin
  # 2. Message details
  destination = "/queue/my_queue" # STOMP queue destination
  message     = "Preparing for AWS Solutions Architect Certification!"

  # 3. Publish the message
  client.publish(destination, message)

  puts "[x] Sent: #{message}"

rescue Interrupt
  puts "\n[*] Publisher interrupted."
rescue => e
  puts "[!] Error: #{e.message}"
ensure
  # 4. Close connection cleanly
  client.close
end
