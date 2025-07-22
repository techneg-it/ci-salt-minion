FROM debian:bookworm-slim@sha256:2424c1850714a4d94666ec928e24d86de958646737b1d113f5b2207be44d37d8

ARG TARGETPLATFORM

SHELL ["/bin/bash", "-x", "-o", "pipefail", "-c"]
RUN : \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       ca-certificates curl git \
    && :

RUN : \
    && ARCH="${TARGETPLATFORM#*/}" \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring.pgp https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public \
    && curl -fsSL -o /etc/apt/sources.list.d/salt.sources https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources \
    && :

RUN : \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       salt-minion \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && :
