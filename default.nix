#!/usr/bin/env -S nix build -f

with (import (builtins.fetchGit {
  url = "https://github.com/dmjio/miso";
  ref = "refs/tags/1.8";
}) {});
pkgs.haskell.packages.ghcjs.callCabal2nix "app" ./. {}
