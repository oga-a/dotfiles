#!/bin/sh

set -e # -e: exit on error

GITHUB_USER="oga-a"

if [ "$(command -v curl)" ]; then
  sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply $GITHUB_USER --exclude scripts
elif [ "$(command -v wget)" ]; then
  sh -c "$(wget -qO- chezmoi.io/get)" -- init --apply $GITHUB_USER --exclude scripts
else
  echo "To apply dotfiles, you must have curl or wget installed." >&2
  exit 1
fi

# sh -c "$(curl -fsLS chezmoi.io/get)" -- init oga-a
# sh -c "$(curl -fsLS chezmoi.io/get)" -- apply --exclude scripts

echo '' >> ~/.bashrc
echo '. ~/.bashrc_supplement' >> ~/.bashrc
