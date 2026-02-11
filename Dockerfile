FROM umputun/baseimage:app-v1.4.1

ENV HUGO_VER=0.145.0
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VER}/hugo_${HUGO_VER}_linux-amd64.tar.gz /tmp/hugo.tar.gz
RUN \
    cd /tmp && tar -zxf hugo.tar.gz && ls -la && \
    cp -fv /tmp/hugo /bin/hugo

COPY exec.sh /srv/exec.sh
RUN chmod +x /srv/exec.sh

CMD ["/srv/exec.sh"]