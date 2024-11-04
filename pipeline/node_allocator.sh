#!/bin/bash

# This script allocates as many DI Server Cluster nodes as there are datasets.
# It passes to each node the script "handle_container.sh" with the respective attributes.
# Adjust the parameters DATASETS, MODELS, and ALLOCATION_TIME as needed.

#i want to run stratified, random, for each script
# should i deploy one container per each(6), or one per python script? the computations are nothing special, so ill occupy 6 nodes

# Define datasets and splits
TYPES=("crf")
DATA_SPLITS=("rand" "stratified")
ALLOCATION_TIME="1"  # in hours

# Initialize node counter
node_index=1

# Loop through each combination of TYPE and DATA_SPLIT
for i in "${!TYPES[@]}"; do
  for DATA_SPLIT in "${DATA_SPLITS[@]}"; do
    # Skip node 5 if occupied
    if [[ "$node_index" -eq 5 ]]; then
      echo "Skipping node $node_index due to occupation"
      ((node_index++))  # Increment to the next node
    fi

    # Submit a job for each TYPE and DATA_SPLIT combination
    oarsub -l {"network_address='alakazam-0$node_index'"},walltime="${ALLOCATION_TIME}:00:00" \
      "./handle_container.sh ${TYPES[$i]} $DATA_SPLIT"
    
    echo "Submitted job for TYPE=${TYPES[$i]}, DATA_SPLIT=$DATA_SPLIT on node alakazam-0$node_index"

    # Increment node index for the next allocation
    ((node_index++))
  done
done

exit
