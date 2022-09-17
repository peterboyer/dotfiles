sudo nmcli --terse device wifi list
read -p "ssid: " SSID
sudo nmcli device wifi connect $SSID -a
