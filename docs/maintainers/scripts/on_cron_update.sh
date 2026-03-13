#!/bin/bash

if [ "$EUID" -eq 0 ]; then
  echo "Running as root"
else
  echo "Not running as root! Script would likely fail!"
fi

find /home/uploader/uploads -type f -mmin +2 -exec chmod 644 {} \; -exec chown download:download {} \; -print0 | xargs -0 -I {} mv {} /home/download/tmp

sudo -u download ensure_free_space.sh
sudo -u download sort_builds.sh
