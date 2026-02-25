with import <nixpkgs> {};

dockerTools.buildImage {
  name = "nix-pyright";
  tag = "latest";

  # This is the "Magic": only the LSP and Python are included
  copyToRoot = buildEnv {
    name = "image-root";
    paths = [ pyright nodejs ]; # Pyright needs node
    pathsToLink = [ "/bin" ];
  };

  config = {
    # Entrypoint = The "Fixed" part of the command
    Entrypoint = [ "/bin/pyright-langserver" ];

    # Cmd = The "Default" arguments (can be overridden)
    Cmd = [ "--stdio" ];

    WorkingDir = "/workspace";
  };
}
