#!/usr/bin/env bash

# Global Variables
TMP="/tmp"
WORK_D="sheepit-headless"
CPU="1"

# Functions
function waitFunction {
sleep .9
}

function cpu_get {
  # Set cpu threads and return
  # $1 -> $CPU
  # $2 -> $QUIET
}

function prepare_tmp {
  # Prepare temporary working directory
  # $1 -> $TMP
  # $2 -> $QUIET

  # Custom working directory check
  if ! [ -d "$1" ] && [ "$1" != "$TMP" ]; then
    if [ "$2" -eq 1 ]; then
      printf "[WARN] $1 is not a valid path!\n"]
      printf "[INFO] Switching to /tmp\n"
    fi
  else
    TMP="$1"
  fi

  # Actual working directory check
  if ! [ -d "$TMP/$WORK_D" ]; then
    if [ "$2" -eq 1 ]; then
      printf "[INFO] Creating $TMP/$WORK_D\n"
    fi
    mkdir -p "$TMP/$WORK_D"
  else
    if [ "$2" -eq 1 ]; then
      printf "[INFO] $TMP/$WORK_D exists, cleaning it\n"
    fi
    rm -r $TMP/$WORK_D/*
  fi
}

function show_help {
  printf "> sheepit-headless [-h/--help] [ARGS]

  SheepIt Render Farm Headless Script
  
  HELP:
    -h, --help      Show this help message
    -v, --version   Show script version

  ARGUMENTS:
    -q, --quiet     Do not show info nor errors
    -c, --cpu       How many CPU threads to use
    -j, --java      Path to specific java executable to use
        --jar       Specify your own SheepIt JAR file
    -t, --tmp       Path to a base working directory (Default: /tmp)
  \n"
}

# Argument Parser
for i in "$@"; do
  case $i in
    -h | --help)
      show_help
      exit 0
  esac
done

CT_MAX="$(grep -c ^processor /proc/cpuinfo)"

printf "How many cores do you want to use, you have the option of using: "
grep -c ^processor /proc/cpuinfo
waitFunction
echo "Alright, making a folder"
cd /tmp || exit
echo "Check if it exists first"
if [ ! -d sheepitfolder ] ; then
	mkdir sheepitfolder
	echo "It doesn't let me make it"
fi
waitFunction
echo "Let's go into it"
cd sheepitfolder || exit
waitFunction
echo "Let's make a temp folder for this terminal session only"
TEMP=$(mktemp /tmp/sheepit_randomfolder.XXXXXXXX --directory)
cd ${TEMP} || exit
waitFunction
echo "Done"
waitFunction
echo "Now to download the client"
wget --quiet -O sheepit-clientTMPLATEST.jar https://www.sheepit-renderfarm.com/media/applet/client-latest.php
echo "Finished downloading"
java -jar sheepit-clientTMPLATEST.jar --version
waitFunction
echo "Ready"
waitFunction
echo "Ctrl + C to stop"
mkdir /tmp/sheepit-cache
java -jar sheepit-clientTMPLATEST.jar -login "$UsernameVariable" -password "$PasswordVariable" -ui text -cores "$" -cache-dir /tmp/sheepit-cache
cd
exit
