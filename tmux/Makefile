link = tmux.conf

install: $(patsubst %,$(HOME)/.%,$(link))
	

$(HOME)/.%: %
	$(LN) $(LNFLAGS) $(PWD)/$< $@
