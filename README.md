
# 🏭 LSP Factory

![Build Status](https://github.com/rodhash/LSP-Factory/actions/workflows/build.yml/badge.svg)

An automated pipeline for building, testing, and distributing lightweight, containerized Language Servers (LSPs). This project uses **Nix** and **Podman** to ensure every LSP is minimal, reproducible, and ready for use in development environments like Neovim, VS Code, or Helix.

## 🚀 Quick Start

All images are hosted on the **GitHub Container Registry (GHCR)**. You can pull them using `podman` or `docker`.

```bash
# Example: Pulling the Go Language Server
podman pull ghcr.io/rodhash/lsp-gopls:latest

# Example: Pulling the Rust Analyzer
podman pull ghcr.io/rodhash/lsp-rust-analyzer:latest
```


### Supported LSPs

The factory currently produces images for:

* **Nix-based builds:** `gopls`, `rust-analyzer`, `pyright`, `nil`, etc.
* **Alpine-based builds:** Custom Dockerfile-based LSPs found in `/podman`.

---

## 🛠 How it Works

This repository is a fully automated "Factory" powered by **GitHub Actions**.

### 1. The Build System

We use a hybrid approach to get the best of both worlds:

* **Nix:** Used for complex LSPs where we need specific, reproducible versions of compilers and runtimes without the bloat of a full OS.
* **Podman/Dockerfiles:** Used for simple, binary-based LSPs that run perfectly on a tiny Alpine base.

### 2. The Automation (Renovate)

We don't manually check for updates. **Renovate Bot** scans this repository every hour.

* **Nix Updates:** Renovate tracks `nixpkgs` commits and updates our build recipes.
* **Container Updates:** Renovate monitors Docker base images (like `alpine` or `node`) and submits Pull Requests when new versions are released.

### 3. Continuous Integration (CI)

When a Pull Request is opened:

1. **Validation:** The CI triggers a build of the modified LSP to ensure it compiles and runs.
2. **Safety:** No images are pushed to the registry during the PR phase.
3. **Deployment:** Once a PR is merged to `main`, the factory automatically pushes the updated `:latest` images to GHCR.

---

## 🏗 Repository Structure

* **`nix/`**: Contains `.nix` build recipes for Language Servers.
* **`podman/`**: Contains `Dockerfile.*` files for Alpine-based LSPs.
* **`.github/workflows/`**: The engine of the factory.
* `build.yml`: Handles the parallel matrix builds and pushes to GHCR.


* **`renovate.json`**: Configuration for the automated update scout.

---

## 🔧 Manual Triggers

You can manually trigger a build for a specific LSP or all of them at once:

1. Go to the **Actions** tab.
2. Select **LSP Factory Build**.
3. Click **Run workflow**.
4. Enter the name of the LSP (e.g., `gopls`) or type `all`.

---

## 📜 License

MIT © rodhash

