#!/usr/bin/env bash

set -euo pipefail

current_script_path=${BASH_SOURCE[0]}
plugin_dir=$(dirname "$(dirname "$current_script_path")")

# shellcheck source=../lib/utils.bash
. "${plugin_dir}/lib/utils.bash"

function latest_stable_version() {
	# Use the GitHub Release matching "latest" as the latest stable version
	# follow the redirect with curl, get the actual resolved URL for latest release
	#   grep result in quotes: "location: https://github.com/vlang/v/releases/tag/0.3"
	# get the release version # from the URL (item after last "/")
	local url
	url="$GH_REPO/releases/latest"

	curl -sI "$GH_REPO/releases/latest" |
		sed -n -e 's|^location: '"$GH_REPO"'/releases/tag/||p'
}
