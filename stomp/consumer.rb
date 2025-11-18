# stomp/consumer.rb
#
# Simple STOMP consumer using the 'stomp' gem.
# Subscribes to /queue/my_queue and prints every message as it arrives.

require "stomp"

# 1. Create a STOMP connection
client = Stomp::Client.new(
  login:    "username", # replace with your Amazon MQ ActiveMQ username
  passcode: "passcode", # replace with your Amazon MQ ActiveMQ password
  host:     "endpoint-12345678-1234-1234-1234-123456789012.mq.us-east-2.on.aws", # replace with your Amazon MQ ActiveMQ endpoint
  port:     61614,   # Default STOMP port
  ssl:      true    # Change to true for Amazon MQ TLS endpoints
)

begin
  destination = "/queue/my_queue"

  puts "[*] Subscribed to #{destination}. Waiting for messages... (CTRL+C to exit)"

  # 2. Subscribe to STOMP destination
  # The block receives 'msg' objects with body, headers, etc.
  client.subscribe(destination, ack: "auto") do |msg|
    puts "[x] Received: #{msg.body}"
  end

  # 3. Keep the thread alive so the consumer keeps running
  loop do
    sleep 1
  end

rescue Interrupt
  puts "\n[*] Consumer interrupted. Closing connection..."
rescue => e
  puts "[!] Error: #{e.message}"
ensure
  # 4. Close connection cleanly
  client.close
end
