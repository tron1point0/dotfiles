link = vimrc

install: $(patsubst %,$(HOME)/.%,$(link))
	

$(HOME)/.%: %
	$(LN) $(LNFLAGS) $(PWD)/$< $@
