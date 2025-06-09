#!/bin/bash

# Launch program with GPU offload
alias nvidia='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'
# nano with indent
alias nono='nano -i'
# nano with indent, replace tabs with spaces, indents are 4 spaces
alias npy='nano -Ei -T 4'
# Show colors correctly
alias les='less -r'
# Sort by time, latest items last
alias lsr='ls --color=always -ltr'
alias hgrep='history | grep --color=always'
# Disasseble
alias disas='objdump -d'
# Up directory
alias ..='cd ..'
alias cd..='cd ..'
alias bc='bc -l'
alias where='which'
# Kill last job
alias jkill='kill -9 %-'
# Kill last process
alias lkill='kill -9 $!'

# No longer a magick command, if magick is entered it will just be 'convert' instead of 'magick convert'
magick() { $@; }
# mkdir and cd into it
mkcd() { mkdir "$1" && cd "$1"; }
# Disassemble with less
disasl() { objdump -d $@ | less; }
# xxd with less
xxdl() { xxd $@ -R always | les; }
# diff with less
diffl() { diff $@ | less; }
diffyl() { diff -y $@ | less; }
# Automatically load and run file with trailing args as the program's arguments, pass off to stdin once complete
gdba() { (echo -e "file $1\nrun ${@:2}"; cat -) | gdb -q; }
# Automatically load and run file with first trailing arg as the program's arguments, with the remaining trailing args as gdb commands entered before run
gdbr() { (echo -e "file $1\n${@:3}\nrun $2"; cat -) | gdb -q; }
# Similar to gdbr but will enter commands before and after the program runs
gdbrr() { (echo -e "file $1\n$3\nrun $2\n${@:4}"; cat -) | gdb -q; }
