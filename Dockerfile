FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

ARG VERSION=7-2-3-80036

ARG FIRESTORM_URL=https://downloads.firestormviewer.org/release/linux/Phoenix-FirestormOS-Releasex64_AVX2-${VERSION}.tar.xz

ADD $FIRESTORM_URL /tmp/firestorm.tar.xz

RUN apt-get update && \
	apt-get install --no-install-recommends -y libatk1.0-0t64 libatk-bridge2.0-0t64 xz-utils && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/firestorm-install && \
	tar -xJf /tmp/firestorm.tar.xz -C /opt/firestorm-install --strip-components=1 && \
	chown root:root /opt/firestorm-install/bin/chrome-sandbox && \
	chmod 4755 /opt/firestorm-install/bin/chrome-sandbox && \
	cp -f /opt/firestorm-install/firestorm_48.png /usr/share/selkies/www/icon.png

COPY /root /
COPY branding /etc/s6-overlay/s6-rc.d/init-adduser/branding

ENV TITLE="Firestorm Viewer" \
	NO_DECOR="true"

EXPOSE 3000

VOLUME /config
