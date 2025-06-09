#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Load our scripts
if [ -f "$SCRIPT_DIR/bash_vars.sh"]; then
    . "$SCRIPT_DIR/bash_vars.sh"
fi
if [ -f "$SCRIPT_DIR/bash_completion.sh" ]; then
    . "$SCRIPT_DIR/bash_completion.sh"
fi
if [ -f "$SCRIPT_DIR/bash_aliases.sh" ]; then
    . "$SCRIPT_DIR/bash_aliases.sh"
fi

# Change history options
shopt -s histappend
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTCONTROL=ignoreboth

# Waypoint config location
export WAYPOINT_CONFIG="$DOTFILE_CONFIG_DIR/waypoints.conf"
