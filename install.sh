#!/bin/bash

here=$(pwd -P)
tmp="/tmp/git-friendly"
[ $1 ] && dest=$1 || dest="/usr/local/bin"

git clone https://github.com/jamiew/git-friendly.git $tmp >/dev/null 2>&1
rm -rf $tmp/.git
rm -f $tmp/README* $tmp/install.sh
installed_scripts=`ls -1 ${tmp}`
mkdir -p ${dest}
cp $tmp/* ${dest}/ &> /dev/null
rm -rf $tmp
for s in ${installed_scripts}; do
  if [ ! -f ${dest}/${s} ]; then
    echo
    echo "Oops! The ${s} command couldn't be installed, installation failed."
    echo "Please re-run me as someone who can install into ${dest}."
    echo
    exit 1
  fi
done

echo
echo "Done! Try typing 'pull' in any git repository to get started"
echo "For more info visit:"
echo "http://github.com/jamiew/git-friendly"
echo

exit 0
