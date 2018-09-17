#!/usr/bin/env bash
# what
* mac安装gitlab-runner
## 依赖
# * curl
# * launctl
# * github
# * sf
set -x
if [ ! -d /usr/local/bin/ ];then
    mkdir -p /usr/local/bin/
fi

if [ ! -f /usr/local/bin/gitlab-runner ];then
    ## 11.0.2
    curl -fsSL https://download.sf.net/gnuhub/gitlab-runner > /usr/local/bin/gitlab-runner
    chmod +x /usr/local/bin/gitlab-runner
fi

/usr/local/bin/gitlab-runner --version

launchctl list | grep gitlab-runner

if [ ! -f ${HOME}/Library/LaunchAgents/afu.net.gitlab-runner.plist ];then
    curl -fsSL https://raw.githubusercontent.com/gnuhub/8-macos-init/master/afu.net.gitlab-runner.plist > ${HOME}/Library/LaunchAgents/afu.net.gitlab-runner.plist
fi

launchctl load -w ${HOME}/Library/LaunchAgents/afu.net.gitlab-runner.plist