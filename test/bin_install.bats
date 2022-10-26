#!/usr/bin/env bats

load test_setup

setup() {
	setup_asdf_dir
	install_plugin
}

teardown() {
	clean_asdf_dir
}

@test "asdf install v weekly.2022.43: installs weekly release" {
	run asdf install v weekly.2022.43

	[ "$?" -eq 0 ]
	echo "$output"
	[[ "$output" =~ "Downloading v@weekly.2022.43" ]]
	[[ "$output" =~ "Building v@weekly.2022.43 from source" ]]
	[[ "$output" =~ "V has been successfully built" ]]
	[[ "$output" =~ "Symlinking binary to" ]]
	[[ "$output" =~ "Testing if v@weekly.2022.43 is executable" ]]
	[[ "$output" =~ "Success! v@weekly.2022.43 is ready for use." ]]
}

@test "asdf install v 0.3.1: installs point release" {
	run asdf install v 0.3.1

	[ "$?" -eq 0 ]
	echo "$output"
	[[ "$output" =~ "Downloading v@0.3.1" ]]
	[[ "$output" =~ "Building v@0.3.1 from source" ]]
	[[ "$output" =~ "V has been successfully built" ]]
	[[ "$output" =~ "Symlinking binary to" ]]
	[[ "$output" =~ "Testing if v@0.3.1 is executable" ]]
	[[ "$output" =~ "Success! v@0.3.1 is ready for use." ]]
}

@test "asdf install v ref:779cc33: install at specific ref" {
	expected=""
	run asdf install v ref:779cc33

	[ "$?" -eq 0 ]
	echo "$output"
	[[ "$output" =~ "Downloading v@779cc33" ]]
	[[ "$output" =~ "Building v@779cc33 from source" ]]
	[[ "$output" =~ "V has been successfully built" ]]
	[[ "$output" =~ "Symlinking binary to" ]]
	[[ "$output" =~ "Testing if v@779cc33 is executable" ]]
	[[ "$output" =~ "Success! v@779cc33 is ready for use." ]]
}

@test "asdf install v 0: errors as version is not in \"asdf list all v\"" {
	expected="* ERROR: asdf-v version \"0\" not supported. \"asdf list all v\" will list available versions."
	run asdf install v 0

	[ "$?" -eq 0 ]
	echo "$output"
	[[ "$output" = "$expected" ]]
}

@test "asdf install v 0.2: warn if user attempts to install a version not supported by the plugin. Expected to error" {
	expected1="* WARNING asdf-v was developed for versions \"0.3\" or \"weekly.2022.26\" and later."
	expected2="Versions before this are not guaranteed to work."
	expected3="* ERROR: asdf-v Could not compile v@0.2"
	run asdf install v 0.2

	[ "$?" -eq 0 ]
	echo "$output"
	[[ "$output" =~ "$expected1" ]]
	[[ "$output" =~ "$expected2" ]]
	[[ "$output" =~ "$expected3" ]]
}

@test "asdf install v weekly.2022.24: warn if user attempts to install a version not supported by the plugin. Expected to error" {
	expected1="* WARNING asdf-v was developed for versions \"0.3\" or \"weekly.2022.26\" and later."
	expected2="Versions before this are not guaranteed to work."
	expected3="* ERROR: asdf-v Could not compile v@weekly.2022.24"
	run asdf install v weekly.2022.24

	[ "$?" -eq 0 ]
	echo "$output"
	[[ "$output" =~ "$expected1" ]]
	[[ "$output" =~ "$expected2" ]]
	[[ "$output" =~ "$expected3" ]]
}
