#!/usr/bin/env bats

load test_setup

setup() {
	setup_asdf_dir
	install_plugin
}

teardown() {
	clean_asdf_dir
}

@test "asdf help ${TOOL_NAME}" {
	run asdf help "${TOOL_NAME}"

	[ "$?" -eq 0 ]
	echo "$output"
	[[ "$output" =~ "Manage your $TOOL_NAME versions per project. The minimum supported $TOOL_NAME versions are $MIN_SUPPORTED_VERSION or $MIN_SUPPORTED_WEEKLY_VERSION" ]]
	[[ "$output" =~ "Git Repository:" ]]
	[[ "$output" =~ "$GH_REPO" ]]
	[[ "$output" =~ "Documentation:" ]]
	[[ "$output" =~ "$DOCS_SITE" ]]
}
