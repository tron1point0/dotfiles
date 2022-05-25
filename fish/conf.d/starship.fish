# Use starship prompt if it exists.
# See https://starship.rs/

if status is-interactive && type -q starship
    # Enable starship prompt with custom config location
    set -gx STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"
    starship init fish | source
end

