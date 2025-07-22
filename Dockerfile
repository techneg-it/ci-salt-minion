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
    && curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/debian/12/${ARCH}/SALT-PROJECT-GPG-PUBKEY-2023.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=${ARCH}] https://repo.saltproject.io/salt/py3/debian/12/${ARCH}/latest bookworm main" > /etc/apt/sources.list.d/salt.list \
    && :

RUN : \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       salt-minion \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && :
