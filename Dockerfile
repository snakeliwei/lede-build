FROM ubuntu:16.04
MAINTAINER Lyondon <snakeliwei@gmail.com>

RUN apt-get update && \
    apt-get install \
    subversion \
    g++ \
    zlib1g-dev \
    build-essential \
    git \
    python \
    rsync \
    man-db \
    libncurses5-dev \
    gawk \
    gettext \
    unzip \
    file \
    libssl-dev \
    wget  && \
    mkdri -p /src
    git clone https://git.lede-project.org/source.git /src/lede && \
    /src/lede/scripts/feeds update -a && \
    /src/lede/scripts/feeds install -a

CMD cd /src/lede && git log -1 --pretty=format:"%h - %an, %ar: %s"
