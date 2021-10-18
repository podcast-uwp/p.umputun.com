FROM alpine:3.12

ARG APP_UID=1000
ENV TERM=xterm-color

COPY updater.sh /srv/updater.sh
COPY entrypoint.sh /srv/entrypoint.sh

RUN apk add --no-cache --update curl openssl openssh-client && \
    mkdir -p /srv /home/app/.ssh && \
    adduser -s /bin/sh -D -u $APP_UID app && \
    delgroup ping && \
    addgroup -g 998 ping && \
    echo "StrictHostKeyChecking=no" > /home/app/.ssh/config && \
    chown -R app:app /srv /home/app && \
    chmod 600 /home/app/.ssh/* && \
    chmod 700 /home/app/.ssh && \
    rm -rf /var/cache/apk/*

USER app
CMD /bin/sh /srv/entrypoint.sh
