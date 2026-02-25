# renovate: datasource=github-releases depName=nixos/nixpkgs
let
  # Pinning to a specific commit/version so Renovate can track it
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {};
in
with pkgs;

dockerTools.buildImage {
  name = "nix-jqls";
  tag = "latest";

  copyToRoot = buildEnv {
    name = "image-root";
    paths = [
      jq-lsp   # The specific JQ Language Server package
      jq       # Including the base jq binary
    ];
    pathsToLink = [ "/bin" ];
  };

  config = {
    Entrypoint = [ "/bin/jq-lsp" ];
    WorkingDir = "/workspace";
  };
}
