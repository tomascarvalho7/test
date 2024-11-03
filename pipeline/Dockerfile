# Use the NVIDIA CUDA runtime as a parent image
FROM nvidia/cuda:11.4.3-cudnn8-runtime-ubuntu20.04

# Set the working directory in the container
WORKDIR /usr/src/app

# Install the necessary packages and Python 3.12
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    python3.12 \
    python3.12-distutils \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set Python 3.12 as the default Python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1

# Clone GitHub repo
RUN git clone https://github.com/tomascarvalho7/test

# Run the training script
CMD cd test/band_testing/ner && ./setup_and_run.sh

