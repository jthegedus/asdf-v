#!/usr/bin/env bash

printf "%s\n" "Running Shellcheck on all files"
shellcheck --shell=bash --external-sources \
	bin/* --source-path=template/lib/ \
	lib/* \
	scripts/*
# 	test/*

printf "%s\n" "Running shfmt on all files"
shfmt --diff .

printf "%s\n" "Running Deno fmt"
deno fmt --check --ignore=CHANGELOG.md ./*.md
