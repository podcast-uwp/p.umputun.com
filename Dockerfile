FROM umputun/baseimage:app-v1.19.2

ARG TARGETARCH
ENV HUGO_VER=0.145.0

RUN apk add --no-cache libc6-compat libstdc++ && \
    ARCH=$([ "$TARGETARCH" = "arm64" ] && echo "arm64" || echo "amd64") && \
    wget -q "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VER}/hugo_extended_${HUGO_VER}_linux-${ARCH}.tar.gz" -O /tmp/hugo.tar.gz && \
    cd /tmp && tar -zxf hugo.tar.gz && cp -fv /tmp/hugo /bin/hugo && rm -f /tmp/hugo.tar.gz

COPY exec.sh /srv/exec.sh
RUN chmod +x /srv/exec.sh

CMD ["/srv/exec.sh"]
