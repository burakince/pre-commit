ARG PYTHON_VERSION=3.9.12

FROM python:${PYTHON_VERSION}-alpine

LABEL maintainer="Burak Ince <burak.ince@linux.org.tr>"

WORKDIR /work

ARG PRECOMMIT_VERSION=2.18.0

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
