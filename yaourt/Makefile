link = yaourtrc

install: $(patsubst %,$(HOME)/.%,$(link))
	

$(HOME)/.%: %
	$(LN) $(LNFLAGS) $(PWD)/$< $@
