#!/bin/sh

echo "%{F#ffffff}  %{F#ffffff}$(/usr/sbin/ifconfig eth0 | grep "inet " | awk '{print $2}')%{u-}"
