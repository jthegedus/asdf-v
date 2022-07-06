#!/usr/bin/env bash

set -euo pipefail

current_script_path=${BASH_SOURCE[0]}
plugin_dir=$(dirname "$(dirname "$current_script_path")")

# shellcheck source=../lib/utils.bash
. "${plugin_dir}/lib/utils.bash"

# TODO: Adapt this to proper extension and adapt extracting strategy.
# TODO: check dependencies
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
		# test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		printf "%s %s installation was successful!\\n" "$TOOL_NAME" "$version"
	)
	# || (
	# 	rm -rf "$install_path"
	# 	fail "An error ocurred while installing $TOOL_NAME $version."
	# )
}
