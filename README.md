[![](https://img.shields.io/static/v1?label=owner%20|%20maintainer&message=jasonivey&color=blue&style=plastic&logo=github&logoColor=blue&link=https://github.com/jasonivey&link=https://github.com/jasonivey)](https://github.com/jasonivey/settings)
[![](https://img.shields.io/maintenance/yes/2021?style=plastic)](https://github.com/jasonivey/settings)
[![](https://img.shields.io/github/languages/code-size/jasonivey/settings?style=plastic)](https://github.com/jasonivey/settings)
[![](https://img.shields.io/github/repo-size/jasonivey/settings?style=plastic)](https://github.com/jasonivey/settings)
[![](https://tokei.rs/b1/github/jasonivey/settings?category=files)](https://github.com/jasonivey/settings)
[![](https://tokei.rs/b1/github/jasonivey/settings?category=lines)](https://github.com/jasonivey/settings)
[![](https://tokei.rs/b1/github/jasonivey/settings?category=code)](https://github.com/jasonivey/settings)
[![](https://tokei.rs/b1/github/jasonivey/settings?category=comments)](https://github.com/jasonivey/settings)
[![](https://img.shields.io/github/commit-activity/m/jasonivey/settings?style=plastic)](https://github.com/jasonivey/settings)
[![](https://img.shields.io/github/last-commit/jasonivey/settings?style=plastic)](https://github.com/jasonivey/settings)

[![Maintainer](https://github.com/cryptomator/cryptomator/workflows/Build/badge.svg)](https://github.com/cryptomator/cryptomator/actions?query=workflow%3ABuild)

### Settings
This repo is dedicated to the files needed to setup a command line macOS or Linux environment quickly, easily and commonly.

#### Usage
The hope was that once a base macOS or Linux environment was installed a user could clone this repo to `$HOME/settings` and then run `$HOME/settings/install.sh`.  That hope has never been fully realized.  The current installation steps require:
1. install zsh
2. install oh-my-zsh
3. clone this repo
4. from the `$HOME/settings` directory run `stow --stow config gdb git vim zsh`
5. build a proper version of VIM to support all plugins

As time allows, I will work on automating these tasks into a shell script which can be pulled and run from a web location to allow a one step installation similar to oh-my-zsh, rust and many others:

```bash
# I hope to create something like this in the near future...
sh -c "$(curl -fsSL https://raw.githubusercontent.com/jasonivey/settings/master/tools/install.sh)"
```
