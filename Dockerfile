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
	perl \
	libc-dev \
	gcc \
	g++ \
	patch \
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
	ccache \
	tar \
	unzip \
	bzip2 \
	findutils \
	grep \
	libxslt-dev \
	pcre-dev \
	file \
	openssl-dev
        
RUN mkdir -p /src && \
    git clone https://git.lede-project.org/source.git /src/lede && \
    echo "src-git oldpackages http://git.openwrt.org/packages.git" >> /src/lede/feeds.conf.default && \
    /src/lede/scripts/feeds update -a && \
    /src/lede/scripts/feeds install -a

CMD cd /src/lede && git log -1 --pretty=format:"%h - %an, %ar: %s"
