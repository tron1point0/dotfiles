dirs = $(shell git ls-tree HEAD -d --name-only)
links = $(addprefix $(HOME)/.,$(notdir $(basename $(wildcard ./*/*.symlink))))
configdirs = $(patsubst %,$(XDG_CONFIG_HOME)/%,$(dirs))
LN = ln
LNFLAGS = -sbT
export LN
export LNFLAGS

vpath %.symlink $(subst ' ',:,$(configdirs))

.PHONY: install

install: $(configdirs) $(links)
	

$(XDG_CONFIG_HOME)/%: % | $(XDG_CONFIG_HOME)
	[ ! -L $@ ] && mv $@ $@.dotsave || true
	$(LN) $(LNFLAGS) $(PWD)/$< $@

$(HOME)/.%: %.symlink
	$(LN) $(LNFLAGS) $< $@

$(XDG_CONFIG_HOME):
	install -d $@
