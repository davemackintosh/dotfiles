#!/bin/env bash

# I do not endorse pirating, copying for distribution or any
# other illegal or unlicensed use of digital media. I just
# use this to backup my DVDs to my Latte Panda with Kodi on
# While my DVD collection is in storage. 

clear &&

NAME="$1"
TYPE="$2"

ISONAMESPC=${NAME,}
ISONAME=${ISONAMESPC// /-}

if [ -z "$NAME" ]
then
  echo "Usage dvd-to-iso.sh {NAME} {Movies | TV}"
  exit -1
fi

if [ -z "$TYPE" ]
then
  echo "Usage dvd-to-iso.sh $NAME {Movies | TV}"
  exit -1
fi

mkdir -p "$HOME/Videos/$TYPE/$NAME/" &&

echo -e "Pulling DVD to disc: This can take a while\n" &&
dvdbackup -i /dev/sr0 -n "$NAME" -o "$HOME/Videos/$TYPE/" -M &&

echo -e "Converting pulled files to an iso; $NAME\n"
mkisofs -dvd-video -o "$HOME/Videos/$TYPE/$ISONAME.iso" "$HOME/Videos/$TYPE/$NAME" &&

echo -e "Cleaning up\n" &&
rm -rf "$HOME/Videos/$TYPE/$NAME/" &&

echo "Done, rsync to the OSCM machine if you're at home."
