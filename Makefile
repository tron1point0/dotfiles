dirs := $(shell git ls-tree HEAD -d --name-only)
LINK_SEARCH := .symlink
linkfiles := $(shell git ls-tree -r --name-only HEAD | grep '$(LINK_SEARCH)$$')
links := $(abspath $(addprefix $(HOME)/.,$(basename $(notdir $(linkfiles)))))
configdirs := $(patsubst %,$(XDG_CONFIG_HOME)/%,$(dirs))
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

$(XDG_CONFIG_HOME)/%: % | $(XDG_CONFIG_HOME)
ifneq ($(shell [ -L $@ ] && echo $@),)
	mv $@ $@$(BACKUP_NAME)
endif
	$(LN) $(LNFLAGS) $(PWD)/$< $@

$(HOME)/.%: %$(LINK_SEARCH)
	$(LN) $(LNFLAGS) $(XDG_CONFIG_HOME)/$< $@

$(XDG_CONFIG_HOME):
	install -d $@
