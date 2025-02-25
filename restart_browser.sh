#!/bin/bash

while true; do
  # Kill existing Firefox process
  pkill firefox
  
  # Start Firefox with target URL
  firefox \
    --new-instance \
    --no-remote \
    --profile /tmp/firefox-profile \
    --setpref network.proxy.type=1 \
    --setpref network.proxy.socks=127.0.0.1 \
    --setpref network.proxy.socks_port=9050 \
    --setpref network.proxy.socks_remote_dns=true \
    http://testingimp.great-site.net &
  
  # Wait 5 minutes before restart
  sleep 300
done
