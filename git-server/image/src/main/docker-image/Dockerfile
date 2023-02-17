FROM alpine:3.16.1


# Setting minimum package version since Alpine repositories may drop older package versions
ENV GIT_MIN_VERSION 2.36.3-r0
ENV GIT_DAEMON_MIN_VERSION 2.36.3-r0
ENV GIT_LFS_MIN_VERSION 3.1.4-r5

ENV GOSU_VERSION 1.14


RUN apk fix && \
    apk --no-cache --update add \
      git>$GIT_MIN_VERSION \
      git-daemon>$GIT_DAEMON_MIN_VERSION \
      git-lfs>$GIT_LFS_MIN_VERSION \
      less \
      openssh && \
    git lfs install


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


ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.12/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=048b95b48b708983effb2e5c935a1ef8483d9e3e

RUN \
    apk add --update --no-cache ca-certificates curl \
    && curl -fsSLO "$SUPERCRONIC_URL" \
    && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
    && chmod +x "$SUPERCRONIC" \
    && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
    && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic \
    \    
    # remove unwanted deps & cleanup
    && apk del --purge ca-certificates curl \
    && rm -rf /tmp/* /var/cache/apk/*


RUN mkdir -p /cron/scripts
COPY crontab /cron
COPY git-backup.sh /cron/scripts


COPY docker-entrypoint.sh /
COPY git-create-repo.sh /
COPY git-backup.sh /
RUN \
    chmod 770 /docker-entrypoint.sh; \
    chmod 770 /git-create-repo.sh; \
    mkdir /srv/git


WORKDIR /srv/git


CMD [ "git", "daemon", "--base-path=/srv/git", "--export-all", "--enable=receive-pack", "/srv/git" ]

ENTRYPOINT ["/docker-entrypoint.sh"]


EXPOSE 9418/tcp
