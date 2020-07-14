#!/bin/sh

#source: https://docspring.com/blog/posts/adding-a-timestamp-to-hugo-post-filenames/
for POST in *.md; do
    TIMESTAMP=$(ruby -r yaml -e "puts YAML.load_file('$POST')['date'].strftime('%Y%m%d')")
    ! [[ $POST =~ ^[0-9]{8} ]] \
    && perl -i -p0e "s/(---\n\n)/slug: ${POST/.md/}\n\1/s" $POST \
    && mv $POST $TIMESTAMP-$POST
done
