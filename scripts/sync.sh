#!/usr/bin/env bash

set -e

# Locations
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="../home"
DOTBOT_DIR="../dotbot"
DOTBOT_BIN="bin/dotbot"

# Profiles
DOTBOT_ANONYMOUS="dotbot.anonymous.conf.yaml"
DOTBOT_LINUX="dotbot.linux.conf.yaml"
DOTBOT_SERVER="dotbot.server.conf.yaml"
DOTBOT_MACOS="dotbot.macos.conf.yaml"

# Fallback profile
DOTBOT_UNKNOWN=${DOTBOT_ANONYMOUS}

declare -A HOSTS_MAP
HOSTS_MAP["linux-docker"]=${DOTBOT_LINUX}       # Linux Docker
HOSTS_MAP["Linux-Virtual"]=${DOTBOT_LINUX}      # Vagrant, Parallels, Virtualbox
HOSTS_MAP["virt-manager"]=${DOTBOT_LINUX}       # Virt Manager
HOSTS_MAP["dell-latitude"]=${DOTBOT_LINUX}      # Dell Latitude
HOSTS_MAP["x1-extreme"]=${DOTBOT_LINUX}         # Lenovo X1 Extreme
HOSTS_MAP["Linux-MBP"]=${DOTBOT_LINUX}          # Linux Desktop
HOSTS_MAP["mini-linux"]=${DOTBOT_SERVER}        # Linux Server
HOSTS_MAP["raspberrypi"]=${DOTBOT_SERVER}       # Raspberry Pi 3/4
HOSTS_MAP["Cristians-MBP"]=${DOTBOT_MACOS}      # macOS 15
HOSTS_MAP["CristiansMBP13"]=${DOTBOT_MACOS}     # macOS 13

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
echo -e "\n>> Using ${HOSTNAME}'s config file => $CONFIG_FILE \n"

# git pull origin master || echo "Could not update repo. Maybe ssh-keys are out of date?"

echo -e ">> Submodules sync..."
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive || echo "Could not sync dotbot submodule"
echo -e ">> Submodules update..."
git submodule update --init --recursive "${DOTBOT_DIR}" || echo "Could not update dotbot submodule"
echo -e ">> Submodules pull...\n"
git pull --recurse-submodules && git submodule update

cd "${CONFIG_HOME}"
"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -q -c "${CONFIG_FILE}" "${@}"

exit 0
