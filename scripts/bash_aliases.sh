#!/bin/bash

alias nvidia='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'
alias nono='nano -i'
alias npy='nano -Ei -T 4'
alias lsr='ls --color=always -ltr'
alias hgrep='history | grep'
alias disas='objdump -d'

magick() { $@; }
mkcd() { mkdir "$1" && cd "$1"; }
disasl() { objdump -d $@ | less; }
xxdl() { xxd $@ | less; }
gdba() { bin=$1; shift 1; (echo -e "file $bin\nrun $@"; cat -) | gdb -q; }
gdbr() { bin=$1; args=$2; shift 2; (echo -e "file $bin\n$@\nrun $args"; cat -) | gdb -q; }
