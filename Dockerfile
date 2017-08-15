FROM alpine:3.6
MAINTAINER Lyondon <snakeliwei@gmail.com>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN addgroup -S lede && adduser -S -G lede lede

# grab su-exec for easy step-down from root
RUN apk add --no-cache \
                'su-exec>=0.2' \
                ca-certificates \
                bash \
                coreutils \
		gcc \
		linux-headers \
		make \
		musl-dev \
                git \
                subversion \
                python \
                gawk \
                gettext \
                wget \
                ncurses-dev \
                zlib-dev \
                libxslt-dev \
                file \
                openssl-dev
        
RUN mkdir -p /src && \
    git clone --depth=1 git://git.lede-project.org/source.git /src/lede && \
    /src/lede/scripts/feeds update -a && \
    /src/lede/scripts/feeds install -a

CMD cd /src/lede && git log -1 --pretty=format:"%h - %an, %ar: %s"
