#!/bin/bash

. ${UTILS_PATH}/packages.sh

REPOSITORIES=(
    bashtop-monitor/bashtop
)

for repo in ${REPOSITORIES[@]}; do
    addAptRepository $repo
done
