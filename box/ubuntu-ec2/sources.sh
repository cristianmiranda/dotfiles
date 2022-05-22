#!/bin/bash

. ${UTILS_PATH}/packages.sh

REPOSITORIES=(
)

for repo in ${REPOSITORIES[@]}; do
    addAptRepository $repo
done
