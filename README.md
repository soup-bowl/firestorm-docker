<h1 align="center">Firestorm Web</h1>
<p align="center"><strong>Unofficial</strong></p>

<p align="center">
  <img src="https://f.subo.dev/i/o/fvd1.webp" alt="Screenshot from inside the Firestorm Metaverse client contained within the Firefox web browser, showing a duck floating in a pool of water, with a small green landmass and the open sky in the background" />
</p>

Run **[Firestorm Viewer][fs]** in a web-accessible Docker/Podman container, similar to **Second Life Zero**. Built upon the [Selkies Linuxserver base image][selkies].

> [!WARNING]  
> This is **pre-pre-pre-alpha**. Use at your own risk. There is also a [Singularity Viewer edition](https://github.com/soup-bowl/singularity-docker).

## Quickstart

> [!IMPORTANT]  
> This instruction gets you up and running, but comes with no security guardrails. **Use at your own risk**, and absolutely **do not use in a shared environment**.

To run the server, use the following command (or [see the Docker Compose file](/docker-compose.yml)):

```sh
docker run -d \
  --name firestorm-web \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 3000:3000 \
  -p 3001:3001 \
  ghcr.io/soup-bowl/firestorm-docker:edge
```

Add:

* `-v ./config:/config` for configuration persistence.
* `--security-opt seccomp=unconfined` for older systems with seccomp issues.
* `--device /dev/dri:/dev/dri` to give the container GPU access.
  * `--group-add video` may also be needed.

This will make an instance available on http://localhost:3000. For further configuration, see the [base image documentation][selkies].

[fs]: https://www.firestormviewer.org/
[selkies]: https://github.com/linuxserver/docker-baseimage-selkies
