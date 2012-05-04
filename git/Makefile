link = gitconfig

install: $(patsubst %,$(HOME)/.%,$(link))
	

$(HOME)/.%: %
	$(LN) $(LNFLAGS) $(PWD)/$< $@
