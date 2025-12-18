#!/bin/bash

. ${UTILS_PATH}/ui.sh

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

br
banner "         >>> ubuntu/packages <<<       "
br
bash $CURRENT_DIR/packages.sh

br
banner "         >>> ubuntu/programs <<<       "
br
bash $CURRENT_DIR/programs.sh

br
banner "         >>> ubuntu/config <<<         "
br
bash $CURRENT_DIR/config.sh

br
