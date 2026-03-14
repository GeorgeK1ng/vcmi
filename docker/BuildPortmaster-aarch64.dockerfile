FROM monkeyx/retro_builder:arm64
WORKDIR /usr/local/app

ENV DEBIAN_FRONTEND=noninteractive

# Runtime build dependencies for PortMaster + Conan toolchain restore
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential wget ca-certificates git curl \
    python3 python3-pipx \
    libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev \
    qtbase5-dev qttools5-dev libqt5svg5-dev \
    ninja-build libavformat-dev libswscale-dev \
    libluajit-5.1-dev libminizip-dev libsqlite3-dev \
    libicu-dev zlib1g-dev libbz2-dev liblzma-dev \
 && rm -rf /var/lib/apt/lists/*

# CMake >= 3.31 (presets support)
ARG CMAKE_VER=3.31.5
RUN set -eux; \
  wget -q https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-linux-aarch64.tar.gz; \
  tar -xzf cmake-${CMAKE_VER}-linux-aarch64.tar.gz -C /opt; \
  ln -s /opt/cmake-${CMAKE_VER}-linux-aarch64/bin/* /usr/local/bin/; \
  rm -f cmake-${CMAKE_VER}-linux-aarch64.tar.gz; \
  cmake --version

RUN pipx install conan

CMD ["sh", "-c", " \
    set -euo pipefail; \
    cd /vcmi; \
    # fix for wrong path of base image \
    ln -sf /usr/lib/libSDL2.so /usr/lib/aarch64-linux-gnu/libSDL2.so; \
    export PATH=/root/.local/bin:${PATH}; \
    export RUNNER_TEMP=/tmp; \
    # restore linux ARM64 prebuilt Conan dependencies and generate toolchain \
    source /vcmi/CI/install_conan_dependencies.sh dependencies-linux-arm64; \
    conan profile detect --force; \
    conan install . \
      --output-folder=conan-generated \
      --build=never \
      --profile=dependencies/conan_profiles/linux-arm64 \
      --conf=tools.cmake.cmaketoolchain:generator=Ninja; \
    # build \
    cmake --preset portmaster-conan-release; \
    cmake --build --preset portmaster-conan-release; \
    # export missing shared libraries \
    ldd /vcmi/out/build/portmaster-conan-release/bin/vcmiclient | grep -e libboost -e libtbb -e libicu | awk 'NF == 4 { system(\"cp \" $3 \" /vcmi/out/build/portmaster-conan-release/bin/\") }' \
"]

# Build on ARM64 processor or ARM64 chroot with:
#      docker build -f docker/BuildPortmaster-aarch64.dockerfile -t vcmi-portmaster-build .
#      docker run -it --rm -v $PWD/:/vcmi vcmi-portmaster-build
