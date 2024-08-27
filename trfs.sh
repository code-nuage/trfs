#!/bin/bash

DIR=$(pwd)
CONFIG_FILE="${DIR}/.trfs"

# Verification and creation of configuration file
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Creating config file \"$CONFIG_FILE\""
    touch "$CONFIG_FILE"
    echo "DIS=NULL" > "$CONFIG_FILE"
fi

# Configuration loading
source "$CONFIG_FILE"

# Arguments
case "$1" in
    "pull")
        if [ "$DIS" = "NULL" ]; then
            echo "Error: DIS is not configured. Use 'connect' to configure it."
            exit 1
        fi
        echo "Moving $DIS to ${DIR}/.."
        scp -r "$DIS" "${DIR}/.."
        ;;
    "push")
        if [ "$DIS" = "NULL" ]; then
            echo "Error: DIS is not configured. Use 'connect' to configure it."
            exit 1
        fi
        echo "Moving ${DIR} to $DIS/.."
        scp -r "$DIR" "$DIS/.."
        ;;
    "connect")
        if [ -z "$2" ]; then
            echo "Error: Please specify a server to connect to."
            exit 1
        fi
        echo "trfs connected to $2"
        sed -i "s|DIS=.*|DIS=$2|" "$CONFIG_FILE"
        ;;
    *)
        echo 'Usage: trfs <pull / push / connect> <server host>'
        ;;
esac
