#!/bin/ash
set -e

# the 'bin/ash' and NOT with a 'b' for 'bash' is correct!


if [ -z "$GIT_USER_UID" ]; then
   gitUserUid=5000
else
   gitUserUid=$GIT_USER_UID
fi


if [ -z "$GIT_USER_FIRST_NAME" ]; then
   gitUserFirstName=John
else
   gitUserUid=$GIT_USER_FIRST_NAME
fi

if [ -z "$GIT_USER_LAST_NAME" ]; then
   gitUserLastName=Doe
else
   gitUserLastName=$GIT_USER_LAST_NAME
fi

if [ -z "$GIT_USER_EMAIL_ADDRESS" ]; then
   gitUserEmailAddress=john.doe@example.com
else
   gitUserEmailAddress=$GIT_USER_EMAIL_ADDRESS
fi


adduser -u $gitUserUid -D -H git

git config --global init.defaultBranch main
git config --global user.name "$gitUserFirstName $gitUserLastName"
git config --global user.email $gitUserEmailAddress
git config --global core.editor vim


if [ "$1" = '/test/scripts/test.sh' ]; then
   chown -R git:git /repos
   chown -R git:git /test
   exec gosu git "$@"
fi

exec "$@"