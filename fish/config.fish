if status is-interactive
    # Commands to run in interactive sessions can go here

    alias vim='nvim'
    alias screen='tmux attach'
    alias axel='axel -a'

    alias ls='exa -F --group-directories-first'
    alias ll='ls -l'
    alias la='ls -la'

    set -gx CDPATH $HOME/Projects

    set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/starship.toml
    starship init fish | source

    # TODO: Copy all the other stuff over from bash config
end

