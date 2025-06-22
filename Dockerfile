AARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache \
    jq \
    python3 \
 && python3 -m ensurepip \
 && pip3 install --no-cache-dir crcmod paho-mqtt

COPY run.sh monitor.py /

RUN chmod +x /run.sh /monitor.py

CMD ["/run.sh"]

