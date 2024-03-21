# dotfiles

## Structure

- `./os`, system-specific config.
- `./bin`, assorted utils and helpers.
- `./...`, applications config.

## Usage

### Configure System & Link Dotfiles

Synchronise OS specific packages and configuration.

```
./sync.sh home
./sync.sh work
```

- `home` uses NixOS (Linux).
    - Opted to not use `home-manager`, no real need so far.
- `work` uses MacOS (Darwin).
    - Using `homebrew` to install packages with a "Brewfile".

### Only Link Dotfiles

Only link dotfiles with `dotbot` (if already installed).

```
./sync.sh
```
