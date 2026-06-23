#!/usr/bin/env bash

echo DEVELOPER_DIR=/Applications/Xcode_26.2.app >> $GITHUB_ENV

brew untap aws/tap azure/bicep || true
brew update
