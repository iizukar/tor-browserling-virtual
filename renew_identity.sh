#!/bin/sh
echo -e 'AUTHENTICATE "mypassword"\r\nSIGNAL NEWNYM\r\nQUIT' | nc 127.0.0.1 9051
sleep 10
