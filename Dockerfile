ARG BUILD_FROM=ghcr.io/home-assistant/{arch}-base-debian:bookworm
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        jq \
        python3 \
        python3-pip \
    && pip3 install --break-system-packages --no-cache-dir crcmod paho-mqtt \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


COPY run.sh monitor.py /

RUN chmod +x /run.sh /monitor.py

CMD ["/run.sh"]

