#!/bin/bash

. ${UTILS_PATH}/ui.sh

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

br
banner "         >>> macOS/config <<<         "
br
bash $CURRENT_DIR/config.sh

br
banner "         >>> macOS/packages <<<       "
br
bash $CURRENT_DIR/packages.sh

br
banner "         >>> macOS/work <<<           "
br
bash $CURRENT_DIR/work.sh

br
