#!/bin/bash

# Start Tor
tor &
sleep 10

# Start Xvfb
Xvfb :99 -screen 0 1024x768x16 -ac -nolisten tcp &
export DISPLAY=:99

# Start fluxbox
fluxbox &

# Start Firefox with testing.com
firefox-esr https://testing.com &

# Start x11vnc
x11vnc -display :99 -forever -noxdamage -repeat -shared -nopw -q &

# Start noVNC
/opt/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 8080 &

# Renew identity and restart Firefox every 5 minutes
while true; do
    sleep 300
    /renew_identity.sh
    pkill firefox-esr
    firefox-esr https://testing.com &
done
