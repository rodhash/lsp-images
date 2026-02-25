with import <nixpkgs> {};

dockerTools.buildImage {
  name = "nix-ansible-ls";
  tag = "latest";

  copyToRoot = buildEnv {
    name = "image-root";
    paths = [
      ansible-language-server
      ansible                # Required for the LSP to function correctly
      python3                # Base runtime for Ansible
    ];
    pathsToLink = [ "/bin" ];
  };

  config = {
    Entrypoint = [ "/bin/ansible-language-server" ];
    Cmd = [ "--stdio" ];
    WorkingDir = "/workspace";
  };
}
