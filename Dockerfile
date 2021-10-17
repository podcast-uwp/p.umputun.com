FROM umputun/baseimage:app-v1.4.1

ENV HUGO_VER=0.73.0
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VER}/hugo_${HUGO_VER}_Linux-64bit.tar.gz /tmp/hugo.tar.gz
RUN cd tmp; \
    tar -xvf hugo.tar.gz && \
    ls -la && \
    mv /tmp/hugo /bin && \
    rm -rf /tmp/*

COPY exec.sh /srv/exec.sh
CMD /bin/sh "/srv/exec.sh"
