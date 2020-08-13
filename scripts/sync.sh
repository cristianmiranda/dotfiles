#!/usr/bin/env bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="../home"
DOTBOT_DIR="../dotbot"
DOTBOT_BIN="bin/dotbot"
CONFIG_FILE="install.${HOSTNAME}.conf.yaml"

if ! [ -f "${BASEDIR}/$CONFIG_HOME/$CONFIG_FILE" ]; then
    CONFIG_FILE="install.conf.yaml"
fi

if ! [ -f "${BASEDIR}/$CONFIG_HOME/$CONFIG_FILE" ]; then
    echo "ERROR: $CONFIG_FILE does not exist. Aborting sync."
    exit 1;
fi

cd "${BASEDIR}";
echo -e ">> USING FILE: $CONFIG_FILE\n"

git pull origin master || echo "Could not update repo. Maybe ssh-keys are out of date?"

git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive || echo "Could not sync dotbot submodule"
git submodule update --init --recursive "${DOTBOT_DIR}" || echo "Could not update dotbot submodule"

cd "${CONFIG_HOME}"
"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -q -c "${CONFIG_FILE}" "${@}"

exit 0
