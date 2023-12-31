#!/bin/bash

#set -e
M=$1
if [ "$M" == "" ];then
    M="up"
    echo "Usage: ./up.sh commit message"
fi

find . -name "*.sh" -exec chmod +x {} +

git add -A
git commit -m $M

git fetch -u origin main
git merge --no-edit

git push -u origin main 

