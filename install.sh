#!/bin/bash

here=$(pwd -P)
tmp="/tmp/git-friendly"

git clone git://github.com/jamiew/git-friendly.git $tmp >/dev/null 2>&1
rm -rf $tmp/.git
rm -f $tmp/README* $tmp/install.sh
cp $tmp/* /usr/local/bin/
rm -rf $tmp

echo
echo "Done! Try typing 'pull' in a git repository to get started"
echo "For more info visit http://github.com/jamiew/git-friendly"
echo

