require 'socket'

include Socket::Constants

port = 12700
host = "127.0.0.1"

output = "Output.pdf" 

server  = Socket.new(AF_INET,SOCK_STREAM,0)
server.setsockopt(Socket::SOL_SOCKET,Socket::SO_REUSEADDR,true)
file = File.open(output, "w")



sockaddr = Socket.sockaddr_in(port,host)
server.bind(sockaddr)
server.listen(1)

client, client_addrinfo = server.accept

begin
        while  data = client.read(1024)
           file.write(data)       
    end

rescue
        puts "Error"
    raise

ensure
          file.close  
    server.close
    client.close
end
 
