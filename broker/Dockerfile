FROM eclipse-mosquitto:latest

COPY broker/config/mosquitto.conf /mosquitto/config/mosquitto.conf
COPY broker/config/passwd /mosquitto/config/passwd

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
