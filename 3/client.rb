require 'socket'
include Socket::Constants

port = 12700
host = "127.0.0.1"

client  = Socket.new(AF_INET,SOCK_STREAM,0)
client.setsockopt(Socket::SOL_SOCKET,Socket::SO_REUSEADDR,true)
file = File.open("labs.pdf", "r")


client.connect(Socket.sockaddr_in(port,host ))

begin
while data = file.read(1024)
    client.write(data)
    end

rescue 
   puts "error"
   raise
ensure 
   client.close
   file.close
end 
