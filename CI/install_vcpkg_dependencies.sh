#!/usr/bin/env bash

FILENAME="dependencies-$1"

# Fetch latest release tag dynamically
RELEASE_TAG=$(curl -s https://api.github.com/repos/vcmi/vcmi-deps-windows/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

DOWNLOAD_URL="https://github.com/vcmi/vcmi-deps-windows/releases/download/$RELEASE_TAG/$FILENAME.txz"

curl -L "$DOWNLOAD_URL" | tar -xf - --xz
