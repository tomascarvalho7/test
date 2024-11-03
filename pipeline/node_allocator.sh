#!/bin/bash

# This script allocates as many DI Server Cluster nodes as there are datasets. It then passes to each one of those
# nodes the script "container_handler.sh" with the respective attributes. Change the parameters DATASETS, MODELS and
# ALLOCATION_TIME to your liking (MODELS has to have a model for every dataset in DATASETS, even if it repeats models).

#i want to run stratified, random, for each script
# should i deploy one container per each(6), or one per python script? the computations are nothing special, so ill occupy 6 nodes

TYPES=("crf" "token")
DATA_SPLITS=("rand" "stratified")
ALLOCATION_TIME="1"  # in hours

# Loop through each combination of TYPE and DATA_SPLIT
for i in "${!TYPES[@]}"; do
  for DATA_SPLIT in "${DATA_SPLITS[@]}"; do
    # Skip i=5 as the corresponding node is occupied
    if [[ "$i" -eq 5 ]]; then
      echo "Skipping node for TYPE=${TYPES[$i]} due to occupation on node 5"
      continue
    fi

    # Submit a job for each TYPE and DATA_SPLIT combination
    oarsub -l {"network_address='alakazam-0$((i+1))'"},walltime="${ALLOCATION_TIME}:00:00" \
      "./handle_container.sh ${TYPES[$i]} $DATA_SPLIT"
    
    echo "Submitted job for TYPE=${TYPES[$i]}, DATA_SPLIT=$DATA_SPLIT on node alakazam-0$((i+1))"
  done
done

exit