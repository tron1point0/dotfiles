prefix := $(firstword $(prefix) $(HOME))

# The config *dotfiles* are linked in sysconfdir
sysconfdir := $(prefix)

# The config *directiories* are linked in datarootdir
datarootdir := $(firstword $(XDG_CONFIG_HOME) $(prefix)/.config)

# Files with this extension will be linked in sysconfdir
LINK_SEARCH := .symlink

is_directory = $(and $(wildcard $1/*),$1)

find = $(and $(wildcard $1),\
	   $(strip $(wildcard $1/$2) $(foreach file,$(wildcard $1/*),\
	         $(call find,$(file),$2)\
	   )))

# These directories will be linked in datarootdir
dirs := $(shell git ls-tree HEAD -d --name-only)
dir_targets := $(strip $(foreach file,$(wildcard ./*),$(call is_directory,$(file))))

link_targets := $(call find,.,$(LINK_SEARCH))

linkfiles := $(shell git ls-tree -r --name-only HEAD | grep '.*.$(LINK_SEARCH)$$')
links := $(abspath $(addprefix $(sysconfdir)/.,$(basename $(notdir $(linkfiles)))))

$(info $(links))

configdirs := $(patsubst %,$(datarootdir)/%,$(dirs))
INSTALL := install
LN := ln
LNFLAGS := -sbT
ifneq (,$(findstring B,$(MAKEFLAGS)))
	LNFLAGS := -sfT
endif
BACKUP_NAME := .dotsave

vpath %.symlink $(dir $(linkfiles))

.PHONY: install force clean
install: $(configdirs) $(links)
clean:
	-rm $(configdirs) $(links)

$(datarootdir)/%: % | $(datarootdir)
ifneq ($(shell [ -L $@ ] && echo $@),)
	mv $@ $@$(BACKUP_NAME)
endif
	$(LN) $(LNFLAGS) $(PWD)/$< $@

$(sysconfdir)/.%: %$(LINK_SEARCH)
	$(LN) $(LNFLAGS) $(PWD)/$< $@

$(datarootdir):
	install -d $@
