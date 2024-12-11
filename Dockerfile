ARG GOLANG_VERSION=1.23.4
ARG PYTHON_VERSION=3.13.1

FROM golang:${GOLANG_VERSION}-alpine AS foundation

ARG HELM_DOCS_VERSION=v1.14.2

RUN GO111MODULE=on go install -v github.com/norwoodj/helm-docs/cmd/helm-docs@${HELM_DOCS_VERSION}

FROM python:${PYTHON_VERSION}-alpine

LABEL maintainer="Burak Ince <burak.ince@linux.org.tr>"

WORKDIR /work

COPY --from=foundation /go/bin/ /go/bin/
ENV PATH="/go/bin:${PATH}"

ARG PRECOMMIT_VERSION=4.0.1

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
