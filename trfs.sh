#!/bin/bash

DIR=$(pwd)

if [ ! -f "${DIR}/.trfs" ]; then
    echo "Creating config file \"${DIR}/.trfs\""
    touch "${DIR}/.trfs"
    echo "DIS=NULL" > "${DIR}/.trfs"
fi

source ./.trfs

if [ $1 = 'pull' ]; then
    echo "Moving $DIS to ${DIR}/.."
    scp -r $DIS $DIR/..
elif [ $1 = 'push' ]; then
    echo "Moving ${DIR} to $DIS/.."
    scp -r $DIR $DIS/..
elif [ $1 = "connect" ]; then
    echo "trfs connected to $2"
    sed -i "s|DIS=.*|DIS=$2|" .trfs
else
    echo 'trfs <pull / push> <server host>'
fi