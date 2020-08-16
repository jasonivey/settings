PACKAGES  = config gdb git vim zsh
DOCS = settings_tree

UNAME := $(shell uname)

ifeq ($(UNAME), Linux)
endif
ifeq ($(UNAME), Darwin)
endif

GIT := $(shell command -v git)
ifneq ($(.SHELLSTATUS),0)
	$(error command -v git failed!)
endif

SETTINGS_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SETTINGS_TREE_NAME := $(SETTINGS_DIR)/settings_tree.txt
IGNORE_FILES := $(shell $(SCRIPTS_DIR)/gitignore_to_glob.py $(SETTINGS_DIR)/git/.gitignore_global $(SETTINGS_DIR)/.gitignore)

SCRIPTS_DIR := $(HOME)/scripts
SCRIPTS_REPOSITORY := git@github.com:jasonivey/scripts.git


all: scripts $(PACKAGES) $(DOCS)



######################################################################
# Installation
# 1. Ensure the scripts repository exists, if not do a clone to the correct location

.PHONY: scripts
scripts:
	mkdir -p $(HOME)/dev
	git clone $(SCRIPTS_REPOSITORY) $(HOME)/dev/scripts
	ln -r -s $HOME/scripts $HOME/dev/scripts

.PHONY: install
install: $(PACKAGES)

# stow really does not need --dir and --target, i'm just being pedantic.
#  it's also very useful to know that the stow verbosity option takes
#  the form of -v[vvvv] or --verbose=0-5 to enable extra output.
#  it's also possible to add the --simulate option which will just show
#  what changes would be made or the conflicts which it will run into.
.PHONY: $(PACKAGES)
$(PACKAGES):
	stow --verbose --simulate --dir=$(SETTINGS_DIR) --target=${HOME} --stow $@

######################################################################
# Uninstallation

.PHONY: uninstall
uninstall:
	stow --verbose --simulate --dir=$(SETTINGS_DIR) --target=${HOME} --delete $(PACKAGES)


######################################################################
# Documentation

.PHONY: docs
docs: $(DOCS)

# This file is handy when editing directories
settings_tree:
	tree --noreport --charset ascii -a -I "$(IGNORE_FILES)" $(SETTINGS_DIR) | sed 's/`/\\/g' > $(SETTINGS_TREE_NAME)

######################################################################
# Miscellaneous

.PHONY: clean
clean:
	@rm -vf $(SETTINGS_TREE_NAME)
