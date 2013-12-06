 
require 'socket'
include Socket::Constants

hostname = '127.0.0.1' 
port = 12700

socket = Socket.new(AF_INET, SOCK_STREAM, 0)
sockaddr = Socket.sockaddr_in(port, hostname)

socket.setsockopt(Socket::SOL_SOCKET,Socket::SO_REUSEADDR, true)
socket.bind(sockaddr)
puts "Server is running ^_^"
socket.listen(1)

begin
  client_fd, client_addrinfo = socket.sysaccept
rescue SystemExit, Interrupt => e
  puts "\nServer closed1"
  socket.close
  exit
end

client_socket = Socket.for_fd(client_fd)

loop do
  begin
    command = client_socket.gets
    if command.nil? || command.chomp == "quit"
      puts "Server closed2"
      client_socket.close
      socket.close
      break
    else   
      puts command.chomp
      client_socket.puts command
    end
  
  rescue SystemExit, Interrupt => e
    puts "\nServer closed3 "
    client_socket.close
    socket.close
    exit
  end
end