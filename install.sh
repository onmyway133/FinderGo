#!/bin/bash

set -euo pipefail

iTerm=iterm.scpt
terminal=terminal.scpt
hyper=hyper.scpt

DOWNLOAD_ITERM_URI=https://raw.githubusercontent.com/onmyway133/FinderGo/master/FinderSyncExtension/Scripts/${iTerm}
DOWNLOAD_TERMINAL_URI=https://raw.githubusercontent.com/onmyway133/FinderGo/master/FinderSyncExtension/Scripts/${terminal}
DOWNLOAD_HYPER_URI=https://raw.githubusercontent.com/onmyway133/FinderGo/master/FinderSyncExtension/Scripts/${hyper}

SCRIPT_DIR="${HOME}/Library/Application Scripts/com.fantageek.FinderGo.FinderSyncExtension"

mkdir -p "${SCRIPT_DIR}"
curl $DOWNLOAD_ITERM_URI -o "${SCRIPT_DIR}/${iTerm}"
curl $DOWNLOAD_TERMINAL_URI -o "${SCRIPT_DIR}/${terminal}"
curl $DOWNLOAD_HYPER_URI -o "${SCRIPT_DIR}/${hyper}"