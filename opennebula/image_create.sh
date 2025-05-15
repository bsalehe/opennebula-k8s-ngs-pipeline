#!/bin/bash
oneimage create \
  --name "Ubuntu 20.04 Cloud" \
  --path /var/tmp/focal-server-cloudimg-amd64.img \
  --datastore default \
  --type OS
