require "socket"

class Tello
  def initialize
    @udps = UDPSocket.open
    @sockaddr = Socket.pack_sockaddr_in(8889, '192.168.10.1')
    @udps.bind('0.0.0.0', 9000)

    @th = Thread.start do
      loop do
        begin
          sleep(0.1)
          puts "#   response #{@udps.recv(1518)}"
        rescue StandardError => e
          puts "#   error #{e.message}"
        end
      end
    end
  end

  def close
    puts '# close Telo'
    @udps.send('land', 0, @sockaddr)
    Thread.kill(@th)
    @udps.close
  end

  def send_command(message)
    puts "# send #{message}"
    @udps.send(message, 0, @sockaddr)
  end
end

tello = Tello.new
tello.send_command('command')
tello.send_command('takeoff')
sleep(5)
tello.send_command('land')
tello.close
