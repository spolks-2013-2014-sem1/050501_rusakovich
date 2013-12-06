require 'socket'
include Socket::Constants

port = 12700
host = "127.0.0.1"

server  = Socket.new(AF_INET,SOCK_STREAM,0)
server.setsockopt(Socket::SOL_SOCKET,Socket::SO_REUSEADDR,true)
output = "Output.pdf"
file = File.open(output, "w")
port = 12700
host = "127.0.0.1"
sockaddr = Socket.sockaddr_in(port,host)
server.bind(sockaddr)
server.listen(1)

client, client_addrinfo = server.accept

number_data = 0;	#kol-vo vnepolosnih soedineni
len_data_rec = 0;	#dlina(kolvo bait) soedineni
recieve_count = 0;	#kolvo paketov

begin
        loop do
                 r,_,e = IO.select([client],nil,[client],1)
        if (!r ) 
                        break
                end  
        
        if recv_from = r.shift 
            data = recv_from.recv(1024)
            if data.empty?
                                break
                        end
            file.write(data);
            len_data_rec+=data.length
            recieve_count+=1
                end
        if recv_from =e.shift 
            data = recv_from.recv(1024,Socket::MSG_OOB)
                        number_data+=1 
                          puts len_data_rec
                end 
    end

ensure
    file.close  
    server.close
    client.close
        puts "Number  = #{number_data}"
    puts "Length = #{len_data_rec}"
    puts "Count = #{recieve_count}"
end 
