require 'socket'
require 'timeout'
require 'readline'

# connect to server

sock = begin
           Timeout::timeout( 1 ) { TCPSocket.open( 'localhost', 2000 ) }
       rescue StandardError, RuntimeError => ex
           raise "cannot connect to server: #{ex}"
       end

sock.write ("hello\r\n")

while buf = Readline.readline("> ", true)
  p Readline::HISTORY.to_a
  print("-> ", buf, "\n")
  sock.write( "echo #{buf}\r\n" )
  response = begin
                 Timeout::timeout( 1 ) { sock.gets( "\r\n" ).chomp( "\r\n" ) }
             rescue StandardError, RuntimeError => ex
                 raise "no response from server: #{ex}"
             end
  puts "#{response}"
  sleep( 2 )
end

# send sample messages:

# puts "sending one-way message"
# sock.write( "puts This is a one-way message\r\n" )
# sleep( 2 )

# puts "sending a request that should be answered"
# sock.write( "echo This message should be echoed\r\n" )
# response = begin
#                Timeout::timeout( 1 ) { sock.gets( "\r\n" ).chomp( "\r\n" ) }
#            rescue StandardError, RuntimeError => ex
#                raise "no response from server: #{ex}"
#            end
# puts "received response: '#{response}'"
# sleep( 2 )

# puts "sending a goodbye message"
# sock.write( "puts bye\r\n" )
# sock.close
