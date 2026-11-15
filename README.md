# My Dotfiles

Personal dotfiles for macOS/Linux, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's included

| Package     | Target                          | Notes                                                       |
| ----------- | ------------------------------- | ----------------------------------------------------------- |
| `nvim`      | `~/.config/nvim`                | Neovim 0.12+, lazy.nvim, native LSP, blink.cmp, fzf-lua, oil |
| `tmux`      | `~/.config/tmux/tmux.conf`      | tmux 3.1+, TPM, tmux-sensible, tmux-nova                    |
| `alacritty` | `~/.config/alacritty`           | Monofur Nerd Font Mono                                       |
| `karabiner` | `~/.config/karabiner`           | Caps Lock → Hyper (Esc when tapped), Hyper+umlauts → brackets |

## Installation

```bash
git clone https://github.com/foksikus/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
brew bundle            # installs stow, neovim, tmux, fonts, ... (see Brewfile)
stow */                # or individually: stow nvim tmux alacritty karabiner
```

tmux plugins need TPM once:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
# then inside tmux: prefix + I
```

Neovim installs its plugins, language servers and tree-sitter parsers on first start.

To remove the symlinks: `stow -D */`

### Upgrading from the old layout

The tmux config moved from `~/.tmux.conf` to `~/.config/tmux/tmux.conf`, and some
Neovim plugins changed branch. Before pulling:

```bash
cd ~/.dotfiles && stow -D tmux
```

After pulling:

```bash
stow tmux
mv ~/.tmux/plugins ~/.config/tmux/plugins   # keep installed tmux plugins
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter ~/.local/share/nvim/lazy/nvim-treesitter-textobjects
nvim   # lazy.nvim reinstalls the changed plugins; then run :Lazy sync
```
