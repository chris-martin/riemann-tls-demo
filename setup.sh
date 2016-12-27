#!/usr/bin/env bash

export EASYRSA=$(pwd)

# Initialize our PKI.
easyrsa init-pki
easyrsa build-ca nopass

# Generate some cert requests.
easyrsa gen-req alice nopass
easyrsa gen-req bob   nopass
easyrsa gen-req eve   nopass

# Issue a client cert to Alice, and a server cert to Bob.
easyrsa sign-req client alice
easyrsa sign-req server bob

# Convert all of the private keys to pkcs8.
find pki/private/ -name "*.key" -type f -exec ./convert-to-pkcs8.sh "{}" \;
