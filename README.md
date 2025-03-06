# My Dotfiles

This repository contains my personal dotfiles for customizing my mac/linux environment.

## What's Included

**TODO**

## Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/foksikus/dotfiles.git ~/.dotfiles
    ```

2.  **Using Stow:**

    Stow is a symbolic link manager that makes it easy to manage dotfiles.

    * **Install Stow:**

        ```bash
        brew install stow
        ```

    * **Navigate to your dotfiles directory:**

        ```bash
        cd ~/.dotfiles
        ```

    * **Use Stow to create symbolic links:**

        ```bash
        stow alacritty
        stow karabiner
        stow nvim
        ```

    This will create symbolic links in your home directory pointing to the corresponding files in your `.dotfiles` directory.

    To remove the symlinks, use:

    ```bash
    stow -D alacritty
    stow -D nvim
    stow -D karabiner
    ```


## Contributing

If you have any suggestions or improvements, feel free to submit a pull request.
