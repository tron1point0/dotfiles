for dir in "$HOME/.perl5" "$HOME/perl5"
    if test -d "$dir"
        fish_add_path -g "$dir/bin"
        if not contains "$dir/lib/perl5" $PERL5LIB
            set -x -p --path PERL5LIB "$dir/lib/perl5"
        end

        if not contains $dir $PERL_LOCAL_LIB_ROOT
            set -x -p --path PERL_LOCAL_LIB_ROOT "$dir"
        end

        set -x PERL_MB_OPT "--install_base \"$dir\""
        set -x PERL_MM_OPT "INSTALL_BASE=$dir"

        break
    end
end

