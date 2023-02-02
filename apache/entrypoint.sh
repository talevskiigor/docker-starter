#!/bin/bash

USER_ID=${USER_ID:-1000}
GIT_USER=${GIT_USER}
GIT_EMAIL=${GIT_EMAIL}

export HOME=/home/docker

git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"
git config --global core.filemode false
git config --global credential.helper store
git config --global credential.helper 'cache --timeout=360000'



source ~/.bashrc





