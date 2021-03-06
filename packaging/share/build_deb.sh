#!/usr/bin/env bash

# Call with argument for version of package ex: _U18.04 or _U20.04

cd ..
git clone https://github.com/CasperLabs/casper-node.git ./casper-node
cd casper-node

make deb

for file in ./target/debian/*_amd64.deb ; do mv "$file" "${file//_amd64./_amd64$1.}" ; done

cp ./target/debian/* /root/share/