#!/bin/bash

. ${UTILS_PATH}/packages.sh

REPOSITORIES=(
    bashtop-monitor/bashtop
    sicklylife/filezilla
    sicklylife/flameshot
    kgilmer/speed-ricer         # i3
    snwh/ppa                    # https://snwh.org/moka/download
    tista/adapta                # https://github.com/adapta-project/adapta-gtk-theme
)

for repo in ${REPOSITORIES[@]}; do
    addAptRepository $repo
done
