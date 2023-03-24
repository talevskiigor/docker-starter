#!/bin/bash

USER_ID=${USER_ID:-1000}
GIT_USER=${GIT_USER}
GIT_EMAIL=${GIT_EMAIL}

export HOME=/home/docker

# echo "export PS1=\"\[\033[33;1m\]\w\[\033[m\] (\[\033[30;1m\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[\033[m\]) \$  \n $ \"" >> /home/docker/.bashrc
git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"
git config --global core.filemode false
git config --global credential.helper store
git config --global credential.helper 'cache --timeout=360000'

git config --global branch.autosetuprebase always
git config --global branch.develop.rebase true


mkdir -p ~/.ssh
ssh-keyscan github.com >> ~/.ssh/known_hosts
ssh-keyscan git.internetbrands.com >> ~/.ssh/known_hosts


source ~/.bashrc
## Change the prompt to show the active git branch and add some colors
# export PS1="\[\033[33;1m\]\w\[\033[m\] (\[\033[30;1m\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[\033[m\]) \$  \n $"





