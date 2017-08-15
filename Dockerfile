FROM ubuntu:16.04
MAINTAINER Lyondon <snakeliwei@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
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
        wget
        
RUN mkdir -p /src && \
    git clone --depth=1 git://git.lede-project.org/source.git /src/lede && \
    /src/lede/scripts/feeds update -a && \
    /src/lede/scripts/feeds install -a

CMD cd /src/lede && git log -1 --pretty=format:"%h - %an, %ar: %s"
