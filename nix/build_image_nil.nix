with import <nixpkgs> {};

dockerTools.buildImage {
  name = "nix-nil";
  tag = "latest";

  copyToRoot = buildEnv {
    name = "image-root";
    paths = [
      nil
      nixpkgs-fmt # Add this for formatting support
    ];
    pathsToLink = [ "/bin" ];
  };

  config = {
    # nil doesn't require node or python, it's a standalone binary
    Entrypoint = [ "/bin/nil" ];
    WorkingDir = "/workspace";
  };
}
