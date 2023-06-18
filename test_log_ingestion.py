import socket
from datetime import datetime

syslog_message = 'HELLO, THIS IS A TEST MESSAGE!'

with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as sock:
    sock.sendto(syslog_message.encode('utf-8'), ('localhost', 80))
