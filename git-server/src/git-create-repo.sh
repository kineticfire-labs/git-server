#!/bin/ash
set -e

# the 'bin/ash' and NOT with a 'b' for 'bash' is correct!


if [[ $# -eq 1 ]]; then

    REPO_NAME=$1

    git init --bare /srv/git/$REPO_NAME
    touch /srv/git/$REPO_NAME/git-daemon-export-ok
    chown -R git:git /srv/git/$REPO_NAME

else
    echo "Error:  Must have exactly one argument specifying the repository name."
    exit 0
fi


