#!/bin/bash

python3 -m venv myenv
source myenv/bin/activate
pip install -r requirements.txt

bash ./scripts/run_token_ner.sh
