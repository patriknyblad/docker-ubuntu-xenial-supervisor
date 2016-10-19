# Builds a clean ubuntu image with Supervisor
#
# Supervisor can be used to run multiple processes inside a docker container.
# It is not mandatory to use but is nice to have when you need it further down
# the chain.

FROM ubuntu:xenial
MAINTAINER Patrik Nyblad <patrik.nyblad@gmail.com>

# Add locales after locale-gen as needed
# Upgrade packages on image
# Preparations for sshd
RUN locale-gen en_US.UTF-8

# Set language variables
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install Supervisor
RUN apt-get -q update &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew"  --no-install-recommends supervisor &&\
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

RUN mkdir -p /var/log/supervisor

# Copy supervisor configuration
COPY supervisord/supervisord.conf /etc/supervisor/
