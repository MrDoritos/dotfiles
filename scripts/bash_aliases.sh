#!/bin/bash

alias nvidia='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'
alias nono='nano -i'
alias npy='nano -Ei -T 4'
alias lsr='ls --color=always -ltr $@'

magick() { $@; }
mkcd() { mkdir "$1" && cd "$1"; }