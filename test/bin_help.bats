#!/usr/bin/env bats

load test_setup

setup() {
	setup_asdf_dir
	install_plugin
}

teardown() {
	clean_asdf_dir
}

@test "asdf help v" {
	run asdf help v

	[ "$?" -eq 0 ]
	echo "$output"
	[[ "$output" =~ "Manage your $DOCS_SITE versions per project. The minimum supported V versions are $MIN_SUPPORTED_VERSION or $MIN_SUPPORTED_WEEKLY_VERSION" ]]
	[[ "$output" =~ "Git Repository:" ]]
	[[ "$output" =~ "$GH_REPO" ]]
	[[ "$output" =~ "Documentation:" ]]
	[[ "$output" =~ "$DOCS_SITE" ]]
}
