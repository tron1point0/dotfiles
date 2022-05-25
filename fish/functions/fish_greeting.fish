# Run once on every fish startup.

function fish_greeting
    # Split out a funny fortune
    type -q fortune && fortune -a
end

