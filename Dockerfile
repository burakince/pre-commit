FROM golang:1.24.2-alpine AS foundation

ARG HELM_DOCS_VERSION=v1.14.2

RUN GO111MODULE=on go install -v github.com/norwoodj/helm-docs/cmd/helm-docs@${HELM_DOCS_VERSION}

FROM python:3.14.0a7-alpine

LABEL maintainer="Burak Ince <burak.ince@linux.org.tr>"

WORKDIR /work

COPY --from=foundation /go/bin/ /go/bin/
ENV PATH="/go/bin:${PATH}"

COPY requirements.txt requirements.txt

RUN apk add --update --no-cache \
    bash \
    grep \
    sed \
    gawk \
    git \
    gnupg \
    curl \
    jq \
    yq \
    openssh \
  && pip install -r requirements.txt

CMD [ "pre-commit", "--version" ]
