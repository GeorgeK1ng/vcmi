#!/usr/bin/env bash

RELEASE_TAG="2026-10-15"
FILENAME="$1.txz"
DOWNLOAD_URL="https://github.com/GeorgeK1ng/vcmi-dependencies/releases/download/$RELEASE_TAG/$FILENAME"

downloadedFile="$RUNNER_TEMP/$FILENAME"
curl --proto =https -Lo "$downloadedFile" "$DOWNLOAD_URL"
conan cache restore "$downloadedFile"
