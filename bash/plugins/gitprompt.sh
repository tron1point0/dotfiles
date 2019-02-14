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
        branch_name="${branch}"
        if [[ "$upstream" == "$branch" ]] ; then
            # Branch is tracking upstream branch of the same name
            branch_color='\e[38;5;2m'  # Dark green
        elif [[ "$upstream" ]] ; then
            # Branch is tracking upstream branched named differently
            branch_name="${branch_name}…${upstream}"
            branch_color='\e[38;5;5m'  # Dark magenta
        else
            # Branch is local only
            branch_color='\e[38;5;3m'  # Dark yellow
        fi
    fi

    local branch_info="\[${branch_color}\]${branch_name}"
    
    local upstream_status="\[\e[38;5;15m\]"  # Bright grey
    if [[ -v show_counts ]] ; then
        if [[ -v upstream ]] ; then
            [[ "$ahead" == 0 && "$behind" == 0 ]] && upstream_status="${upstream_status}⇋"
            [[ "$ahead" > 0 ]] && upstream_status="${upstream_status}↿${ahead}"
            [[ "$behind" > 0 ]] && upstream_status="${upstream_status}⇂${behind}"
        fi
    else
        if [[ -v upstream ]] ; then
            if [[ "$ahead" == 0 && "$behind" == 0 ]] ; then
                upstream_status="${upstream_status}⇋"
            elif [[ "$ahead" > 0 && "$behind" > 0 ]] ; then
                upstream_status="${upstream_status}⥮"
            elif [[ "$ahead" > 0 ]] ; then
                upstream_status="${upstream_status}↿"
            elif [[ "$behind" > 0 ]] ; then
                upstream_status="${upstream_status}⇂"
            fi
        fi
    fi

    local local_status

    # TODO: Nested function to generate these?
    if [[ -v merging ]] ; then
        # Bright red
        local_status="${local_status}\[\e[38;5;9m\]‼"
        [[ -v show_counts ]] && local_status="${local_status}${merging}"
    fi

    if [[ -v worktree ]] ; then
        # Dark red
        local_status="${local_status}\[\e[38;5;1m\]✱"
        [[ -v show_counts ]] && local_status="${local_status}${worktree}"
    fi

    if [[ -v index ]] ; then
        # Dark green
        local_status="${local_status}\[\e[38;5;2m\]✚"
        [[ -v show_counts ]] && local_status="${local_status}${index}"
    fi

    if [[ -v untracked ]] ; then
        # Bright yellow
        local_status="${local_status}\[\e[38;5;3m\]✖"
        [[ -v show_counts ]] && local_status="${local_status}${untracked}"
    fi

    if parent-search .git/refs/stash >/dev/null ; then
        # Bright magenta
        local_status="${local_status}\[\e[38;5;13m\]⚑"
        if [[ -v show_counts ]] ; then
            # TODO: Stash counts
            local_status="${local_status}${stash}"
        fi
    fi

    [[ -v local_status ]] && local_status=" ${local_status}"

    echo "\[\e[38;5;15m\](${branch_info}${local_status}${upstream_status}\[\e[38;5;15m\])\[\e[0m\]"

    return 0
}
