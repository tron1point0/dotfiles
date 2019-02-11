#!/bin/bash

function __git_prompt() {
    local index
    local worktree
    local untracked
    local stash
    local oid
    local branch
    local upstream
    local ahead
    local behind
    local merging
    
    # local show_counts=1       # Uncomment this to show counts of each local status category  

    local F=()

    while read -a F ; do
        case "${F[0]}" in
            \#)
                # Handle branch stuff
                case "${F[1]}" in
                    branch.oid)
                        # # branch.oid 5ae1ad3619a5c83d388bf284e16b219eed0739eb
                        oid="${F[2]}"
                        ;;
                    branch.head)
                        # # branch.head master
                        branch="${F[2]}"
                        ;;
                    branch.upstream)
                        # # branch.upstream origin/master
                        upstream="${F[2]#origin/}"
                        ;;
                    branch.ab)
                        # # branch.ab +1 -0
                        ahead="${F[2]#+}"
                        behind="${F[3]#-}"
                        ;;
                esac
                ;;
            1|2)
                # Handle changed (1) or renamed (2) entries
                if [[ "${F[1]:0:1}" != "." ]] ; then
                    (( index++ ))
                fi
                if [[ "${F[1]:1:1}" != "." ]] ; then
                    (( worktree++ ))
                fi
                ;;
            u)
                # Handle unmerged files (when there are merge conflicts)
                (( merging++ ))
                if [[ "${F[1]:0:1}" != "." ]] ; then
                    (( index++ ))
                fi
                if [[ "${F[1]:1:1}" != "." ]] ; then
                    (( worktree++ ))
                fi
                ;;
            \?)
                # Handle untracked files
                (( untracked++ ))
                ;;
            *)
                echo "Unknown git status flag: '${F[0]}' in line '${F[@]}'"
                return 1
                ;;
        esac
    done < <(git status --branch --porcelain=2 2>/dev/null)

    [[ -v branch ]] || return 0

    local branch_name
    local branch_color

    if [[ "$branch" == '(detached)' ]] ; then
        branch_name="(${oid:0:8}…)"
        branch_color='\e[38;5;1m'      # Dark red
    else
        if [[ "$upstream" == "$branch" ]] ; then
            branch_name="${branch}"
            branch_color='\e[38;5;2m'  # Dark green
        else
            branch_name="${branch}…${upstream}"
            branch_color='\e[38;5;3m'  # Dark yellow
        fi
    fi

    local branch_info="\[${branch_color}\]${branch_name}"
    
    local upstream_status
    if [[ -v show_counts ]] ; then
        if [[ -v upstream ]] ; then
            if [[ "$ahead" == 0 && "$behind" == 0 ]] ; then
                # Bright grey
                upstream_status="${upstream_status}\[\e[38;5;15m\]⇋"
            fi
            if [[ "$ahead" > 0 ]] ; then
                # Bright grey
                upstream_status="${upstream_status}\[\e[38;5;15m\]↿${ahead}︎"
            fi
            if [[ "$behind" > 0 ]] ; then
                # Bright grey
                upstream_status="${upstream_status}\[\e[38;5;15m\]⇂${behind}"
            fi
        fi
    else
        if [[ -v upstream ]] ; then
            if [[ "$ahead" == 0 && "$behind" == 0 ]] ; then
                # Bright grey
                upstream_status="${upstream_status}\[\e[38;5;15m\]⇋"
            elif [[ "$ahead" > 0 && "$behind" > 0 ]] ; then
                # Bright grey
                upstream_status="${upstream_status}\[\e[38;5;15m\]⥮"
            elif [[ "$ahead" > 0 ]] ; then
                # Bright grey
                upstream_status="${upstream_status}\[\e[38;5;15m\]↿"
            elif [[ "$behind" > 0 ]] ; then
                # Bright grey
                upstream_status="${upstream_status}\[\e[38;5;15m\]⇂"
            fi
        fi
    fi

    local local_status
    if [[ -v show_counts ]] ; then
        # TODO: Nested function to do this?
        # Bright red
        [[ -v merging ]] && local_status="${local_status}\[\e[38;5;9m\]‼${merging}"

        # Dark red
        [[ -v worktree ]] && local_status="${local_status}\[\e[38;5;1m\]✱${worktree}"

        # Dark green
        [[ -v index ]] && local_status="${local_status}\[\e[38;5;2m\]✚${index}"

        # Bright yellow
        [[ -v untracked ]] && local_status="${local_status}\[\e[38;5;3m\]✖${untracked}"

        # Dark blue # TODO: Stash
        [[ -v stash ]] && local_status="${local_status}\[\e[38;5;4m\]⚑${stash}"
    else
        # Bright red
        [[ -v merging ]] && local_status="${local_status}\[\e[38;5;9m\]‼"

        # Dark red
        [[ -v worktree ]] && local_status="${local_status}\[\e[38;5;1m\]✱"

        # Dark green
        [[ -v index ]] && local_status="${local_status}\[\e[38;5;2m\]✚"

        # Bright yellow
        [[ -v untracked ]] && local_status="${local_status}\[\e[38;5;3m\]✖"

        # Dark blue # TODO: Stash
        [[ -v stash ]] && local_status="${local_status}\[\e[38;5;4m\]⚑"
    fi

    [[ -v local_status ]] && local_status=" ${local_status}"

    echo "\[\e[38;5;15m\](${branch_info}${local_status}${upstream_status}\[\e[38;5;15m\])\[\e[0m\]"

    return 0
}
