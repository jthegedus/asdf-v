#!/usr/bin/env bash

set -euo pipefail

current_script_path=${BASH_SOURCE[0]}
plugin_dir=$(dirname "$(dirname "$current_script_path")")

# shellcheck source=../lib/utils.bash
. "${plugin_dir}/lib/utils.bash"

function list_all_versions() {
	list_github_tags
}

# returns a newline separated list of git tags
function list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' |
		cut -d/ -f3- |
		sed 's|^v||' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

# accepts newline separated list of semver versions
# returns a sorted newline separated list of semver versions
function sort_versions() {
	sed 'h; s/[-]/./g; s/.p\([[:digit:]]\)/.z.\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n -k 5,5n |
		awk '{print $2}'
}
