with import <nixpkgs> {};

dockerTools.buildImage {
  name = "nix-clangd";
  tag = "latest";

  copyToRoot = buildEnv {
    name = "image-root";
    paths = [
      clang-tools  # Provides the 'clangd' binary
      llvmPackages.libcxx.dev # Provides C++ standard headers
      glibc.dev    # Provides C standard headers
    ];
    pathsToLink = [ "/bin" "/include" ];
  };

  config = {
    # clangd usually needs --query-driver to find headers in isolated environments
    Entrypoint = [ "/bin/clangd" ];
    Cmd = [ "--stdio" "--background-index" ];
    WorkingDir = "/workspace";
  };
}
