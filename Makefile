dirs = $(shell git ls-tree HEAD -d --name-only)
export LN = ln
export LNFLAGS = -s

install: $(patsubst %,$(XDG_CONFIG_HOME)/%,$(dirs))
	

$(XDG_CONFIG_HOME)/%: %
	$(LN) $(LNFLAGS) $(PWD)/$< $@
	@[ -r $@/Makefile ] && cd $@ && $(MAKE) || true
