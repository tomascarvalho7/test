#!/bin/bash

python3 -m venv myenv
source myenv/bin/activate
sudo apt update && sudo apt install python3.x

pip install --upgrade pip
pip install -r requirements.txt

bash ./scripts/run_token_ner.sh
