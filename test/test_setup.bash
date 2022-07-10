#!/usr/bin/env bash

set +u

# shellcheck source=lib/envs.bash
. "$(dirname "$BATS_TEST_DIRNAME")"/lib/envs.bash

# Unset ASDF_DIR because it may already be set by the users shell, and some
# tests fail when it is set to something other than the temp dir.
unset ASDF_DIR

setup_asdf_dir() {
	if [ -n "${ASDF_BATS_SPACE_IN_PATH:-}" ]; then
		BASE_DIR="$(mktemp -dt "asdf with spaces.XXXX")"
	else
		BASE_DIR="$(mktemp -dt asdf.XXXX)"
	fi
	HOME="$BASE_DIR/home"
	ASDF_DIR="$HOME/.asdf"
	mkdir -p "$ASDF_DIR/plugins"
	mkdir -p "$ASDF_DIR/installs"
	mkdir -p "$ASDF_DIR/shims"
	mkdir -p "$ASDF_DIR/tmp"
	ASDF_BIN="$(dirname "$BATS_TEST_DIRNAME")/bin"

	# shellcheck disable=SC2031
	PATH="$ASDF_BIN:$ASDF_DIR/shims:$PATH"
}

install_plugin() {
	local plugin_name="v"
	local location="${1:-$ASDF_DIR}"
	echo "Installing $plugin_name to $location"
	mkdir -p "$location/plugins/$plugin_name"

	# Install current code for plugin
	# (not from remote plugin repo. not from local git. just raw source code as is right now)
	echo "Installing current code for plugin:"
	echo "$BATS_TEST_DIRNAME/../lib ==> $location/plugins/$plugin_name/lib"
	cp -r "$BATS_TEST_DIRNAME/../lib" "$location/plugins/$plugin_name/lib"
	cp -r "$BATS_TEST_DIRNAME/../bin" "$location/plugins/$plugin_name/bin"
	ls -la "$HOME/.asdf/plugins/$plugin_name"
	ls -la "$HOME/.asdf/plugins/$plugin_name/bin"
	ls -la "$HOME/.asdf/plugins/$plugin_name/lib"
}

clean_asdf_dir() {
	rm -rf "$BASE_DIR"
	unset ASDF_DIR
	unset ASDF_DATA_DIR
}
