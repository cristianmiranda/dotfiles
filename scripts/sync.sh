#!/usr/bin/env bash

set -e

# Locations
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="../home"
DOTBOT_DIR="../dotbot"
DOTBOT_BIN="bin/dotbot"

# Clone dotbot if $DOBTOB_DIR does not exist
if ! [ -d "${BASEDIR}/${DOTBOT_DIR}" ]; then
  echo -e "\n>> 📦 Cloning dotbot...\n"
  git clone git@github.com:anishathalye/dotbot.git || wget -O dotbot.zip https://github.com/anishathalye/dotbot/archive/refs/heads/master.zip && unzip dotbot.zip && mv dotbot-master dotbot && rm dotbot.zip
else
  echo -e "\n>> 📦 Updating dotbot...\n"
  git -C "${BASEDIR}/${DOTBOT_DIR}" pull || echo "Couldn't update dotbot repo"
fi

#
# Getting config file for host
#
unameOut="$(uname -a)"
MACHINE_TYPE="anonymous"
if [[ "$unameOut" =~ "mini-linux" ]] || [[ "$unameOut" =~ "devbox" ]]; then
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

# Use venv Python if available, otherwise use system Python
PYTHON_BIN="python3"
if [ -f "$HOME/venv/bin/python3" ]; then
    PYTHON_BIN="$HOME/venv/bin/python3"
    echo -e ">> 🐍 Using venv Python: $PYTHON_BIN\n"
fi

cd "${CONFIG_HOME}"
"$PYTHON_BIN" "${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -q -c "${CONFIG_FILE}" "${@}"

exit 0
