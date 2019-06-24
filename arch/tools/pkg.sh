#!/bin/env bash

VG="vg0"
PACMANARGS=$@

SNAPNAME=$(date)

echo -e "Taking snapshots of the system in this state.\n\n$SNAPNAME-ROOT\n$SNAPNAME-HOME" &&

lvcreate -s "/dev/$VG/root" -n "$SNAPNAME-ROOT" &&
lvcreate -s "/dev/$VG/home" -n "$SNAPNAME-HOME" &&

sudo pacman $PACMANARGS

