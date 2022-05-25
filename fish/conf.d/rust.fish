# Include any rust packaged binaries in PATH (if they exist)

if status is-interactive && [ -d "$HOME/.cargo/bin" ]
    set -p PATH "$HOME/.cargo/bin"
end

