ARG GOLANG_VERSION=1.19.0
ARG PYTHON_VERSION=3.9.13

FROM golang:${GOLANG_VERSION}-alpine AS foundation

ARG HELM_DOCS_VERSION=v1.11.0

RUN GO111MODULE=on go install -v github.com/norwoodj/helm-docs/cmd/helm-docs@${HELM_DOCS_VERSION}

FROM python:${PYTHON_VERSION}-alpine

LABEL maintainer="Burak Ince <burak.ince@linux.org.tr>"

WORKDIR /work

COPY --from=foundation /go/bin/ /go/bin/
ENV PATH="/go/bin:${PATH}"

ARG PRECOMMIT_VERSION=2.20.0

RUN apk add --update --no-cache \
    bash \
    grep \
    sed \
    gawk \
    git \
    curl \
    jq \
    openssh \
  && pip install pre-commit==$PRECOMMIT_VERSION

CMD [ "pre-commit", "--version" ]
