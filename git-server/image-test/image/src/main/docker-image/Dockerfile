FROM alpine:3.16.1


ENV GIT_VERSION 2.36.3-r0

ENV GOSU_VERSION 1.14


RUN apk fix && \
    apk --no-cache --update add git=$GIT_VERSION


RUN set -eux; \ 
        \
        apk add --no-cache --virtual .gosu-deps \
                ca-certificates \
                dpkg \
                gnupg \
        ; \
        \
        dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \ 
        wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
        wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
        \
# verify the signature
        export GNUPGHOME="$(mktemp -d)"; \ 
        gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
        gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
        command -v gpgconf && gpgconf --kill all || :; \ 
        rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
        \
# clean up fetch dependencies
        apk del --no-network .gosu-deps; \
        \
        chmod +x /usr/local/bin/gosu; \
# verify that the binary works
        gosu --version; \
        gosu nobody true



RUN \
    mkdir -p /repos; \
    mkdir -p /test/scripts; \
    mkdir -p /test/results
COPY test.sh /test/scripts


COPY docker-entrypoint.sh /
RUN \
    chmod 770 /docker-entrypoint.sh; \
    chmod 770 -R /test

WORKDIR /test/scripts


CMD [ "/bin/ash", "/test/scripts/test.sh" ]

ENTRYPOINT ["/docker-entrypoint.sh"]

