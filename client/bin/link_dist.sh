#!/bin/sh

# Determine absolute path to `static` directory.
script="$(realpath '$0')"
directory="$(dirname '$script')"
static="$directory/../../server/static"
cd "$static"

# If symbolic link `dist` exists already: Remove it!
if [[ -L "./dist" ]]; then
    unlink "./dist"
fi

# (Re-)create the symbolic link.
ln -s "../../client/dist" .
