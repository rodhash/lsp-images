with import <nixpkgs> {};

dockerTools.buildImage {
  name = "nix-emmet";
  tag = "latest";

  copyToRoot = buildEnv {
    name = "image-root";
    paths = [ emmet-language-server ];
    pathsToLink = [ "/bin" ];
  };

  config = {
    # The binary name in Nix is 'emmet-language-server'
    Entrypoint = [ "/bin/emmet-language-server" ];
    Cmd = [ "--stdio" ];
    WorkingDir = "/workspace";
  };
}
