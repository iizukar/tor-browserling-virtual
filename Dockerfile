FROM python:3.9-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    tor \
    firefox-esr \
    xvfb \
    wget \
    && wget https://github.com/mozilla/geckodriver/releases/download/v0.30.0/geckodriver-v0.30.0-linux64.tar.gz \
    && tar -xzf geckodriver-v0.30.0-linux64.tar.gz -C /usr/local/bin \
    && rm geckodriver-v0.30.0-linux64.tar.gz \
    && apt-get purge -y wget \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Configure Tor
COPY torrc /etc/tor/torrc

# Copy code
COPY app.py .
COPY start.sh .

# Install Python dependencies
RUN pip install selenium stem pyvirtualdisplay

# Set permissions
RUN chmod +x start.sh

CMD ["./start.sh"]
