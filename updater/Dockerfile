FROM alpine:3.12

ENV \
    TZ=America/Chicago         \
    TERM=xterm-color           \
    MYUSER=app                 \
    MYUID=1000

COPY updater.sh /srv/updater.sh
COPY entrypoint.sh /srv/entrypoint.sh

RUN \
    apk add --no-cache --update su-exec tzdata curl openssl && \
    ln -s /sbin/su-exec /usr/local/bin/gosu && \
    mkdir -p /srv /home/$MYUSER /home/app/.ssh && \
    adduser -s /bin/sh -D -u $MYUID $MYUSER && chown -R $MYUSER:$MYUSER /home/$MYUSER && \
    delgroup ping && addgroup -g 998 ping && \
    chown -R $MYUSER:$MYUSER /srv && \
    apk add --update openssh-client && \
    echo "StrictHostKeyChecking=no" > /home/app/.ssh/config && \
    chown -R app:app /home/app/.ssh/ && \
    chmod 600 /home/app/.ssh/* && \
    chmod 700 /home/app/.ssh &&
    rm -rf /var/cache/apk/*

USER app
CMD /bin/sh /srv/entrypoint.sh
