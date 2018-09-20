#!/bin/bash

while true; do echo -n "$HOSTNAME:`free | grep Mem | awk '{print $3/$2 * 100.0}'`|c" | nc -w 1 -u 172.17.0.5 8125; done
