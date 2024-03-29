# Set up conditional aliases
# It's easier to change the system than to change myself

if status is-interactive
    type -q nvim &&         abbr -ag vim 'nvim'
    type -q tmux &&         abbr -ag screen 'tmux attach'
    type -q axel &&         abbr -ag axel 'axel -a'
    type -q xdg-open &&     abbr -ag open 'xdg-open'
    type -q ranger &&       abbr -ag rr 'ranger'
    type -q yazi &&         abbr -ag rr 'yazi'
    type -q lazygit &&      abbr -ag lg 'lazygit'

    # Everything below needs to be an alias for tab-completion to work right

    # The ubuntu package only installs "batcat", but not "bat"
    type -q batcat && not type -q bat && alias bat='batcat'
    type -q batman && alias man='batman'

    # The ubuntu package installs fd as fdfind
    type -q fdfind && not type -q fd && alias fd='fdfind'

    type -q exa && alias ls='exa -F --group --group-directories-first'
    type -q eza && alias ls='eza -F --group --group-directories-first --time-style relative'
end

