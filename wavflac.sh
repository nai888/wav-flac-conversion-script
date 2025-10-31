#!/usr/bin/env bash

#=========
# wavflac.sh
#
# convert all .wav files to .flac (or vice versa) in the given directory
#=========

# Exit on any failure
set -e

# prevent literal globs when no matches
shopt -s nullglob

# Defaults
out="flac"
indir=""
dir=""
win=false

# Parse args
while [[ "$1" != "" ]]; do
  case $1 in
    "-o" | "--out")
      shift
      out=$1
      ;;
    "-d" | "--dir")
      shift
      indir=$1
      ;;
    "-w" | "--win")
      win=true
      ;;
    "-h" | "--help")
      echo "wavflac.sh"
      echo ""
      echo "Converts audio files in a given directory from wav to flac or flac to wav."
      echo ""
      echo "EXAMPLE: \$ wavflac.sh {directory} [-w] [-o wav]"
      echo ""
      echo "* | -d | --dir  : directory containing files to convert"
      echo "    -o | --out  : output format ('flac' or 'wav'; default 'flac')"
      echo "    -w | --win  : convert Windows-style paths (for WSL)"
      echo "    -h | --help : show this help message"
      exit 0
      ;;
    *)
      if [[ "$indir" == "" ]]; then
        indir=$1
      fi
      ;;
  esac
  shift
done

# Ensure directory was specified
if [[ "$indir" == "" ]]; then
  echo "Error: no directory specified. Add a path argument, or use -d or --dir."
  exit 1
fi

if [[ $win == true ]]; then
  dir=$(wslpath "$indir" 2>/dev/null)
else
  dir="$indir"
fi

# Add trailing slash if missing
dir="${dir%/}/"

echo ""
echo "Converting file(s) in '$dir'"

# Conversion
if [[ "$out" == "wav" ]]; then
  for i in "${dir}"*.[Ff][Ll][Aa][Cc]; do
    echo ""
    echo "Converting $i > ${i%.*}.wav"
    echo ""
    ffmpeg -i "$i" "${i%.*}.wav"
  done
else
  for i in "${dir}"*.[Ww][Aa][Vv]; do
    echo ""
    echo "Converting $i > ${i%.*}.flac"
    echo ""
    ffmpeg -i "$i" "${i%.*}.flac"
  done
fi

# Script end
echo ""
echo "File conversion complete"
