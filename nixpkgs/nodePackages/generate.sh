#!/usr/bin/env bash
set -eu -o pipefail

rm -f ./node-env.nix
nix-shell -p nodePackages.node2nix --run "node2nix --nodejs-13 -i node-packages.json -o node-packages.nix -c composition.nix"
