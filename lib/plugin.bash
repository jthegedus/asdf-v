#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/vlang/v"
TOOL_NAME="v"
TOOL_TEST="asdf --help"

function fail() {
	printf "asdf-%s: %s\\n" "$TOOL_NAME" "$*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if plugin-template-test is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

# accepts newline separated list of semver versions
# returns a sorted newline separated list of semver versions
function sort_versions() {
	# local versions
	# versions="$1"

	# printf "%s\\n" "$versions" |
	sed 'h; s/[-]/./g; s/.p\([[:digit:]]\)/.z.\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n -k 5,5n |
		awk '{print $2}'
}

# returns a newline separated list of git tags
function list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' |
		cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

function list_all_versions() {
	list_github_tags
}

function download_release() {
	local version filename url
	version="$1"
	filename="$2"
	url="$GH_REPO/archive/refs/tags/${version}.tar.gz"

	printf "* Downloading %s release %s..." "$TOOL_NAME" "$version"
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

function install_version() {
	local install_type version install_path
	install_type="$1"
	version="$2"
	install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(printf "%s\\n" "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		printf "%s %s installation was successful!\\n" "$TOOL_NAME" "$version"
	) || (
		rm -rf "$install_path"
		fail "An error ocurred while installing $TOOL_NAME $version."
	)
}
