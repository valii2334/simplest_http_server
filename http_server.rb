# 1. Listen for connections
# 2. Parse the request
# 3. Build and send the response

require 'socket'
require 'pry'

require_relative 'http_request'
require_relative 'http_response'

server = TCPServer.new('localhost', 5000)

loop do
  socket = server.accept
  request = socket.readpartial(2048)

  STDERR.puts request

  request = HttpRequest.new(request).request
  response = HttpResponse.new(request).response

  socket.write(response)
  socket.close
end
