ARG BASE_IMAGE=nvcr.io/nvidia/l4t-pytorch:r32.5.0-pth1.6-py3
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL /bin/bash

WORKDIR jetstream


#
# install pre-requisite packages
#
RUN apt-get update && \
    apt-get install -y --no-install-recommends cmake \
    && rm -rf /var/lib/apt/lists/*
    
# pip dependencies for pytorch-ssd
RUN pip3 install --verbose --upgrade Cython

# alias python3 -> python
RUN rm /usr/bin/python && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip
    
#
# copy source
#
COPY src src
COPY CMakeLists.txt CMakeLists.txt

#
# build source
#
RUN mkdir build && \
    cd build && \
    cmake ../ && \
    make -j$(nproc) && \
    /bin/bash -O extglob -c "cd /jetstream/build; rm -rf -v !(aarch64|download-models.*)" && \
    rm -rf /var/lib/apt/lists/*
    
