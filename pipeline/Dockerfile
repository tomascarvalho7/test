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

# Set the working directory to the cloned repository's NER folder
WORKDIR /usr/src/app/test/ner

# Install Python packages from requirements.txt
RUN python3 -m pip install --upgrade pip && \
    pip install -r requirements.txt && pip install --upgrade setuptools wheel

# Run the training script
CMD ["./scripts/run_token_ner.sh"]

