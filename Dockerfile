# Add this line after COPY change_ip.sh
COPY restart_browser.sh /restart_browser.sh
RUN chmod +x /restart_browser.sh
