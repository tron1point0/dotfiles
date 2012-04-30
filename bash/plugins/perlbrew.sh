if [ -d $HOME/Projects/perlbrew ]; then
    export PERLBREW_ROOT=$HOME/Projects/perlbrew
    source $PERLBREW_ROOT/etc/bashrc
fi

can setup-bash-complete && source setup-bash-complete
