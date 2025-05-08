#!/bin/zsh

# Safely adds /opt/*/bin to PATH.
# (N) prevents errors if no folders exist.
# (N/) ensures we only grab actual directories.
path=( /opt/*/bin(N/) $path )

# Export it to ensure child processes see it
export PATH

