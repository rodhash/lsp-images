with import <nixpkgs> {};

dockerTools.buildImage {
  name = "nix-terraform-ls";
  tag = "latest";

  copyToRoot = buildEnv {
    name = "image-root";
    paths = [
      terraform-ls
      terraform
    ];
    pathsToLink = [ "/bin" ];
  };

  config = {
    Entrypoint = [ "/bin/terraform-ls" ];
    Cmd = [ "serve" ];
    WorkingDir = "/workspace";
  };
}
