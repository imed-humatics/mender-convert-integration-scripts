FROM ubuntu:19.04

RUN apt-get update && apt-get install -y wget gcc-arm-linux-gnueabi gcc-aarch64-linux-gnu gcc-arm-linux-gnueabihf git build-essential bison flex bc u-boot-tools

# To provide support for Raspberry Pi Zero W a toolchain tuned for ARMv6 architecture must be used.
# https://tracker.mender.io/browse/MEN-2399
RUN wget -nc -q https://toolchains.bootlin.com/downloads/releases/toolchains/armv6-eabihf/tarballs/armv6-eabihf--glibc--stable-2018.11-1.tar.bz2 \
    && tar -xjf armv6-eabihf--glibc--stable-2018.11-1.tar.bz2 \
    && rm armv6-eabihf--glibc--stable-2018.11-1.tar.bz2

COPY build-uboot-bbb.sh /usr/local/bin/
COPY build-uboot-rpi.sh /usr/local/bin/
COPY build-uboot-opi.sh /usr/local/bin/

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
