#!/bin/bash

# This script handles the spawn and output retrieval of a Docker container that trains a model.
# It builds and runs a container, and then retrieves both the results file and the trained model.

TYPE=$1
DATA_SPLIT=$2

# Build and run the container that trains and evaluates the models for NER
docker rm ner-pipeline-container && docker rmi ner-pipeline-image:latest
docker build --no-cache -f Dockerfile -t "ner-pipeline-image" --build-arg TYPE="${TYPE}" --build-arg DATA_SPLIT="${DATA_SPLIT}" .
docker run --gpus all --name "ner-pipeline-container" "ner-pipeline-image"

#get the script to run to define the output folder and results file name

# Source and destination dirs for all results
SOURCE_DIR="/usr/src/app/test/ner/output"
DEST_DIR="output"
mkdir -p ${DEST_DIR}

RESULTS_FILE="${TYPE}_${DATA_SPLIT}_final_results.json"

# Extract results files from the container
docker start ner-pipeline-container > /dev/null
docker exec ner-pipeline-container find "${SOURCE_DIR}" -name "${RESULTS_FILE}" -print0 | xargs -0 -I {} docker cp "ner-pipeline-container:{}" "${DEST_DIR}"
docker stop ner-pipeline-container > /dev/null
