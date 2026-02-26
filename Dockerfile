FROM alpine:latest AS build
ADD docker-entrypoint.sh /
RUN apk update && apk add --no-cache build-base btrfs-progs markdown tzdata git gcc pkgconfig linux-headers
RUN git clone https://github.com/Zygo/bees.git /usr/src/bees
RUN cd /usr/src/bees && make
RUN rm -rf /usr/src/bees

FROM alpine:latest
ENV TZ=Europe/Rome
ENV HASH_TABLE=/mnt/.beeshome/beeshash.dat
ENV HASH_TABLE_SIZE=4G
ENV CACHEDEV=cachedev_1

COPY --from=build /usr/src/bees/bin/bees /bin/bees
ADD docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]