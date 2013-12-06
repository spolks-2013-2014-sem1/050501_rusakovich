require 'socket'
include Socket::Constants

port = 12700
host = "127.0.0.1"

client  = Socket.new(AF_INET,SOCK_STREAM,0)
client.setsockopt(Socket::SOL_SOCKET,Socket::SO_REUSEADDR,true)
#client.setsockopt(:SOCKET, Socket::SO_OOBINLINE, true)
file = File.open("labs.pdf", "r")

client.connect(Socket.sockaddr_in(port,host ))

number_data =0
len_data_send = 0;
send_count = 0;

begin
while data = file.read(1024)
    _,w, = IO.select(nil,[client],nil,1)
    if !w 
                break
    end
        if send_to = w.shift
            send_to.send(data,0)
                 
             send_count+=1
             len_data_send+=data.length
             if send_count % 20 == 0 
                        number_data+=1
                 send_to.send("R",Socket::MSG_OOB)
                end        
        end
end




ensure 
   client.close
   file.close
   puts "Number data = #{number_data}"
   puts "Send length = #{len_data_send}"
   puts "Send count = #{send_count}"
end 
