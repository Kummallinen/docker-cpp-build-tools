FROM ubuntu:16.04

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      git \
      gnupg \
      openjdk-8-jdk \
      wget \
      zip \
      locales \
      build-essential \
      cmake \
      ninja \
      gcc-4.9 g++-4.9 \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8
# Need locale to be UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN [ -f "/etc/ssl/certs/java/cacerts" ] || /var/lib/dpkg/info/ca-certificates-java.postinst configure

# Match to Jenkins JNLP container user
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
RUN groupadd -g ${gid} ${group} && useradd jenkins -u ${uid} -g ${gid} --shell /bin/bash --create-home

USER jenkins
WORKDIR /home/jenkins