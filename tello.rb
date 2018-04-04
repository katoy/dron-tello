require "socket"

class Tello
  def initialize
    @udps = UDPSocket.open
    @sockaddr = Socket.pack_sockaddr_in(8889, '192.168.10.1')
    @udps.bind('0.0.0.0', 9000)
  end

  def close
    p '# close Telo'
    @udps.send('land', 0, @sockaddr)
    @udps.close
  end

  def send_command(message)
    p "# send #{message}"
    @udps.send(message, 0, @sockaddr)
    sleep(0.1)
    p "#   response #{@udps.recv(1518)}"
  end
end

tello = Tello.new
tello.send_command('command')
tello.send_command('takeoff')
sleep(5)
tello.send_command('land')
tello.close
