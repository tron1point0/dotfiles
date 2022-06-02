# Configuration for `less` and `bat` utilities

if status is-interactive
    set -gx LESSHISTFILE "$XDG_DATA_HOME/less/lesshst"
    set -gx LESS "--mouse --hilite-search --ignore-case --jump-target=.5 --long-prompt --RAW-CONTROL-CHARS --tabs=4 --shift=.3"

    set -gx LESS_TERMCAP_md \e"[38;5;9m"        # section titles
    set -gx LESS_TERMCAP_us \e"[38;5;10m"       # code/literal
    set -gx LESS_TERMCAP_mb \e"[4;38;5;3m"      # ???
    set -gx LESS_TERMCAP_so \e"[1;38;5;11m"     # highlight/modeline
    set -gx LESS_TERMCAP_me \e"[0m"             # reset section title
    set -gx LESS_TERMCAP_se \e"[0m"             # reset highlight/modeline
    set -gx LESS_TERMCAP_ue \e"[0m"             # reset code/literal

    # FIXME: Lesspipe and Batpipe are broken for fish :(

    # Use lesspipe if that exists
    if type -q lesspipe.sh
        set -gx LESSOPEN "|lesspipe.sh %s"

        type -q source-highlight && set -gx LESSCOLORIZER 'source-highlight'
        type -q batcat && set -gx LESSCOLORIZER 'batcat'
        type -q bat && set -gx LESSCOLORIZER 'bat'
    end

    # Use batpipe instead if that exists
    if type -q batpipe
        # TODO: Remove --status-column programmatically
        set -gx LESSOPEN "|batpipe %s"
        set -gx BATPIPE 'color'
    end
end

