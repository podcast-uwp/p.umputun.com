#!/bin/sh
cd /srv/hugo
echo " === generate pages ==="
hugo --minify
cp -f /srv/hugo/public/css/*.map /srv/hugo/public/scss/
