#!/usr/bin/env bash

set -e

# Locations
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="../home"
DOTBOT_DIR="../dotbot"
DOTBOT_BIN="bin/dotbot"

# Profiles
DOTBOT_MINIMAL="dotbot.minimal.conf.yaml"
DOTBOT_DESKTOP="dotbot.desktop.conf.yaml"
DOTBOT_SERVER="dotbot.server.conf.yaml"

# Fallback profile
DOTBOT_UNKNOWN=${DOTBOT_MINIMAL}

declare -A HOSTS_MAP
HOSTS_MAP["Linux-Virtual"]=${DOTBOT_DESKTOP} # Vagrant
HOSTS_MAP["Linux-MBP"]=${DOTBOT_DESKTOP}     # Main desktop
HOSTS_MAP["mini-linux"]=${DOTBOT_SERVER}     # Main server
HOSTS_MAP["raspberrypi"]=${DOTBOT_SERVER}

#
# Getting config file for host
#
CONFIG_FILE=${HOSTS_MAP[${HOSTNAME}]}
if ! [ -f "${BASEDIR}/$CONFIG_HOME/$CONFIG_FILE" ]; then
    echo "WARN: ${HOSTNAME}'s config => $CONFIG_FILE does not exist."
    CONFIG_FILE=${DOTBOT_UNKNOWN}
    echo "WARN: Fallbacking to $CONFIG_FILE."
fi

if ! [ -f "${BASEDIR}/$CONFIG_HOME/$CONFIG_FILE" ]; then
    echo "ERROR: $CONFIG_FILE does not exist. Aborting sync."
    exit 1;
fi

cd "${BASEDIR}";
echo -e ">> Using ${HOSTNAME}'s config file => $CONFIG_FILE \n"

git pull origin master || echo "Could not update repo. Maybe ssh-keys are out of date?"

git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive || echo "Could not sync dotbot submodule"
git submodule update --init --recursive "${DOTBOT_DIR}" || echo "Could not update dotbot submodule"

cd "${CONFIG_HOME}"
"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -q -c "${CONFIG_FILE}" "${@}"

exit 0
