#!/bin/bash

# Scripts to install
FILES=(branch merge pull push stash)

# Create destination directory
[ $1 ] && dest=$1 || dest="/usr/local/bin"
mkdir -p ${dest}

# Download all scripts
for s in ${FILES[*]}; do
  curl -sS -o ${dest}/${s} https://raw.githubusercontent.com/jamiew/git-friendly/master/${s}
  if [ ! -f ${dest}/${s} ]; then
    echo
    echo "Oops! The '${s}' command cannot be copied to ${dest}, installation failed."
    echo "Try to rerun with sudo or specify a custom directory, see for details:"
    echo "https://github.com/jamiew/git-friendly#install"
    echo
    exit 1
  fi
  chmod +x ${dest}/${s}
done

# Done!
echo
echo "🎉  git-friendly has been installed into ${dest}."
echo "Try typing 'pull' in any Git repository to get started."
echo
echo "To update git-friendly, install it again."
echo
echo "For more info visit:"
echo "https://github.com/jamiew/git-friendly"
echo
