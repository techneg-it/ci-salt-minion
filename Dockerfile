FROM debian:bookworm-slim

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
