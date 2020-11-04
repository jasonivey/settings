# vim: awa:ts=4:sw=4:noet:tw=120:ft=make

# NOTE: started but unfinished... probably needs an hour worth of work and testing

UNAME := $(shell uname)
SETTINGS_FORTUNE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
MACOS_FORTUNES_DEST_DIR := "/usr/local/Cellar/fortune/9708/share/games/fortunes"
LINUX_FORTUNES_DEST_DIR := "/usr/share/games/fortunes"
FORTUNE_FILENAME := "softwareengineering.txt"
SETTINGS_FORTUNE_PATH := $(SETTINGS_FORTUNE_DIR)/$(FORTUNE_FILENAME)
FORTUNE := $(shell command -v fortune 2> /dev/null)
STRFILE := $(shell command -v strfile 2> /dev/null)
$(eval TMPDIR := $(shell mktemp -d))

ifeq ($(UNAME), Linux)
	FORTUNES_DEST_DIR = $(LINUX_FORTUNES_DEST_DIR)
	FORTUNES_DEST_FILES = softwareengineering.dat softwareengineering softwareengineering.u8
endif
ifeq ($(UNAME), Darwin)
	FORTUNES_DEST_DIR = $(MACOS_FORTUNES_DEST_DIR)
	FORTUNES_DEST_FILES = softwareengineering.dat softwareengineering
endif

all: install

######################################################################
# Installation

.PHONY: install
install: install_fortunes
	@echo "  ...test using 'watch -tc -n 2 fortune softwareengineering'"

install_fortunes: copy_fortunes
	@echo "installation of softwareengineering fortunes successful..."

copy_fortunes: ${FORTUNES_DEST_FILES)
	cp -f $(SETTINGS_FORTUNE_PATH) "$(TMPDIR)/softwareengineering"
	@echo "created copy of softwareengineering.txt in $(TMPDIR)/softwareengineering"
	strfile "$(TMPDIR)/softwareengineering" "$(TMPDIR)/softwareengineering.dat" &>/dev/null
	@echo "created $(TMPDIR)/softwareengineering.dat using strfile and $(TMPDIR)/softwareengineering"
	rm -rf $(TMPDIR)

$(FORTUNES_DEST_DIR):
	@echo "fortunes directory $(FORTUNES_DEST_DIR) does not exist"
	false
	#mkdir -p $@
	#@echo "fortunes directory $(FORTUNES_DEST_DIR) created successfully"

######################################################################
# Uninstallation

.PHONY: uninstall
uninstall:
	stow --verbose --simulate --dir=$(SETTINGS_DIR) --target=${HOME} --delete $(PACKAGES)


######################################################################
# clean

.PHONY: clean
clean:
	@rm -vf $(SETTINGS_TREE_NAME)
