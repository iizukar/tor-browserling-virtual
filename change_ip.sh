#!/bin/bash

while true; do
  sleep 180
  echo -e "AUTHENTICATE \"$TOR_CONTROL_PASS\"\r\nSIGNAL NEWNYM\r\nQUIT\r\n" | nc 127.0.0.1 9051
  
  # Refresh browser with new IP
  pkill firefox
done
