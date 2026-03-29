<h1 align="center">Firestorm Web</h1>
<p align="center"><strong>Unofficial</strong></p>

<p align="center">
  <img src="https://f.subo.dev/i/o/fvd1.webp" alt="Screenshot from inside the Firestorm Metaverse client contained within the Firefox web browser, showing a duck floating in a pool of water, with a small green landmass and the open sky in the background" />
</p>

Run **[Firestorm Viewer][fs]** in a web-accessible Docker/Podman container, similar to **Second Life Zero**. Built upon the [Selkies Linuxserver base image][selkies].

> [!WARNING]  
> This is **pre-pre-pre-alpha**. Use at your own risk. There is also a [Singularity Viewer edition](https://github.com/soup-bowl/singularity-docker).

## Supported tags

Version refers to the [Firestorm version](https://wiki.firestormviewer.org/downloads). **Tags outside of this are not updated**

-	[`edge`, `7`, `7.2`](https://github.com/soup-bowl/firestorm-docker/blob/main/build/latest/Dockerfile)
- [`7.1`](https://github.com/soup-bowl/firestorm-docker/blob/main/build/latest/Dockerfile)

## Quickstart

> [!IMPORTANT]  
> This instruction gets you up and running, but comes with no security guardrails. **Use at your own risk**, and absolutely **do not use in a shared environment**.

To run the server, use the following command (or [see the Docker Compose file](/docker-compose.yml)):

```sh
docker run -d \
  --name firestorm-web \
  --security-opt seccomp=unconfined \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 3000:3000 \
  -p 3001:3001 \
  ghcr.io/soup-bowl/firestorm-docker:edge
```

(append `-opensim` for OpenSimulator support)

Add:

* `-v ./config:/config` for configuration persistence.
* `--security-opt seccomp=unconfined` generally needed due to the presence of [CEF](https://github.com/chromiumembedded/cef) in Firestorm - see [#5](https://github.com/soup-bowl/firestorm-docker/issues/5).
* `--device /dev/dri:/dev/dri` to give the container GPU access.
  * `--group-add video` may also be needed.

This will make an instance available on http://localhost:3000. For further configuration, see the [base image documentation][selkies].

## Usage Tips

* **This isn't one instance per user** - if another person accesses the URL, they'll see the same as you.
  * If you plan to make a public service, you will need some form of authentication layer, plus a container spin-up per user, and config state persistence.
  * If it's **just for you**, Selkies base image supports basic HTTP auth. Authentication hygiene is recommended (MFA on, don't save password, etc).
* Fine movements are basically impossible without giving it exclusive mouse lock. Press `Ctrl - Shift - Left Click` to do so, and press `esc` to exit.
* Unless you change the `HARDEN_OPENBOX` env, quitting Firestorm will re-open the application.
* This application wasn't designed for this, so there can be some unexpected hard crashes - restarting the container is the best action.
* You can verify if your GPU is being correctly passed-through by doing to **help** > **About Firestorm**, and looking at the **Graphics Card** options.

## Run in the Cloud

> [!WARNING]  
> These are for **experimental purposes only** - Do not use these if you do not understand why a missing auth layer is a security risk.

Vast.ai VM, no auth layer: [Template](https://cloud.vast.ai/?ref_id=453893&creator_id=453893&name=Firestorm%20Viewer%20VM%20(no%20auth%20layer))

[fs]: https://www.firestormviewer.org/
[selkies]: https://github.com/linuxserver/docker-baseimage-selkies
