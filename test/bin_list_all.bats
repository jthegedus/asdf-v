#!/usr/bin/env bats

load test_setup

setup() {
	setup_asdf_dir
	install_plugin
}

teardown() {
	clean_asdf_dir
}

@test "asdf list all v: prints versions from remotes" {
	run asdf list all v

	[ "$?" -eq 0 ]
	# check min supported versions are present
	[[ "$output" =~ "0.3" ]]
	[[ "$output" =~ "weekly.2022.26" ]]
	# ommitted versions not present
	[[ ! "$output" =~ "mytest" ]]
	# ensure no versions prefixed with "v" as it should be stripped from GitHub URLs
	[[ ! "$output" =~ "v0.*" ]]
}
