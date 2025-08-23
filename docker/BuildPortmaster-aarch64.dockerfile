FROM monkeyx/retro_builder:arm64
WORKDIR /usr/local/app

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential g++ wget ca-certificates \
    cmake ninja-build \
    libicu-dev zlib1g-dev \
    libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev \
    qtbase5-dev qttools5-dev libqt5svg5-dev \
    libavformat-dev libswscale-dev libtbb-dev libluajit-5.1-dev \
    libminizip-dev libfuzzylite-dev libsqlite3-dev \
 && rm -rf /var/lib/apt/lists/*

ARG BOOST_VERSION=1.88.0
ARG BOOST_DIR=boost_1_88_0
RUN set -eux; \
    url="https://archives.boost.io/release/${BOOST_VERSION}/source/${BOOST_DIR}.tar.gz"; \
    wget -O boost.tar.gz "$url"; \
    tar -xzf boost.tar.gz; \
    cd "${BOOST_DIR}"; \
    ./bootstrap.sh --with-libraries=filesystem,system,thread,program_options,locale,iostreams --prefix=/usr/local; \
    ./b2 -j"$(nproc)" cxxstd=17 link=shared runtime-link=shared threading=multi install; \
    ldconfig; \
    cd ..; rm -rf boost.tar.gz "${BOOST_DIR}"

# CMake /usr/local 
ENV BOOST_ROOT=/usr/local
ENV BOOST_INCLUDEDIR=/usr/local/include
ENV BOOST_LIBRARYDIR=/usr/local/lib
ENV CMAKE_PREFIX_PATH=/usr/local:${CMAKE_PREFIX_PATH}
ENV LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}


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
