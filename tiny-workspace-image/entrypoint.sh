#!/usr/bin/env bash

# Ensure that the user's home directory exists
if [ ! -d "${HOME}" ]
then
  mkdir -p "${HOME}"
fi

# Inject the workspace user into /etc/passwd, /etc/group with the random uid assigned by OpenShift
if ! whoami &> /dev/null
then
  if [ -w /etc/passwd ]
  then
    echo "${USER_NAME:-user}:x:$(id -u):0:${USER_NAME:-user} user:${HOME}:/bin/bash" >> /etc/passwd
    echo "${USER_NAME:-user}:x:$(id -u):" >> /etc/group
  fi
fi

exec "$@"