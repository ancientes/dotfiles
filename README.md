# 🏠 Dotfiles (chezmoi-managed)

This repository contains my personal dotfiles, managed with [chezmoi](chezmoi) ↗.

`chezmoi` helps me keep my configuration files consistent, reproducible, and secure across multiple machines while still allowing for machine-specific differences.

## ✨ What’s Included

- Shell configuration (e.g. `fish`, `zsh`, `bash`)
- Editor configs (e.g. `vim`, `neovim`)
- Git configuration
- Terminal / prompt settings
- OS - or machine-specific tweaks
- Encrypted secrets (handled by chezmoi)
> The exact contents may evolve over time as my setup changes.

## 🧰 Prerequisites

Before using this repo, make sure you have:
- Git
- chezmoi (v2+ recommended)

#### Install chezmoi

#### macOS (Homebrew):

```sh
brew install chezmoi
```

#### Linux (official install script):

```sh
sh -c "$(curl -fsLS get.chezmoi.io)"
```

## 🚀 Getting Started

To initialize your environment using these dotfiles:

```sh
chezmoi init https://github.com/ancientes/dotfiles.git
chezmoi apply
```

Or, if you already have a local clone:

```sh
chezmoi init --source=.
chezmoi apply
```

## 🔍 Daily Usage

This is the most important distinction.

🧠 Think in two layers
```sh
Layer 1: chezmoi (manages files → $HOME)
Layer 2: git     (syncs source state → GitHub)
```

Add a new file to chezmoi:

```sh
chezmoi add ~/.config/nvim/init.lua
```

What this does:

- Copies the file into:

  ```sh
  ~/.local/share/chezmoi/home/...
  ```

- Starts tracking it as managed state

> ⛔ `chezmoi` add does **NOT** push to GitHub<br>
> It only prepares the file for management.

Check what changes would be applied:
```sh
chezmoi diff
```

Apply changes:

```sh
chezmoi apply
```

Edit a managed file:

```sh
chezmoi edit ~/.zshrc
```

## The normal workflow (most of the time)
Editing an existing managed file
```sh
chezmoi edit ~/.bashrc
chezmoi apply
git commit -am "update bashrc"
git push
```

✔ no `chezmoi` add needed again<br>
✔ no git add needed if already tracked

## Adding a brand-new config file

```sh
# create or modify file normally
nvim ~/.config/fish/config.fish

# tell chezmoi to manage it
chezmoi add ~/.config/fish/config.fish

# apply + sync
chezmoi apply
git commit -m "add fish config"
git push
```

## 🖥️ Machine-Specific Configuration

chezmoi supports:

- Hostname-based configs
- OS-specific files
- Templates and conditionals

This allows me to keep one repo while supporting multiple machines cleanly.

## 🔐 Secrets Management

Sensitive files are **not stored in plain text**.

chezmoi handles secrets using:

- Encrypted files
- External secret managers (depending on the machine)

If you’re adapting this repo, make sure to configure your own secret backend.

## ♻️ Updating

Pull the latest changes and apply them:

```sh
chezmoi update
```

## ⚠️ Disclaimer

These dotfiles are **highly opinionated** and tailored to my workflow.
Feel free to explore or borrow ideas, but use at your own risk.

📚 Resources

- [chezmoi documentation](https://www.chezmoi.io/docs/) ↗
- [chezmoi GitHub](https://github.com/twpayne/chezmoi) ↗