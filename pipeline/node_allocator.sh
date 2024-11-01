#!/bin/bash

# This script allocates as many DI Server Cluster nodes as there are datasets. It then passes to each one of those
# nodes the script "container_handler.sh" with the respective attributes. Change the parameters DATASETS, MODELS and
# ALLOCATION_TIME to your liking (MODELS has to have a model for every dataset in DATASETS, even if it repeats models).

DATASETS=("conLL2003")
MODELS=("BAND")
MODEL_TYPE=""  # ['', word2vec, fasttext]
ALLOCATION_TIME="8"  # in hours

for i in "${!DATASETS[@]}"; do
  oarsub -l {"network_address='alakazam-0$((i+1))'"},walltime="${ALLOCATION_TIME}":00:00 "./container_handler.sh ${DATASETS[$i]} ${MODELS[$i]} ${MODEL_TYPE}"
done

exit
