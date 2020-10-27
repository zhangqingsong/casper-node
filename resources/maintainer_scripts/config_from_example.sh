#!/usr/bin/env bash
set -e

# This script will generate a CONFIG file appropriate to installation machine.

PATH=/etc/casper/

EXTERNAL_IP=$(dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | tr -d '"')
echo "Using External IP: $EXTERNAL_IP"

CONFIG=$PATH"CONFIG.toml"
CONFIG_EXAMPLE=$PATH"CONFIG-example.toml"
CONFIG_NEW=$PATH"CONFIG.toml.new"

OUTFILE=$CONFIG

if [[ -f $OUTFILE ]]; then
  OUTFILE=$CONFIG_NEW
  if [[ -f $OUTFILE ]]; then
    rm $OUTFILE
  fi
  echo "Previous $CONFIG exists, creating as $OUTFILE from $CONFIG_EXAMPLE."
  echo "Replace $CONFIG with $OUTFILE to use the automatically generated CONFIGuration."
else
  echo "Creating $OUTFILE from $CONFIG_EXAMPLE."
fi

sed "s/<IP ADDRESS>/${EXTERNAL_IP}/" $CONFIG_EXAMPLE > $OUTFILE