link = xinitrc

install: $(patsubst %,$(HOME)/.%,$(link))
	

$(HOME)/.%: %
	$(LN) $(LNFLAGS) $(PWD)/$< $@
