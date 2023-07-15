#!/usr/bin/env bash

set -e

# Locations
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="../home"
DOTBOT_DIR="../dotbot"
DOTBOT_BIN="bin/dotbot"

#
# Getting config file for host
#
unameOut="$(uname -a)"
MACHINE_TYPE="anonymous"
if [[ "$unameOut" =~ "mini-linux" ]]; then
    MACHINE_TYPE="server"
elif [[ "$unameOut" =~ "Linux" ]]; then
    MACHINE_TYPE="linux"
elif [[ "$unameOut" =~ "Darwin" ]]; then
    MACHINE_TYPE="macos"
fi

CONFIG_FILE="dotbot.${MACHINE_TYPE}.conf.yaml"
if ! [ -f "${BASEDIR}/$CONFIG_HOME/$CONFIG_FILE" ]; then
    echo "ERROR: $CONFIG_FILE does not exist. Aborting sync."
    exit 1
fi

cd "${BASEDIR}"
echo -e "\n>> 🔧 Using ${MACHINE_TYPE}'s config file => $CONFIG_FILE \n"

echo -e ">> ♻️  Submodules sync..."
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive || echo "Could not sync dotbot submodule"
echo -e ">> ♻️  Submodules update..."
git submodule update --init --recursive "${DOTBOT_DIR}" || echo "Could not update dotbot submodule"
echo -e ">> ♻️  Submodules pull...\n"
git pull --recurse-submodules && git submodule update

cd "${CONFIG_HOME}"
"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -q -c "${CONFIG_FILE}" "${@}"

exit 0
