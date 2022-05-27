function parent-search -a target -d "Search up through PWD for a file"
    set -l SELF 'parent-search'  # TODO: Figure out fish-equivalent of FUNCNAME

    if [ -z "$target" ]
        echo "\
$SELF: Find a file in the current directory or its parents.

USAGE:
    $SELF target

ARGUMENTS:
    target
        The file to search for. (May be a directory.)

OUTPUTS:
    Path to target if found.

ENVIRONMENT:
    PWD
        The directory to search for the target in.
"
        return -1
    end

    set -l dir "$PWD"
    while [ -n "$dir" ]
        [ -e "$dir/$target" ] && echo "$dir/$target" && return 0
        string replace -r '/[^/]*$' '' "$dir" | read dir
    end

    return 1
end

