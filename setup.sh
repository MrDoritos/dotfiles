#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

CONFIG_DIR="$HOME/.config/dotfiles"
BIN_DIR="$HOME/.local/bin"
SOURCE_FILE="$HOME/.bashrc"

BASHRC_ENTRY=". $CONFIG_DIR/bashrc.sh # dotfiles"

if [ "$UID" == "0" ]; then
    echo "Are you sure you would like to run as root user?"
    echo -n "The location will be $HOME [y/N] "
    while true; do
        read -N 1 f
	echo
        if [[ "$f" == "y" || "$f" == "Y" ]]; then
            break
        fi
        exit 0
    done
fi

if [ "$1" == "install" ]; then
    echo Installing

    # Add execution bit to install files
    chmod +x -Rc "$SCRIPT_DIR"/scripts/*
    chmod +x -Rc "$SCRIPT_DIR"/bin/*

    # Make installation directories
    mkdir -pv "$CONFIG_DIR"
    mkdir -pv "$BIN_DIR"

    # Copy installation files
    cp -vr "$SCRIPT_DIR"/scripts/* "$CONFIG_DIR/"
    cp -vnr "$SCRIPT_DIR"/config/* "$CONFIG_DIR/" # No clobber (overwrite)
    cp -vr "$SCRIPT_DIR"/bin/* "$BIN_DIR/"

    # Append variables to our environment
    echo -e "\n" >> "$CONFIG_DIR/bash_vars.sh"
    echo "export DOTFILE_CONFIG_DIR=\"$CONFIG_DIR\"" >> "$CONFIG_DIR/bash_vars.sh"
    echo "export DOTFILE_BIN_DIR=\"$BIN_DIR\"" >> "$CONFIG_DIR/bash_vars.sh"

    # Add .bashrc entry
    if ! grep -q "$BASHRC_ENTRY" "$SOURCE_FILE"; then
        echo Adding bashrc entry
        echo -e "\n\n$BASHRC_ENTRY" >> "$SOURCE_FILE"
    else
        echo bashrc entry found.. skipping
    fi

    # Try to source, but it wont work
    . "$SOURCE_FILE"
    exit 0

elif [ "$1" == "uninstall" ]; then
    echo Uninstalling

    # Gather .bin files equal to ours
    TO_REMOVE=$( find "$SCRIPT_DIR/bin" -type f -exec diff -q "{}" -r "$BIN_DIR" \; -print )

    for bin in $TO_REMOVE;
    do
        FILE="$BIN_DIR/$(basename "$bin")"
        rm -i "$FILE"
    done

    # Remove just our .bashrc entry, if it is found
    if grep -q "$BASHRC_ENTRY" "$SOURCE_FILE"; then
        echo Removing bashrc entry
        sed -i "s@$BASHRC_ENTRY@@" "$SOURCE_FILE"
    else
        echo bashrc entry not found.. skipping
    fi
    exit 0

else
    echo "Usage: $( basename "$0" ) ( install | uninstall ) "
    exit 1

fi
