with import <nixpkgs> {};

dockerTools.buildImage {
  name = "nix-htmx-lsp";
  tag = "latest";

  copyToRoot = buildEnv {
    name = "image-root";
    paths = [ htmx-lsp ];
    pathsToLink = [ "/bin" ];
  };

  config = {
    # The binary in nixpkgs is named 'htmx-lsp'
    Entrypoint = [ "/bin/htmx-lsp" ];
    WorkingDir = "/workspace";
  };
}
