#!/bin/bash
shopt -s extglob

id=$(xdpyinfo | grep focus | cut -f4 -d " ")
pid_parent=$(xprop -id $id | grep -m 1 PID | cut -d " " -f 3)
pid_shell=$(ps --ppid $pid_parent | awk 'NR>1{print $1}')
cwd="$(readlink /proc/$pid_shell/cwd)"
cwd=${cwd:-$HOME}

case $TERMINAL in
  konsole      ) args="--workdir $cwd" ;;
  ?(.*?/)kitty ) args="-d $cwd";;
esac

$TERMINAL $args
