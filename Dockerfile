ARG DISTRO_VERSION=12-slim

FROM debian:${DISTRO_VERSION} AS install

SHELL ["/bin/bash", "-x", "-o", "pipefail", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

COPY files/salt-archive-keyring.pgp /etc/apt/keyrings/
COPY files/salt.sources /etc/apt/sources.list.d/

# renovate: datasource=repology depName=debian_12/ca-certificates versioning=deb
ARG CA_CERTS_VERSION=20230311+deb12u1
RUN : \
    && apt-get update \
    && apt-get install --yes --no-install-recommends \
         ca-certificates \
    && :

ARG PIN_FILENAME=salt-pin-1001
ARG SALT_VERSION=3006.14
RUN : \
    && echo 'Package: salt-*' > /etc/apt/preferences.d/${PIN_FILENAME} \
    && echo "Pin: version ${SALT_VERSION}" >> /etc/apt/preferences.d/${PIN_FILENAME} \
    && echo 'Pin-Priority: 1001' >> /etc/apt/preferences.d/${PIN_FILENAME} \
    && :

RUN : \
    && apt-get update \
    && apt-get install --yes --no-install-recommends \
         salt-minion=${SALT_VERSION} \
    && :

FROM install AS update

SHELL ["/bin/bash", "-x", "-o", "pipefail", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

RUN : \
    && apt-get update \
    && apt-get install --yes --no-install-recommends \
         git \
    && :

RUN : \
    && apt-get update \
    && apt-get upgrade --yes \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && :
