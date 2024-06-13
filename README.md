# dotfiles

- [NixOS](https://nixos.org/) (without home-manager) +
  [dotbot](https://github.com/anishathalye/dotbot)
- [kitty](https://sw.kovidgoyal.net/kitty/) + [zsh](https://www.zsh.org/) +
  [neovim](https://neovim.io/) + [tmux](https://github.com/tmux/tmux)

## Structure

- `/os`, NixOS + MacOS/Dariwn config.
- `/bin`, assorted helper bash scripts.
- `/*`, applications config.

## Usage

### `home`

Rebuilds NixOS configuration and installs packages.

```
./sync home
```

### `work`

Automatically installs homebrew/oh-my-zsh/etc and then install packages.

```
./sync work
```

### `--skip-install`

Skips installing os/packages.

```
./sync home --skip-install
```

### `--skip-dotfiles`

Skips installing dotfiles.

```
./sync home --skip-dotfiles
```
