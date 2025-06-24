ARG BUILD_FROM
FROM $BUILD_FROM

#FROM ghcr.io/home-assistant/{arch}-base-alpine:3.18

ENV LANG C.UTF-8

RUN apk add --no-cache jq python3 py3-pip \
    && pip3 install --no-cache-dir crcmod paho-mqtt


COPY run.sh monitor.py /

RUN chmod +x /run.sh /monitor.py

CMD ["/run.sh"]

