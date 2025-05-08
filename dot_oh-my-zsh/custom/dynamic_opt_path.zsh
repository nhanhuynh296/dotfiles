#!/bin/zsh

# Scan all folders in /opt and add their subdirectories ./bin to PATH

# Iterate over each folder in /opt
for dir in /opt/*; do
  # Check if it's a directory and if the bin subdirectory exists
  bin_dir="$dir/bin"
  if [[ -d "$dir" && -d "$bin_dir" && ":$PATH:" != *":$bin_dir:"* ]]; then
    # Add the bin directory to the PATH
    export PATH="$PATH:$bin_dir"
  fi
done

