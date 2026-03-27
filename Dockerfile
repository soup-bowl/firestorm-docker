FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

ARG VERSION=7-1-11-76496

ARG FIRESTORM_URL=https://downloads.firestormviewer.org/release/linux/Phoenix-FirestormOS-Releasex64_AVX2-${VERSION}.tar.xz

ADD $FIRESTORM_URL /tmp/firestorm.tar.xz

# libgl1-mesa-dri      - Mesa DRI/GBM drivers (required for AMD & Intel GPU acceleration)
# mesa-va-drivers      - VA-API drivers for AMD GPUs
# intel-media-va-driver - VA-API drivers for modern Intel GPUs
# i965-va-driver       - VA-API drivers for older Intel GPUs (e.g. Haswell)
RUN apt-get update && \
	apt-get install -y \
		libatk1.0-0t64 \
		xz-utils \
		libgl1-mesa-dri \
		mesa-va-drivers \
		intel-media-va-driver \
		i965-va-driver \
	&& apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/firestorm-install && \
	tar -xJf /tmp/firestorm.tar.xz -C /opt/firestorm-install --strip-components=1

COPY /root /

ENV TITLE="Firestorm Viewer"

EXPOSE 3000

VOLUME /config
