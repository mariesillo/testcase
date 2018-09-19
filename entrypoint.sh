#!/bin/sh

# Generate host key
ssh-keygen -A

# Check if passwd was passed to container
if [ ! -z "${ROOT_PASSWORD}" ] && [ "${ROOT_PASSWORD}" != "root" ]; then
    echo "root:${ROOT_PASSWORD}" | chpasswd
fi

# Start service
exec /usr/sbin/sshd -D -e "$@"

