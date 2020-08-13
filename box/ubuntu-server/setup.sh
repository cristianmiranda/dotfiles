#!/bin/bash

. ${UTILS_PATH}/ui.sh

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

br
banner "        >>> server/packages <<<       "
br
bash $CURRENT_DIR/packages.sh

br
banner "        >>> server/programs <<<       "
br
bash $CURRENT_DIR/programs.sh

br
