#!/usr/bin/env bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd ${BASEDIR}
/usr/bin/git-secret reveal -f
