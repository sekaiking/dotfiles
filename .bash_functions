#!/bin/bash

source "$SCRIPTS/9alam.sh"

canibuy () {
    whois "$1" 2>/dev/null | grep -q 'Registrant' && echo "taken" || echo "available"
} && export -f canibuy

# autojump and open dir in nvim
zn() {
    if [[ ${1} == -* ]] && [[ ${1} != "--" ]]; then
        z ${@}
        return
    fi

    output="$(autojump ${@})"
    if [[ -d "${output}" ]]; then
        nvim "${output}"
    else
        echo "zoxide: directory '${@}' not found"
        echo -e "\n${output}\n"
        echo "Try \`z --help\` for more information."
        false
    fi
} && export -f zn

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

function checksums {
    for file in "$@"; do
      local md5=($(md5sum $file))
      local sha256=($(sha256sum $file))
      echo "MD5 checksum: $md5"
      echo "SHA-256 checksum: $sha256"
    done
}

# download to Temp folder, then check sha256 if provided
dl() {
  local arg_url="$1"

  last_downloaded="$(curl --remote-name --location --max-redirs 5 --output-dir $TEMP/dl -w "%{filename_effective}" "$arg_url")"

  echo "~~~~~~~~~~~~~~~~"
  checksums $last_downloaded
  echo "~~~~~~~~~~~~~~~~"

} && export -f dl
