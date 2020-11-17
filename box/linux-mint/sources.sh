#!/bin/bash

. ${UTILS_PATH}/packages.sh

REPOSITORIES=(
    sicklylife/filezilla
    sicklylife/flameshot
    kgilmer/speed-ricer         # i3
    snwh/ppa                    # https://snwh.org/moka/download
    tista/adapta                # https://github.com/adapta-project/adapta-gtk-theme
    alessandro-strada/ppa       # https://github.com/astrada/google-drive-ocamlfuse
    agornostal/ulauncher        # https://ulauncher.io/
)

for repo in ${REPOSITORIES[@]}; do
    addAptRepository $repo
done

aptUpdate
