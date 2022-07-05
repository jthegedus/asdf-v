#!/usr/bin/env bats

load test_setup

@test "sort_versions sorts a list of versions" {
	input=$(<"$BATS_TEST_DIRNAME/fixture_sort_versions_input.txt")
	expected=$(<"$BATS_TEST_DIRNAME/fixture_sort_versions_expected.txt")
	run sort_versions "$input"

	[ "$status" -eq 0 ]
	[ "$output" = "$expected" ]
}

@test "list_github_tags from vlang/v repo" {
	run list_github_tags

	[ "$status" -eq 0 ]
	[[ "$output" =~ "0.3" ]]
	[[ "$output" =~ "weekly.2022.26" ]]
}
