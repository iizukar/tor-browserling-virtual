FROM alpine:latest

# Enable community repo for firefox-esr
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# Install dependencies
RUN apk add --no-cache \
    xvfb \
    fluxbox \
    firefox-esr \
    x11vnc \
    git \
    tor \
    bash \
    sudo \
    procps \
    tini \
    netcat-openbsd

# Clone noVNC and clean up
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC \
    && git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify \
    && rm -rf /opt/noVNC/.git \
    && apk del git

# Configure Tor with hashed password
RUN tor --hash-password mypassword | tail -n1 > /tmp/tor-pass && \
    echo "ControlPort 9051" >> /etc/tor/torrc && \
    echo "HashedControlPassword $(cat /tmp/tor-pass)" >> /etc/tor/torrc && \
    rm /tmp/tor-pass

# Configure Firefox to use Tor proxy
RUN mkdir -p /etc/firefox-esr/pref/ && \
    echo 'user_pref("network.proxy.type", 1); \
    user_pref("network.proxy.socks", "127.0.0.1"); \
    user_pref("network.proxy.socks_port", 9050); \
    user_pref("network.proxy.socks_remote_dns", true); \
    user_pref("network.dns.blockDotOnion", false);' > /etc/firefox-esr/pref/user.js

# Copy scripts
COPY start.sh /start.sh
COPY renew_identity.sh /renew_identity.sh
RUN chmod +x /start.sh /renew_identity.sh

EXPOSE 8080

ENTRYPOINT ["tini", "--"]
CMD ["/start.sh"]
