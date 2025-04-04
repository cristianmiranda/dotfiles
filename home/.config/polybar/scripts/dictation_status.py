#!/usr/bin/env python3

import subprocess
import sys
import os

# Font Awesome microphone icon
MICROPHONE_ICON = ""

# One Dark color palette (as specified in requirements)
INACTIVE_COLOR = "#FF6961"  # Red
ACTIVE_COLOR = "#98C379"    # Green

def get_dictation_status():
    """Get the status of nerd-dictation from the control script."""
    try:
        # Use the full path to the dictation script
        dictation_script = "/home/cmiranda/bin/dictation"

        result = subprocess.run(
            [dictation_script, "--status"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        status = result.stdout.strip()

        # Ensure we're returning either "active" or "inactive"
        if status == "active":
            return "active"
        else:
            return "inactive"
    except Exception as e:
        sys.stderr.write(f"Error getting dictation status: {str(e)}\n")
        return "inactive"  # Default to inactive on error

def format_output(status):
    """Format the output for Polybar based on the status."""
    if status == "active":
        return f"%{{F{ACTIVE_COLOR}}}{MICROPHONE_ICON}%{{F-}}"
    else:
        return f"%{{F{INACTIVE_COLOR}}}{MICROPHONE_ICON}%{{F-}}"

def main():
    status = get_dictation_status()
    print(format_output(status))

if __name__ == "__main__":
    main()
