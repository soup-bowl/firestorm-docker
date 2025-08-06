FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

ARG VERSION=1.8.9.8338
ARG PLAT=x86_64

RUN apt-get update && \
	apt-get install -y \
 	libgtk2.0-0 \
 	gamemode \
	libatk1.0-0 \
	libvorbisfile3 \
	xz-utils && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN VERSION2=$(echo $VERSION | tr '.' '_') && \
    curl -L -o /tmp/viewer.tar.xz \
    https://github.com/singularity-viewer/SingularityViewer/releases/download/sv-${VERSION}-release/Singularity_${VERSION2}_${PLAT}.tar.xz && \
	mkdir -p /opt/viewer-install && \
	tar -xJf /tmp/viewer.tar.xz -C /opt/viewer-install --strip-components=1

COPY /root /

ENV TITLE="Singularity Viewer" \
	NO_DECOR="true"

EXPOSE 3000

VOLUME /config
