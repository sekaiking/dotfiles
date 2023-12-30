#!/bin/bash

echo "~~~~~~~~~~~~~~~~~~~~ Updating apt-get ~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""
sudo apt-get update -y
sudo apt-get upgrade -y
echo ""
echo "~~~~~~~~~~~~~~~~~~~~ Installing packages ~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""

download() {
  url=$1
  filename=$2
  expected_sha256=$3

    # Download the file
    if ! [[ -f "$filename" ]]; then
      eval $"curl -L $url -o $filename"
    fi

    # Verify the SHA-256 checksum if provided
    if [ -n "$expected_sha256" ]; then
      actual_sha256=$(sha256sum "$filename" | awk '{print $1}')

      if ! [ "$actual_sha256" == "$expected_sha256" ]; then
        echo "SHA-256 verification failed. $filename may be corrupt or tampered with."
        sudo rm "$filename"
        exit 1
      fi
    fi
  }

  TEMP="$HOME/.install_temp/"
  mkdir "$TEMP"

  install_package() {
    package=$1

    if command -v $package &> /dev/null; then
      echo "$package is already installed. Skipping..."
      return
    fi

    echo "Installing $package..."

    case $package in
      "curl")
        sudo apt-get install -y curl
        ;;
      "nvim")
        if [[ -f /opt/nvim/bin/nvim ]]; then
          return
        fi
        download https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz "$TEMP/nvim.tar.gz"
        tar xzf "$TEMP/nvim.tar.gz" -C "$TEMP"
        sudo cp -r "$TEMP/nvim-linux64" "/opt/nvim"
        sudo chmod +x /opt/nvim/bin/nvim
        ;;
      "git")
        sudo apt-get install -y git
        ;;
      "gh")
        if [[ -f /opt/gh/bin/gh ]]; then
          return
        fi
        download https://github.com/cli/cli/releases/download/v2.40.1/gh_2.40.1_linux_amd64.tar.gz "$TEMP/gh.tar.gz"
        tar xzf "$TEMP/gh.tar.gz" -C "$TEMP"
        sudo cp -r "$TEMP/gh_2.40.1_linux_amd64" "/opt/gh"
        sudo chmod +x /opt/gh/bin/gh
        ;;
      "zoxide")
        if [[ -f /opt/zoxide/bin/zoxide ]]; then
          return
        fi
        sudo apt-get install -y fzf
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash 
        sudo mkdir -p /opt/zoxide/bin/
        sudo cp -r "$HOME/.local/bin/zoxide" "/opt/zoxide/bin/zoxide"
        ;;
      "neofetch")
        sudo apt-get install -y neofetch
        ;;
      "oh-my-posh")
        if [[ -f /opt/ohmyposh/bin/oh-my-posh ]]; then
          return
        fi
        sudo apt-get install -y unzip
        sudo mkdir -p /opt/ohmyposh/bin
        curl -s https://ohmyposh.dev/install.sh | bash -s -- -d /opt/ohmyposh/bin
        sudo chmod +x /opt/ohmyposh/bin/oh-my-posh
        ;;
      "whois")
        sudo apt-get install -y whois
        ;;
      "eza")
        if [[ -f /opt/eza/bin/eza ]]; then
          return
        fi
        download https://github.com/eza-community/eza/releases/download/v0.17.0/eza_x86_64-unknown-linux-gnu.tar.gz "$TEMP/eza.tar.gz" 26bdfda62ed514598397aeb729ed611c14b1bcab85e7e0fd8226498d1cf87295
        tar xzf "$TEMP/eza.tar.gz" -C "$TEMP"
        sudo mkdir -p /opt/eza/bin
        sudo cp "$TEMP/eza" /opt/eza/bin/eza
        ;;
    esac
  }


  always_installed=("curl" "nvim" "git" "gh" "zoxide" "neofetch" "oh-my-posh" "whois" "eza")

  optional_packages=("go" "nvm" "node" "rust")


  for package in "${always_installed[@]}"; do
    install_package "$package"
  done

# Prompt user to select optional packages

# selected_optional=()
# echo "Select optional packages to install (e.g., 1 2 3):"
# for i in "${!optional_packages[@]}"; do
#   echo "$((i+1)). ${optional_packages[i]}"
# done
#
# read -p "> " selected_optional_numbers
#
# IFS=' ' read -ra selected_optional_array <<< "$selected_optional_numbers"
# for number in "${selected_optional_array[@]}"; do
#   index=$((number-1))
#   if [ "$index" -ge 0 ] && [ "$index" -lt "${#optional_packages[@]}" ]; then
#     selected_optional+=("${optional_packages[index]}")
#   fi
# done
#
# for package in "${selected_optional[@]}"; do
#   install_package "$package"
# done

sudo rm -rf "$TEMP"

echo "~~~~~~~~~~~~~~~~~~~~ Installation complete ~~~~~~~~~~~~~~~~~~~~~~~~"
