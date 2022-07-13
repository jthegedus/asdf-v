#!/usr/bin/env bats

load test_setup

setup() {
	setup_asdf_dir
	install_plugin
}

teardown() {
	clean_asdf_dir
}

@test "asdf latest v: prints correct version from remote" {
	expected=$(curl -sI "$GH_REPO/releases/latest" |
		sed -n -e "s|^location: $GH_REPO/releases/tag/||p" |
		sed -n -e "s|\r||p")

	run asdf latest v

	[ "$?" -eq 0 ]
	[[ "$output" = "$expected" ]]
}
