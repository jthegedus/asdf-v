#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/vlang/v"
TOOL_NAME="v"
TOOL_TEST="v --help"

function fail() {
	printf "asdf-%s: %s\\n" "$TOOL_NAME" "$*"
	exit 1
}
