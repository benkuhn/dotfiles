### Organization

- This repo expects to live at `~/conf`. Dotfiles live in the `dot` subdir. The `link_files` script symlinks `dot/foo` to `~/.foo` (and works on subdirectories as well).

- Terminal config is split up into different source-able modules, each of which is (as far as possible) idempotent, to make reloading easier. OS- and terminal-specific files live in subdirectories (e.g. `zsh/osx`, `zsh/osx/kitty`).

### Most interesting config

- When a long-running command finishes, if my terminal isn't focused, I get a notification. Implementation in `zsh/cmd_notify.zsh`; relies on functions in the various `window.zsh` files.
