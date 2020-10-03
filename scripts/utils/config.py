#!/usr/bin/env python3

import os
import platform
import yaml


def getConfig():
    # home = os.popen("echo $HOME").read().strip()
    # Absolute home path so that root can use this
    if platform.system() == "Linux":
        home = "/home/cmiranda"
    else:
        home = "/Users/cmiranda"

    with open("{}/dotfiles/config.yaml".format(home)) as f:
        return yaml.load(f, Loader=yaml.FullLoader)
