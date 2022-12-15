# Include any rust packaged binaries in PATH (if they exist)

if status is-interactive && [ -d "$HOME/.cargo/bin" ]
    fish_add_path -g "$HOME/.cargo/bin"
end

