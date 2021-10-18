FROM alpine:3.12

ENV \
    TZ=America/Chicago         \
    TERM=xterm-color           \
    MYUSER=app                 \
    MYUID=1000

COPY updater.sh /srv/updater.sh
COPY entrypoint.sh /srv/entrypoint.sh

RUN \
    apk add --no-cache --update su-exec tzdata curl openssl openssh-client && \
    ln -s /sbin/su-exec /usr/local/bin/gosu && \
    mkdir -p /srv /home/$MYUSER /home/$MYUSER/.ssh && \
    adduser -s /bin/sh -D -u $MYUID $MYUSER && chown -R $MYUSER:$MYUSER /home/$MYUSER && \
    delgroup ping && addgroup -g 998 ping && \
    chown -R $MYUSER:$MYUSER /srv /home/$MYUSER/.ssh/ && \
    echo "StrictHostKeyChecking=no" > /home/$MYUSER/.ssh/config && \
    chmod 600 /home/$MYUSER/.ssh/* && \
    chmod 700 /home/$MYUSER/.ssh && \
    rm -rf /var/cache/apk/*

USER $MYUSER
CMD /bin/sh /srv/entrypoint.sh
