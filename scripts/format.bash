#!/usr/bin/env bash

set -euo pipefail

printf "%s\n" "Format with shfmt"
shfmt --write .
printf "%s\n" "Format with Deno"
deno fmt --ignore=CHANGELOG.md ./*.md
