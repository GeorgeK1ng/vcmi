FROM monkeyx/retro_builder:arm64
WORKDIR /usr/local/app

ENV DEBIAN_FRONTEND=noninteractive

# From VCMI build docs
# RUN apt update && apt install -y cmake g++ clang libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev libsdl2-mixer-dev zlib1g-dev libavformat-dev libswscale-dev libboost-dev libboost-filesystem-dev libboost-system-dev libboost-thread-dev libboost-program-options-dev libboost-locale-dev libboost-iostreams-dev qtbase5-dev libtbb-dev libluajit-5.1-dev liblzma-dev libsqlite3-dev qttools5-dev ninja-build ccache



RUN apt update && apt install -y --no-install-recommends \
    build-essential wget ca-certificates \
    libicu-dev zlib1g-dev libbz2-dev \
    libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev \
    qtbase5-dev qttools5-dev libqt5svg5-dev \
    ninja-build libavformat-dev libswscale-dev \
    libtbb-dev libluajit-5.1-dev libminizip-dev libfuzzylite-dev libsqlite3-dev \
 && rm -rf /var/lib/apt/lists/*


ARG BOOST_VERSION=1.88.0
ARG BOOST_DIR=boost_1_88_0
RUN set -eux; \
  wget -O boost.tar.gz "https://archives.boost.io/release/${BOOST_VERSION}/source/${BOOST_DIR}.tar.gz"; \
  tar -xzf boost.tar.gz; cd "${BOOST_DIR}"; \
  ./bootstrap.sh --prefix=/usr/local; \
  ./b2 -j"$(nproc)" cxxstd=17 link=shared runtime-link=shared threading=multi \
      --with-filesystem --with-system --with-thread --with-program_options \
      --with-locale --with-iostreams --with-date_time --with-regex \
      --with-chrono --with-atomic \
      install; \
  ldconfig; cd ..; rm -rf boost.tar.gz "${BOOST_DIR}"


# CMake >= 3.31 (presets support)
ARG CMAKE_VER=3.31.5
RUN set -eux; \
  wget -q https://github.com/Kitware/CMake/releases/download/v${CMAKE_VER}/cmake-${CMAKE_VER}-linux-aarch64.tar.gz; \
  tar -xzf cmake-${CMAKE_VER}-linux-aarch64.tar.gz -C /opt; \
  ln -s /opt/cmake-${CMAKE_VER}-linux-aarch64/bin/* /usr/local/bin/; \
  rm -f cmake-${CMAKE_VER}-linux-aarch64.tar.gz; \
  cmake --version


CMD ["sh", "-c", " \
    # switch to mounted dir
    cd /vcmi ; \
    # fix for wrong path of base image
    ln -s /usr/lib/libSDL2.so /usr/lib/aarch64-linux-gnu/libSDL2.so ; \
    # build
    cmake --preset portmaster-release ; \
    cmake --build --preset portmaster-release ; \
    # export missing libraries
    ldd /vcmi/out/build/portmaster-release/bin/vcmiclient | grep -e libboost -e libtbb -e libicu | awk 'NF == 4 { system(\"cp \" $3 \" /vcmi/out/build/portmaster-release/bin/\") }' \
"]

# Build on ARM64 processor or ARM64 chroot with:
#      docker build -f docker/BuildPortmaster-aarch64.dockerfile -t vcmi-portmaster-build .
#      docker run -it --rm -v $PWD/:/vcmi vcmi-portmaster-build
# Build on ARM64 processor or ARM64 chroot with:
#      docker build -f docker/BuildPortmaster-aarch64.dockerfile -t vcmi-portmaster-build .
#      docker run -it --rm -v $PWD/:/vcmi vcmi-portmaster-build
