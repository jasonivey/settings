### Inkdrop Note Config & Settings

This directory contains the following [Inkdrop](https://www.inkdrop.app/) settings and configuration [files](https://docs.inkdrop.app/manual/basic-usage):
* config.cson: The app config file in [CSON format](https://github.com/bevry/cson#what-is-cson)
* keymap.cson: The keybindings config file in [CSON format](https://github.com/bevry/cson#what-is-cson)

The other file, `copy-note-link.json`, is a custom menu item to enable `copying inkdrop note ids` so its possible to create links to specific `notes`.  To install this custom menu item:

NOTE: normally 3rd party plugins are installed via the `ipm` [command line tool](https://docs.inkdrop.app/manual/extend-inkdrop-with-plugins/#using-ipm-inkdrop-plugin-manager) (see `imp list`)

``` bash
# The plugin directory '$HOME/Library/Application Support/inkdrop/packages'
#  should already exist if any Inkdrop plugins have already been installed
mkdir -p "$HOME/Library/Application Support/inkdrop/packages/copy-note-link/menus"
cd "$HOME/Library/Application Support/inkdrop/packages/copy-note-link/menus"
ln -s "$HOME/settings/inkdrop/copy-note-link.json" "$HOME/Library/Application Support/inkdrop/packages/copy-note-link/menus/copy-note-link.json"
```
