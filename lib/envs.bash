#!/usr/bin/env bash
# shellcheck disable=SC2034

set -euo pipefail

GH_REPO="https://github.com/vlang/v"
DOCS_SITE="https://vlang.io"
TOOL_NAME="v"
TOOL_TEST="v --help"
MIN_SUPPORTED_VERSION="0.3"
MIN_SUPPORTED_WEEKLY_VERSION="weekly.2022.26"
VERSIONS_TO_OMIT="mytest" # pipe-separated list. Eg: "mytest|0.2". grep is used, so partial matches.
