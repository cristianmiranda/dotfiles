#!/bin/bash

. ${UTILS_PATH}/ui.sh

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

br
banner "         >>> linux/config <<<         "
br
bash $CURRENT_DIR/config.sh

br
banner "         >>> linux/sources <<<        "
br
bash $CURRENT_DIR/sources.sh

br
banner "         >>> linux/packages <<<       "
br
bash $CURRENT_DIR/packages.sh

br
banner "         >>> linux/programs <<<       "
br
bash $CURRENT_DIR/programs.sh

br
banner "         >>> linux/work <<<           "
br
bash $CURRENT_DIR/work.sh

br
