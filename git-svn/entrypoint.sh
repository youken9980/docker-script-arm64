#!/bin/sh

set -eux

git config --global core.autocrlf false
git config --global core.filemode false
git config --global core.safecrlf warn
git config --global core.compression -1
git config --global credential.helper store
git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999
git config --global http.sslVerify true
git config --global http.postBuffer 1048576000
git config --global https.postbuffer 1048576000
git config --global log.date local
git config --global alias.geturl "config --get remote.origin.url"
git config --global alias.last 'log -1'
git config --global alias.lg "log --graph --color --abbrev-commit --pretty=format:'%Cred%h %Cgreen(%cd)%C(auto)%d %Creset%s %Cblue%an <%ae>' --date=format-local:'%Y-%m-%d %H:%M:%S'"
git config --global user.name "${GIT_USER_NAME}"
git config --global user.email "${GIT_USER_EMAIL}"

/bin/sh
