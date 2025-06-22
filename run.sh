#!/bin/sh
set -eu

CONFIG_PATH="/data/options.json"

config() {
    [ -f "$CONFIG_PATH" ] && jq -r ".$1 // empty" "$CONFIG_PATH"
}

export DEVICE="${DEVICE:-$(config device)}"
export MQTT_SERVER="${MQTT_SERVER:-$(config mqtt_server)}"
export MQTT_USER="${MQTT_USER:-$(config mqtt_user)}"
export MQTT_PASS="${MQTT_PASS:-$(config mqtt_pass)}"
export MQTT_CLIENT_ID="${MQTT_CLIENT_ID:-$(config mqtt_client_id)}"
export MQTT_TOPIC_PARALLEL="${MQTT_TOPIC_PARALLEL:-$(config mqtt_topic_parallel)}"
export MQTT_TOPIC_SETTINGS="${MQTT_TOPIC_SETTINGS:-$(config mqtt_topic_settings)}"
export MQTT_TOPIC="${MQTT_TOPIC:-$(config mqtt_topic)}"
export SLEEP_QUERY="${SLEEP_QUERY:-$(config sleep_query)}"
export SLEEP_INTERVAL="${SLEEP_INTERVAL:-$(config sleep_interval)}"

echo ""
echo "Running monitor.py with the following settings:"
echo "  DEVICE: $DEVICE"
echo "  MQTT_SERVER: $MQTT_SERVER"
echo "  MQTT_USER: $MQTT_USER"
echo "  MQTT_PASS: ${MQTT_PASS:+***hidden***}"
echo "  MQTT_CLIENT_ID: $MQTT_CLIENT_ID"
echo "  MQTT_TOPIC_PARALLEL: $MQTT_TOPIC_PARALLEL"
echo "  MQTT_TOPIC_SETTINGS: $MQTT_TOPIC_SETTINGS"
echo "  MQTT_TOPIC: $MQTT_TOPIC"
echo "  SLEEP_QUERY: $SLEEP_QUERY"
echo "  SLEEP_INTERVAL: $SLEEP_INTERVAL"
echo ""

missing=0
for var in DEVICE MQTT_SERVER MQTT_TOPIC; do
    if [ -z "$(eval echo \$$var)" ]; then
        echo "ERROR: Required variable '$var' is missing."
        missing=1
    fi
done

if [ "$missing" -eq 1 ]; then
    echo "Exiting due to missing configuration."
    exit 1
fi

exec python3 /monitor.py