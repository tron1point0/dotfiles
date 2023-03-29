# Include GNU utilities on OSX systems if they're installed

# Homebrew uses /opt/homebrew on Apple Silicon
[ -x /opt/homebrew/bin/brew ] && /opt/homebrew/bin/brew shellenv | source

if status is-interactive && type -q brew
    for package in coreutils inetutils make
        set -l libexec_path "/usr/local/opt/$package/libexec"
        [ -d "$libexec_path/gnubin" ] && fish_add_path -g "$libexec_path/gnubin"
        [ -d "$libexec_path/gnuman" ] && set -p MANPATH "$libexec_path/gnuman"
    end
end

