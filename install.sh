#!/bin/sh

set -e # -e: exit on error

GITHUB_USERNAME="oga-a"

if [ "$(command -v curl)" ]; then
  sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply $GITHUB_USERNAME --exclude scripts
elif [ "$(command -v wget)" ]; then
  sh -c "$(wget -qO- chezmoi.io/get)" -- init --apply $GITHUB_USERNAME --exclude scripts
else
  echo "To apply dotfiles, you must have curl or wget installed." >&2
  exit 1
fi

# sh -c "$(curl -fsLS chezmoi.io/get)" -- init oga-a
# sh -c "$(curl -fsLS chezmoi.io/get)" -- apply --exclude scripts
