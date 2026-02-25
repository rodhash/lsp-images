with import <nixpkgs> {};

dockerTools.buildImage {
  name = "nix-jqls";
  tag = "latest";

  copyToRoot = buildEnv {
    name = "image-root";
    paths = [
      jq-lsp   # The specific JQ Language Server package
      jq       # Including the base jq binary is often helpful for the LSP
    ];
    pathsToLink = [ "/bin" ];
  };

  config = {
    # The binary provided by 'jq-lsp' is typically 'jq-lsp'
    Entrypoint = [ "/bin/jq-lsp" ];
    WorkingDir = "/workspace";
  };
}
