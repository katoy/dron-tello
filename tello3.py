#
# Tello Python3 Control Demo
#
# http://www.ryzerobotics.com/
#
# 1/1/2018
#

# usage:
#
# $ python tello3.py
#  command
#  takeoff
#  land
#  quit
# %

import threading
import socket

# Create a UDP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('', 9000))
tello_address = ('192.168.10.1', 8889)

def recv():
    while True:
        try:
            data, server = sock.recvfrom(1518)
            print(data.decode(encoding="utf-8"))
        except Exception:
            print('\nExit . . .\n')
            break


print('\n\nTello Python3 Demo.\n')
print('Tello: command takeoff land flip forward back left right\n')
print('               up down cw ccw speed speed?\n')
print('end -- quit demo.\n')

# recvThread create
recvThread = threading.Thread(target=recv)
recvThread.start()

while True:
    try:
        msg = input('')
        if not msg:
            break

        if 'end' in msg:
            print('...')
            sock.close()
            break

        # Send data
        msg = msg.encode(encoding="utf-8")
        sent = sock.sendto(msg, tello_address)
    except KeyboardInterrupt:
        print('\n . . .\n')
        sock.close()
        break
