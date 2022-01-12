# Use a sane default for the target dir
XDG_CONFIG_HOME ?= $(HOME)/.config

LN ?= ln
LNFLAGS ?= -sbT

.PHONY: all
all:

$(XDG_CONFIG_HOME):
	mkdir -p "$@"


# $1 = target dotfile
# $2 = source dotfile
define homelink
all: $(HOME)/$1

$(HOME)/$1: $2
	$(LN) $(LNFLAGS) "$(PWD)/$$<" "$$@"

endef

# $1 = name of directory in current project
define configlink
all: $(XDG_CONFIG_HOME)/$1

$(XDG_CONFIG_HOME)/$1: $1 | $(XDG_CONFIG_HOME)
	$(LN) $(LNFLAGS) "$(PWD)/$$<" "$$@"

endef


# Files that need to be in $HOME
$(eval $(call homelink,.vimrc            ,vim/vimrc.symlink             ))
$(eval $(call homelink,.gvimrc           ,vim/gvimrc.symlink            ))
# $(eval $(call homelink,.toprc            ,top/toprc.symlink             ))
# $(eval $(call homelink,.conkyrc          ,conky/conkyrc.symlink         ))
# $(eval $(call homelink,.xinitrc          ,xorg/xinitrc.symlink          ))
$(eval $(call homelink,.bashrc           ,bash/bashrc.symlink           ))
$(eval $(call homelink,.bash_logout      ,bash/bash_logout.symlink      ))
$(eval $(call homelink,.tmux.conf        ,tmux/tmux.conf.symlink        ))
# $(eval $(call homelink,.yaourtrc         ,yaourt/yaourtrc.symlink       ))
$(eval $(call homelink,.gitconfig        ,git/gitconfig.symlink         ))

# Dirs that go into $XDG_CONFIG_HOME
$(foreach d,\
	$(shell git ls-tree HEAD -d --name-only),\
	$(eval $(call configlink,$d)))

