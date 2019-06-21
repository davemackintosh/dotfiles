#!/bin/env bash

clear &&

NAME="$1"
TYPE="$2"
SERIES="$3"
EPSTART="$4"
EPSEND="$5"

MOUNTPOINT="/mnt/media"

ISONAMESPC=${NAME,}
ISONAME=${ISONAMESPC// /-}

# Pad $1 with leading 0s to two characters
# @param number to pad
pad() {
  printf "%02d\n" $1
  return 1
}

# Create a Kodi friendly tv episode string.
# @param Season number
# @param Episode starting number
# @param Episode ending number
createSeasonEString() {
  out="S$(pad "$1")."

  for i in $(seq "$2" "$3");
    do
      out="${out}E$(pad "$i")"
    done

  echo "$out"
  return 1
}

if [ -z "$NAME" ]
then
  echo "Usage dvd-to-iso-kodi.sh {NAME} {movies | tv} season episode-num-start episode-num-end"
  exit -1
fi

if [ -z "$TYPE" ]
then
  echo "Usage dvd-to-iso-kodi.sh $NAME {movies | tv} season episode-num-start episode-num-end"
  exit -1
fi

if [ -z "$SERIES" ]
then
  echo "Usage dvd-to-iso-kodi.sh $NAME $TYPE season episode-num-start episode-num-end"
  exit -1
fi

if [ -z "$EPSTART" ]
then
  echo "Usage dvd-to-iso-kodi.sh $NAME $TYPE $SERIES episode-num-start episode-num-end"
  exit -1
fi

if [ -z "$EPSEND" ]
then
  echo "Usage dvd-to-iso-kodi.sh $NAME $TYPE $SERIES $EPSTART episode-num-end"
  exit -1
fi

mkdir -p "$MOUNTPOINT/$TYPE/$NAME/" &&

echo -e "Pulling DVD to disc: This can take a while\n" &&
dvdbackup -i /dev/sr0 -n "$NAME" -o "$MOUNTPOINT/$TYPE/" -M &&

echo -e "Converting pulled files to an iso; $NAME\n"
KODIFRIENDLY=$(createSeasonEString $SERIES $EPSTART $EPSEND)

mkisofs -dvd-video -o "$MOUNTPOINT/$TYPE/$ISONAME.iso" "$MOUNTPOINT/$TYPE/$NAME.$KODIFRIENDLY" &&

echo -e "Cleaning up\n"
#rm -rf "$MOUNTPOINT/$TYPE/$NAME/" &&

echo "Done, enjoy ❤."
