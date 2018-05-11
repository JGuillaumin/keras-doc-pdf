FROM ubuntu:16.04

MAINTAINER @jguillaumin

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    unzip \
    build-essential \
    curl \
    libfreetype6-dev \
    libpng12-dev \
    libzmq3-dev \
    pkg-config \
    rsync \
    software-properties-common \
    python3-dev \
    language-pack-de \
    fonts-lmodern \
    lmodern \
    pandoc \
    texlive-base \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-latex-recommended \
    texlive-xetex
# && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*

RUN locale-gen "en_US.UTF-8"

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

ADD https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh tmp/Miniconda3-latest-Linux-x86_64.sh
RUN bash tmp/Miniconda3-latest-Linux-x86_64.sh -b
ENV PATH $PATH:/root/miniconda3/bin/

RUN conda create -n keras-doc pip python=3.5

RUN mkdir /src
WORKDIR "/src"


COPY run.sh /
RUN chmod +x /run.sh
ENTRYPOINT ["/run.sh"]
