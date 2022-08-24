# SPDX-License-Identifier: BSD-3-Clause
# Copyright 2021-2022, Intel Corporation

#
# Dockerfile - a 'recipe' for Docker to build an image of ubuntu-based
#              environment prepared for running pmemstream tests.
#

# Pull base image
FROM ghcr.io/pmem/dev-utils-kit:ubuntu-21.10-latest
MAINTAINER igor.chorazewicz@intel.com

ENV PMDK_VERSION ab3fc0b7f1f519ce0050dc77d4fdb8b3fcba760c

# use 'root' while building the image
USER root

# Install all PMDK packages
RUN /opt/install-pmdk.sh /opt/pmdk/

# Install rapidcheck
COPY install-rapidcheck.sh install-rapidcheck.sh
RUN ./install-rapidcheck.sh

COPY install-miniasync.sh install-miniasync.sh
RUN ./install-miniasync.sh

# switch back to regular user
USER ${USER}
