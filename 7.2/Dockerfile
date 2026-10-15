#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

ARG VERSION=7.2.4.80712
ARG EDITION=AVX2
ARG SERVICE=OS

RUN FIRESTORM_URL="https://downloads.firestormviewer.org/release/linux/Phoenix-Firestorm${SERVICE}-Releasex64_${EDITION}-$(echo "$VERSION" | tr '.' '-').tar.xz" && \
	apt-get update && \
	apt-get install --no-install-recommends -y libatk1.0-0t64 libatk-bridge2.0-0t64 xz-utils curl && \
	curl -fsSL "$FIRESTORM_URL" -o /tmp/firestorm.tar.xz && \
	mkdir -p /opt/firestorm-install && \
	tar -xJf /tmp/firestorm.tar.xz -C /opt/firestorm-install --strip-components=1 && \
	chown root:root /opt/firestorm-install/bin/chrome-sandbox && \
	chmod 4755 /opt/firestorm-install/bin/chrome-sandbox && \
	cp -f /opt/firestorm-install/firestorm_48.png /usr/share/selkies/www/icon.png && \
	rm /tmp/firestorm.tar.xz && \
	apt-get purge -y curl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY /root /
COPY branding /etc/s6-overlay/s6-rc.d/init-adduser/branding

ENV TITLE="Firestorm Viewer" \
	NO_DECOR="true" \
	HARDEN_OPENBOX="true" \
	DISABLE_SUDO="true" \
	DISABLE_TERMINALS="true" \
	SELKIES_UI_SIDEBAR_SHOW_APPS="false"

EXPOSE 3000

VOLUME /config
