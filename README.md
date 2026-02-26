# theredcyclops/bees-docker
## Based on the work by (deatheibon)[https://github.com/deatheibon]

Dockerized Best-Effort Extent-Same btrfs deduplication agent.
https://github.com/Zygo/bees

This image is based on Alpine Linux with bees agent from stable repositories. 

## Usage

Mount BTRFS root subvolume to /mnt for example like: 

mount /dev/"device" /mnt -o subvol=/

adjust the docker-compose volumes section. 

## docker run

### daemonized
docker run -d --privileged -e HASH_TABLE=/mnt/.beeshome/beeshash.dat -e HASH_TABLE_SIZE=4G -e OPTIONS=-a -v /mnt:/mnt rylos/bees-docker

### interactive
docker run -ti --privileged -e HASH_TABLE=/mnt/.beeshome/beeshash.dat -e HASH_TABLE_SIZE=4G -e OPTIONS=-a -v /mnt:/mnt rylos/bees-docker

## docker-compose
```version: '3.3'
services:
  beesd:
    container_name: beesd
    privileged: true
    restart: unless-stopped
    hostname: beesd
    image: theredcyclops/beesd:latest
    environment:
      - TZ=Europe/Rome
      - HASH_TABLE=/mnt/.beeshome/beeshash.dat
      - HASH_TABLE_SIZE=4G
      - CACHEDEV=cachedev_1
    command: -a -c 1

    volumes:
      - /mnt:/mnt
```
