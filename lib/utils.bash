#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/vlang/v"
TOOL_NAME="v"
TOOL_TEST="v --help"

function fail() {
	printf "asdf-%s: %s\\n" "$TOOL_NAME" "$*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if plugin-template-test is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi
