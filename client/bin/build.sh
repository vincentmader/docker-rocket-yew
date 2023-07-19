#!/bin/sh

cd .. && trunk build --release

cd "../server/static"
if [[ -L "./dist" ]]; then
    unlink "./dist"
fi

ln -s ../../client/dist .
