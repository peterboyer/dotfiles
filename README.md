# dotfiles

- [NixOS](https://nixos.org/) (without home-manager) +
  [dotbot](https://github.com/anishathalye/dotbot)
- [kitty](https://sw.kovidgoyal.net/kitty/) + [zsh](https://www.zsh.org/) +
  [neovim](https://neovim.io/) + [tmux](https://github.com/tmux/tmux)

## Structure

- `/hosts/*`, NixOS + MacOS/Dariwn config.
- `/bin`, assorted helper bash scripts.
- `/dotbot.*`, dotfiles config.
- `/*`, applications config.

## Usage

### `home`

Rebuilds NixOS configuration and installs packages.

```
./hosts/_home
```

### `work`

Automatically installs homebrew/oh-my-zsh/etc and then install packages.

```
./hosts/_work
```

---

### `--no-install`

Skips installing os/packages.

```
./sync home --no-install
```

### `--no-dotfiles`

Skips installing dotfiles.

```
./sync home --no-dotfiles
```
