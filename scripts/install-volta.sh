#!/bin/bash -xeu

# ---------------------------------------------------------
# Install Volta
# ---------------------------------------------------------
if ! (type "volta" > /dev/null 2>&1); then
    curl https://get.volta.sh | bash
fi
