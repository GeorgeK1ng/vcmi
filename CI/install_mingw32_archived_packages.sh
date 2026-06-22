#!/usr/bin/env bash

set -euo pipefail

# The active MINGW32 repository no longer indexes Boost, but MSYS2 mirrors retain
# the last complete i686 package. Keep the exact package version pinned because
# archived packages are not dependency-solved by pacman.
readonly archiveBaseUrl="https://mirrors.huaweicloud.com/repository/msys2/mingw/mingw32"
readonly boostPackage="mingw-w64-i686-boost-1.85.0-4-any.pkg.tar.zst"
readonly downloadDirectory="${RUNNER_TEMP:-/tmp}/mingw32-archive"

mkdir -p "${downloadDirectory}"
for file in "${boostPackage}" "${boostPackage}.sig"; do
    curl --fail --location --retry 5 \
        "${archiveBaseUrl}/${file}" \
        --output "${downloadDirectory}/${file}"
done

pacman --noconfirm -U "${downloadDirectory}/${boostPackage}"
