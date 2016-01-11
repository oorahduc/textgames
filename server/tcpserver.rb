require './multiclienttcpserver.rb'

srv = MulticlientTCPServer.new( 2000, 15, true )

loop do
    if sock = srv.get_socket
        # a message has arrived, it must be read from sock
        message = sock.gets( "\r\n" ).chomp( "\r\n" )
        # arbitrary examples how to handle incoming messages:
        if message == 'quit'
            raise SystemExit
        elsif message =~ /^puts (.*)$/
            puts "message from #{sock.peeraddr.join(':')}: '#{$1}'"
        elsif message =~ /^echo (.*)$/
      # send something back to the client
            sock.write( "server echo: '#{$1}'\r\n" )
        else
            puts "unexpected message from #{sock.peeraddr}: '#{$1}'"
        end
    else
        sleep 0.01 # free CPU for other jobs, humans won't notice this latency
    end
end
