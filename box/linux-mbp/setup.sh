#!/bin/bash

. ${UTILS_PATH}/ui.sh

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

br
banner "         >>> mbp/packages <<<         "
br
bash $CURRENT_DIR/packages.sh
br
banner "          >>> mbp/config <<<          "
br
bash $CURRENT_DIR/config.sh
br
banner "         >>> mbp/programs <<<         "
br
bash $CURRENT_DIR/programs.sh
br
