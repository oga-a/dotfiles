#!/bin/sh

set -e # -e: exit on error

if [ "${HTTP_PROXY}" == "" ]; then
  GITHUB_USER="oga-a"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply $GITHUB_USER --exclude scripts
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- chezmoi.io/get)" -- init --apply $GITHUB_USER --exclude scripts
  else
    echo "To apply dotfiles, you must have curl or wget installed." >&2
    exit 1
  fi
elif [ "${PWD: -8:8}" == "dotfiles" ]; then
  cp_dot_file () {
    rm -f ~/.$1
    cp $PWD/dot_$1 ~/.$1
  }

  file_name_array=('bash_aliases' 'bashrc_supplement' 'env_global')
  for file_name in ${file_name_array[@]}
  do
    cp_dot_file $file_name
  done

  file_name='config/git/ignore'
  mkdir -p $HOME'/.config/git/'
  cp_dot_file $file_name

  if [ "${REMOTE_CONTAINERS}" != "true" ]; then
    file_name='gitconfig'
    cp_dot_file $file_name
  fi
else
  echo "Proxy error." >&2
  exit 1
fi


# sh -c "$(curl -fsLS chezmoi.io/get)" -- init oga-a
# sh -c "$(curl -fsLS chezmoi.io/get)" -- apply --exclude scripts

echo '' >> ~/.bashrc
echo '. ~/.bashrc_supplement' >> ~/.bashrc
exit 1
