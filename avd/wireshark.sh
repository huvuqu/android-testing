# tcpdump -i wlan0 -s0 -w - | nc -l -p 11111
adb shell tcpdump -i eth0 -s0 -w - | nc -l 11111
adb forward tcp:11111 tcp:11111
nc localhost 11111 | wireshark -k -S -i -
