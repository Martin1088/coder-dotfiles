#!/bin/bash -e

DEBIAN_FRONTEND=noninteractive sudo apt update -y
sudo apt install software-properties-common -y
source /verbis/functions.sh

verbis_defaults_main
verbis_symlink_cache_dir git
sudo ln -ds /mnt/cache/bridgehead /etc || true
rm -rf /home/coder/.cargo/registry
verbis_defaults_rust

script_dir=$(dirname "$(readlink -f "$0")")
# Yanked from https://github.com/bstollnitz/dotfiles/blob/main/install.sh
create_symlinks() {
    # Get the directory in which this script lives.
    

    # Get a list of all files in this directory that start with a dot.
    files=$(find -maxdepth 1 -type f -name ".*")

    # Create a symbolic link to each file in the home directory.
    for file in $files; do
        name=$(basename $file)
        echo "Creating symlink to $name in home directory."
        rm -rf ~/$name
        ln -s $script_dir/$name ~/$name
    done
}

create_symlinks || true

sudo apt install python3-pip gh -y

#curl -L -o out.tgz https://github.com/cargo-bins/cargo-binstall/releases/latest/download/cargo-binstall-x86_64-unknown-linux-musl.tgz
#tar -xf out.tgz
#mv cargo-binstall $HOME/.cargo/bin
#rm out.tgz
source $HOME/.cargo/env
cargo binstall ripgrep bat tre-command starship zellij -y
# Install mold
#curl -L https://github.com/rui314/mold/releases/download/v2.4.0/mold-2.4.0-x86_64-linux.tar.gz | sudo tar -C /usr/local --strip-components=1 --no-overwrite-dir -xzf -
#echo '[target.x86_64-unknown-linux-gnu]
#linker = "clang"
#rustflags = ["-C", "link-arg=-fuse-ld=/usr/local/bin/mold"]' | sudo tee -a ~/.cargo/config.toml

stow -t ~ gitconfig

verbis_install_vscode_extensions ms-azuretools.vscode-docker eamodio.gitlens serayuzgur.crates tamasfe.even-better-toml

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source $HOME/.profile
nvm install --lts

git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git

git clone https://github.com/Martin1088/astrovim_config ~/.config/nvim/lua/user