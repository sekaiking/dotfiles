#!/bin/bash

source "$SCRIPTS/9alam.sh"

canibuy () {
    whois "$1" 2>/dev/null | grep -q 'Registrant' && echo "taken" || echo "available"
} && export -f canibuy

# autojump and open dir in nvim
jn() {
    if [[ ${1} == -* ]] && [[ ${1} != "--" ]]; then
        autojump ${@}
        return
    fi

    output="$(autojump ${@})"
    if [[ -d "${output}" ]]; then
        nvim "${output}"
    else
        echo "autojump: directory '${@}' not found"
        echo -e "\n${output}\n"
        echo "Try \`autojump --help\` for more information."
        false
    fi
} && export -f jn

# clone 
clone() {
	local repo="$1" user
	local repo="${repo#https://github.com/}"
	local repo="${repo#git@github.com:}"
	if [[ $repo =~ / ]]; then
		user="${repo%%/*}"
	else
		user="$GITUSER"
		[[ -z "$user" ]] && user="$USER"
	fi
	local name="${repo##*/}"
	local userd="$REPOS/github.com/$user"
	local path="$userd/$name"
	[[ -d "$path" ]] && cd "$path" && return
	mkdir -p "$userd"
	cd "$userd"
	echo gh repo clone "$user/$name" -- --recurse-submodule
	gh repo clone "$user/$name" -- --recurse-submodule
	cd "$name"
} && export -f clone
