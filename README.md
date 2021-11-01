# Electrumx Peer node

Launch your electrumx peer node for BitcoinSV

## Change your domain

Edit ```.env``` file
## Run

```
docker-compose up -d
```

## Buildx by buildx and push to docker.io
Enable buildx
```
set DOCKER_CLI_EXPERIMENTAL=true
docker buildx --help
```

Build linux on x64
```
docker buildx build . --platform=linux/386 -t baryon/electrumx-linux-386:1.20.2 -o type=registry
```

Build linux on arm64
```
docker buildx build . --platform=linux/arm64 -t baryon/electrumx-linux-arm64:1.20.2 -o type=registry
```


Based on
https://hub.docker.com/r/bitcoinsv/bitcoin-sv

https://github.com/kyuupichan/electrumx

Inspired from
https://hub.docker.com/r/lukechilds/electrumx


Doc:
https://electrumx.readthedocs.io/en/latest/

License
MIT © ChainBow Team.
