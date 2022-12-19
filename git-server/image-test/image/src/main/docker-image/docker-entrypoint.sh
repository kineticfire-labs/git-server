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
   gitUserFirstName=$GIT_USER_FIRST_NAME
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

# using '--system' which sets git config to '/etc/gitconfig' vs. '--global' which sets git config to '~/.gitconfig' because user doesn't have a home directory

git config --system init.defaultBranch main
git config --system user.name "$gitUserFirstName $gitUserLastName"
git config --system user.email $gitUserEmailAddress
git config --system core.editor vim


if [ "$1" = 'tail' ]; then
   chown -R git:git /repos
   exec gosu git "$@"
fi

exec "$@"
