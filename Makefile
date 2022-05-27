# Use a sane default for the target dir
XDG_CONFIG_HOME ?= $(HOME)/.config

LN ?= ln
LNFLAGS ?= -sbT

.PHONY: all clean
all:
	

clean:
	

$(XDG_CONFIG_HOME):
	mkdir -p "$@"


# $1 = target dotfile
# $2 = source dotfile
define homelink
all: $(HOME)/$1

$(HOME)/$1: $2
	$(LN) $(LNFLAGS) "$(PWD)/$$<" "$$@"

ifeq ($(MAKECMDGOALS),clean)
clean: clean-$(HOME)/$1

clean-$(HOME)/$1:
	-$(RM) $(HOME)/$1
endif

endef

# $1 = name of directory in current project
define configlink
all: $(XDG_CONFIG_HOME)/$1

$(XDG_CONFIG_HOME)/$1: $1 | $(XDG_CONFIG_HOME)
	$(LN) $(LNFLAGS) "$(PWD)/$$<" "$$@"

ifeq ($(MAKECMDGOALS),clean)
clean: clean-$(XDG_CONFIG_HOME)/$1

clean-$(XDG_CONFIG_HOME)/$1:
	-$(RM) $(XDG_CONFIG_HOME)/$1
endif

endef


# Files that need to be in $HOME
$(eval $(call homelink,.vimrc            ,vim/vimrc             ))
$(eval $(call homelink,.gvimrc           ,vim/gvimrc            ))
# $(eval $(call homelink,.toprc            ,top/toprc             ))
# $(eval $(call homelink,.conkyrc          ,conky/conkyrc         ))
# $(eval $(call homelink,.xinitrc          ,xorg/xinitrc          ))
$(eval $(call homelink,.bashrc           ,bash/bashrc           ))
$(eval $(call homelink,.bash_logout      ,bash/bash_logout      ))
$(eval $(call homelink,.bash_profile     ,bash/bash_profile      ))
$(eval $(call homelink,.tmux.conf        ,tmux/tmux.conf        ))
# $(eval $(call homelink,.yaourtrc         ,yaourt/yaourtrc       ))
$(eval $(call homelink,.gitconfig        ,git/gitconfig         ))

# Dirs that go into $XDG_CONFIG_HOME
$(foreach d,\
	$(shell git ls-tree HEAD -d --name-only),\
	$(eval $(call configlink,$d)))

