# This Dockerfile builds an image that is able to train a model with CUDA. It installs the necessary packages,
# dependencies, and GitHub repository, and then runs a script that trains the model for NER. It is NOT meant to
# be interactive.

# Use the NVIDIA CUDA runtime as a parent image
FROM nvidia/cuda:11.4.3-cudnn8-runtime-ubuntu20.04

# Set the working directory in the container
WORKDIR /usr/src/app

# Install the necessary packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone GitHub repo
RUN git clone https://github.com/tomascarvalho7/test

# Run the training script
CMD cd test/band_testing/ner && ./setup_and_run.sh; 
