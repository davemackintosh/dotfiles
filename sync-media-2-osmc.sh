#!/bin/env bash

HOST="192.168.1.116"
DEST="/media/Seagate\ Backup\ Plus\ Drive/OSMC"

echo -e "Synching TV" &&
rsync --progress -azv --remove-source-files ~/Videos/TV/ "osmc@$HOST:$DEST/tv/" &&

echo -e "Synching Movies" &&
rsync --progress -azv --remove-source-files ~/Videos/Movies/ "osmc@$HOST:$DEST/video/" &&

echo -e "Synching Audio" &&
rsync --progress -azv --remove-source-files ~/Audio/ "osmc@$HOST:$DEST/audio/"

