FROM ubuntu:latest AS build
ARG VERSION=v0.11
RUN apt update -y && apt -y install build-essential btrfs-progs markdown tzdata git gcc pkg-config systemd && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/Zygo/bees.git /usr/src/bees
WORKDIR /usr/src/bees
RUN git checkout ${VERSION}
RUN make all

FROM alpine:latest
ENV TZ=Europe/Rome
ENV HASH_TABLE=/mnt/.beeshome/beeshash.dat
ENV HASH_TABLE_SIZE=4G
ENV CACHEDEV=cachedev_1

COPY --from=build /usr/src/bees/bin/bees /bin/bees
ADD docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]