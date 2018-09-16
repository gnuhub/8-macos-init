#!/usr/bin/env bash

if [ ! -d /usr/local/bin/ ];then
    mkdir -p /usr/local/bin/
fi

if [ ! -f /usr/local/bin/gitlab-runner ];then
    curl -fsSL https://download.sf.net/gnuhub/gitlab-runner > /usr/local/bin/gitlab-runner
    chmod +x /usr/local/bin/gitlab-runner
fi

/usr/local/bin/gitlab-runner --version

launchctl list | grep gitlab-runner