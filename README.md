# Docker Image for pre-commit python library

A multi-arch Docker image bundling the [pre-commit](https://pre-commit.com/) Python library alongside [helm-docs](https://github.com/norwoodj/helm-docs) and common shell utilities (`bash`, `grep`, `sed`, `gawk`, `git`, `gnupg`, `curl`, `jq`, `yq`, `openssh`).

Images are available on [Docker Hub](https://hub.docker.com/r/burakince/pre-commit) and [GitHub Container Registry](https://github.com/burakince/pre-commit/pkgs/container/pre-commit).

**Supported platforms:** `linux/amd64`, `linux/arm64/v8`, `linux/arm/v7`

## Usage

```console
docker run --rm burakince/pre-commit
```

```console
docker run --rm ghcr.io/burakince/pre-commit
```
