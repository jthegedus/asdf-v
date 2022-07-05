#!/usr/bin/env bash

set -euo pipefail

current_script_path=${BASH_SOURCE[0]}
plugin_dir=$(dirname "$(dirname "$current_script_path")")

# shellcheck source=../lib/utils.bash
. "${plugin_dir}/lib/utils.bash"

function download_release() {
	local version filename url
	version="$1"
	filename="$2"
	url="$GH_REPO/archive/refs/tags/${version}.tar.gz"

	printf "* Downloading %s release %s..." "$TOOL_NAME" "$version"
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}
