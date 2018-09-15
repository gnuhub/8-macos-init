#!/usr/bin/env bash
set -x

function pkgs.dowload()
{
    # https://developer.apple.com/download/more/
    if [ ! -f 'xcode9.4.1.pkg' ];then
	    wget https://download.sf.net/gnuhub/xcode9.4.1.pkg
    fi

    if [ ! -f 'xcode_cli_tools_macos10.13_for_xcode9.4.1.pkg' ];then
	    wget https://download.sf.net/gnuhub/xcode_cli_tools_macos10.13_for_xcode9.4.1.pkg
    fi
}

function xcode.install()
{
    if [ ! -d /Applications/Xcode.app ];then
        # wget https://download.sf.net/gnuhub/xcode_cli_tools_macos10.13_for_xcode9.4.1.pkg
        export __CFPREFERENCES_AVOID_DAEMON=1

        sudo installer -pkg 'xcode9.4.1.pkg' -target /

        curl curl -fsSL https://raw.githubusercontent.com/gnuhub/8_macos_init/master/agree_xcode_licence.sh > agree_xcode_licence.sh
        chmod +x agree_xcode_licence.sh
        ./agree_xcode_licence.sh

        sudo installer -pkg 'xcode_cli_tools_macos10.13_for_xcode9.4.1.pkg' -target /
    fi
}

function homebrew.install()
{
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # https://mirror.tuna.tsinghua.edu.cn/help/homebrew/
    cd "$(brew --repo)"
    git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

    cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

    brew update
}

function gitlab-runner.install()
{
    export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
    export HOMEBREW_NO_AUTO_UPDATE=true
    brew install wget
    brew install gitlab-runner
    brew services start gitlab-runner
}

pkgs.dowload
xcode.install
homebrew.install
gitlab-runner.install
