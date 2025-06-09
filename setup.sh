SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

CONFIG_DIR="$HOME/.config/dotfiles"
BIN_DIR="$HOME/.local/bin"
SOURCE_FILE="$HOME/.bashrc"

BASHRC_ENTRY=". $CONFIG_DIR/bashrc.sh # dotfiles"

if [ "$1" == "install" ]; then
    echo Installing
    mkdir -pv "$CONFIG_DIR"
    mkdir -pv "$BIN_DIR"
    cp -v "$SCRIPT_DIR/scripts/*" "$CONFIG_DIR/"
    cp -vn "$SCRIPT_DIR/config/*" "$CONFIG_DIR/"
    cp -v "$SCRIPT_DIR/bin/*" "$BIN_DIR/"
    chmod +x -R "$CONFIG_DIR"
    chmod +x -R "$BIN_DIR"
    echo "export DOTFILE_CONFIG_DIR=\"$CONFIG_DIR\"" >> "$CONFIG_DIR/bash_vars.sh"
    if ! grep -q "$BASHRC_ENTRY" "$SOURCE_FILE"; then
        echo Adding bashrc entry
        echo -e "\n\n$BASHRC_ENTRY" >> "$SOURCE_FILE"
    else
        echo bashrc entry found.. skipping
    fi
    . "$SOURCE_FILE"
    exit 0

elif [ "$1" == "uninstall" ]; then
    echo Uninstalling
    TO_REMOVE=$( find "$SCRIPT_DIR/bin" -type f -exec diff -q "{}" -r ~/programs \; -print )
    for bin in $TO_REMOVE;
    do
        FILE=$BIN_DIR/$(basename $bin)
        echo $FILE
    done
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