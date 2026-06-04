# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Docker image project that packages the [pre-commit](https://pre-commit.com/) Python library alongside [helm-docs](https://github.com/norwoodj/helm-docs) and common shell utilities (bash, grep, sed, gawk, git, gnupg, curl, jq, yq, openssh). The image is published to both Docker Hub (`burakince/pre-commit`) and GitHub Container Registry (`ghcr.io/burakince/pre-commit`).

## Key Files

- `Dockerfile` — multi-stage build: Go stage installs `helm-docs`, Python Alpine stage installs pip packages and apk tools
- `requirements.txt` — pin the `pre-commit` version here; Dependabot bumps it daily
- `.github/workflows/docker-publish.yml` — CI/CD pipeline that builds and pushes on merges to `main` and semver tags

## Local Development Commands

```bash
# Build the image locally
docker build -t pre-commit:local .

# Run the image (prints pre-commit version by default)
docker run --rm pre-commit:local

# Run with a specific command
docker run --rm pre-commit:local pre-commit --version
```

## CI/CD Pipeline

The GitHub Actions workflow (`docker-publish.yml`) triggers on:
- Pushes to `main` that touch `Dockerfile`, `requirements.txt`, or the workflow file itself
- All PRs to `main` (build only, no push)
- Semver tags (`*.*.*`) for release images

On merge/tag it:
1. Builds multi-arch images (`linux/amd64`, `linux/arm64/v8`, `linux/arm/v7`)
2. Pushes to Docker Hub and GHCR
3. Signs the image digest with Cosign (keyless, Sigstore)
4. Publishes an Artifact Hub manifest via ORAS to GHCR

Secrets required: `DOCKER_HUB_TOKEN` (Docker Hub push access).

## Dependency Updates

Dependabot runs daily across three ecosystems and groups all bumps:
- `pip-deps` — `requirements.txt` (pre-commit version)
- `docker-deps` — base images in `Dockerfile` (`golang:*-alpine`, `python:*-alpine`)
- `actions-deps` — GitHub Actions versions

When updating the Python version in the `FROM` line, verify the version exists on Docker Hub as an `-alpine` variant.

## Release Process

To publish a new versioned image tag, push a semver git tag:

```bash
git tag 1.2.3
git push origin 1.2.3
```

The workflow publishes both `:1.2.3` and `:latest` tags automatically.
