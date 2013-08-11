#!/usr/bin/env bash

# Remove trailing whitespace (space, tabs)
sed -i -r -e 's/\s+$//g' file-a.txt

# Replace all tab characters with 2 spaces.
sed -i -r -e 's/\t/  /g' file-a.txt

# Squeeze blank lines
cat -s file-a.txt
