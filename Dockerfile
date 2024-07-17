FROM debian:bookworm-slim

ARG TARGETPLATFORM

SHELL ["/bin/bash", "-x", "-o", "pipefail", "-c"]
RUN : \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       ca-certificates curl \
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
