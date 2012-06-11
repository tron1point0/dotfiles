if [ -d $HOME/Projects/perlbrew ]; then
    export PERLBREW_ROOT=$HOME/Projects/perlbrew
    source $PERLBREW_ROOT/etc/bashrc
else
    function perlbrew {
        unset -f perlbrew
        export PERLBREW_ROOT=${1:-$HOME/Projects/perlbrew}
        curl -kL http://install.perlbrew.pl | bash
        source $PERLBREW_ROOT/etc/bashrc
    }
fi

whish -s setup-bash-complete && source <(setup-bash-complete)
