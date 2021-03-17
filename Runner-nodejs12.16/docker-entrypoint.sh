#!/bin/sh

if [ 0z "$SSH_PUBLIC_KEY" ]; then
    echo "Need your SSH public key as the SSH_PUBLIC_KEY env variable."
    exit 1
fi

USER_SSH_KEYS_FOLDER=~/.ssh
[ ! -d "$USER_SSH_KEYS_FOLDER" ] && mkdir -p $USER_SSH_KEYS_FOLDER

echo $SSH_PUBLIC_KEY > ${USER_SSH_KEYS_FOLDER}/authorized_keys

unset SSH_PUBLIC_KEY

exec /usr/sbin/sshd -D
