#!/bin/bash

[[ $# < 1 ]] && echo -e "Usage:\n\t$0 example.com 8443" > /dev/stderr && exit 1

host=${1}
port=${2:-"443"}

openssl s_client \
     -connect ${host}:${port} \
     -showcerts \
       < /dev/null 2> /dev/null | \
  openssl x509 -outform PEM > ${host}.crt

