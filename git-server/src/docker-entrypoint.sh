#!/bin/ash
set -e

# the 'bin/ash' and NOT with a 'b' for 'bash' is correct!


if [ -z "$GIT_USER_UID" ]; then
    gitUserUid=1050
else
    gitUserUid=$GIT_USER_UID
fi


adduser -u $gitUserUid -D -H git


if [ "$2" = 'daemon' ]; then

    git config --global init.defaultBranch main

    chown -R git:git /srv/git
    chown -R git:git /data

    # always add a newline (blank line) to end of crontab, which is required by cron
    echo "" >> /cron/crontab
    chown -R git:git /cron
    chmod -R 550 /cron
    su git -c "supercronic /cron/crontab &"

    exec gosu git "$@"
fi

exec "$@"
