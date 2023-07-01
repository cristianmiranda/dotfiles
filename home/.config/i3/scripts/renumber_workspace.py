#!/usr/bin/env python3
#
# github.com/justbuchanan/i3scripts
#
# This script is used to dynamically renumber workspaces in i3. When run, it
# swaps the current workspace number with the one specified as argument.
# It is compatible with the autoname_workspaces script and
# renames only the "number" of the workspace, keeping the shortname and window
# icons in place.
#
# Note that this script can be used without autoname_workspaces.py.
#
# Dependencies:
# * i3ipc  - install with pip - https://i3ipc-python.readthedocs.io/en/latest/

import i3ipc
import logging
import subprocess as proc
import sys

from util import *


def renumber_workspace(new_number=None):
    logging.basicConfig(level=logging.INFO)

    i3 = i3ipc.Connection()

    # Current workspace
    workspace = focused_workspace(i3)
    workspace_name = parse_workspace_name(workspace.name)

    if workspace_name.num == new_number:
        logging.info("Workspace already using that number. Aborting.")
        exit(0)

    # Target workspace to be swapped
    target_workspace = None
    target_workspace_name = None
    workspaces = i3.get_workspaces()
    for wsp in workspaces:
        parts = parse_workspace_name(wsp.name)
        if parts.num == new_number:
            target_workspace = wsp
            target_workspace_name = parts

    logging.info("Current workspace number: '%s'" % workspace_name.num)
    new_name = construct_workspace_name(
        NameParts(
            num=new_number,
            shortname=workspace_name.shortname,
            icons=workspace_name.icons,
        )
    )

    if target_workspace != None and target_workspace_name != None:
        logging.info("Target workspace number: '%s'" % target_workspace_name.num)
        target_new_name = construct_workspace_name(
            NameParts(
                num=workspace_name.num,
                shortname=target_workspace_name.shortname,
                icons=target_workspace_name.icons,
            )
        )
        
        name_swaps = {
            "%s" % target_workspace.name: "%s-aux" % workspace.name,
            "%s" % workspace.name: "%s" % target_workspace.name,
            "%s-aux" % workspace.name: "%s" % workspace.name,
        }
        
        for key, value in name_swaps.items():
            i3.command(
                'rename workspace "%s" to "%s"' % (key, value)
            )
        
        

    i3.command('rename workspace "%s" to "%s"' % (workspace.name, new_name))


if __name__ == "__main__":
    new_number = sys.argv[1] if len(sys.argv) > 1 else None
    assert new_number != None, "Failed to rename workspace"

    renumber_workspace(new_number)
