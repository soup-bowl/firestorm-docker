FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

ARG VERSION=7-1-11-76496

ARG FIRESTORM_URL=https://downloads.firestormviewer.org/release/linux/Phoenix-FirestormOS-Releasex64_AVX2-${VERSION}.tar.xz

ADD $FIRESTORM_URL /tmp/firestorm.tar.xz

RUN apt-get update && \
	apt-get install -y xz-utils && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/firestorm-install && \
	tar -xJf /tmp/firestorm.tar.xz -C /opt/firestorm-install --strip-components=1

COPY /root /

ENV TITLE="Firestorm Viewer"

EXPOSE 3000

VOLUME /config
