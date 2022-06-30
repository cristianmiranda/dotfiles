#!/bin/bash

. ${UTILS_PATH}/ui.sh

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

br
banner "         >>> linux/packages <<<       "
br
bash $CURRENT_DIR/../arch/packages.sh

br
banner "         >>> linux/programs <<<       "
br
bash $CURRENT_DIR/../arch/programs.sh

br
banner "         >>> linux/config <<<         "
br
bash $CURRENT_DIR/config.sh

br
banner "         >>> linux/work <<<           "
br
bash $CURRENT_DIR/../arch/work.sh

br
