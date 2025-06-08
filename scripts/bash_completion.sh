#!/bin/bash

_tp() { export COMP_LINE; COMPREPLY=( $($COMP_LINE) ); }
tp() { ndir=$(tpreg $@) && cd "$ndir" && return 0; echo "$ndir"; }
complete -o bashdefault -F _tp tp