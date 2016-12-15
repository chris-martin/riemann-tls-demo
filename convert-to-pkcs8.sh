#!/usr/bin/env bash

in="$1"
out="${in%%.*}.pkcs8"
openssl pkcs8 -topk8 -nocrypt -in "$in" -out "$out"
