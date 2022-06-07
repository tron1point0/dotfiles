# Set up perlbrew if it exists

if [ -d "$HOME/Projects/perlbrew" ]
    if type -q perlbrew
        set -gx PERLBREW_ROOT "$HOME/Projects/perlbrew"
        source "$PERLBREW_ROOT/etc/perlbrew.fish"
    else
        if status is-interactive
            # Make perlbrew install itself if needed.
            function perlbrew
                functions -e perlbrew
                set -gx PERLBREW_ROOT "$HOME/Projects/perlbrew"
                curl -L 'https://install.perlbrew.pl' | bash
                source "$PERLBREW_ROOT/etc/perlbrew.fish"
            end
        end
    end
end

