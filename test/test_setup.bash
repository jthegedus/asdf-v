#!/usr/bin/env bash

# shellcheck source=lib/utils.bash
. "$(dirname "$BATS_TEST_DIRNAME")"/lib/utils.bash

# shellcheck source=lib/download.bash
. "$(dirname "$BATS_TEST_DIRNAME")"/lib/download.bash
# shellcheck source=lib/install.bash
. "$(dirname "$BATS_TEST_DIRNAME")"/lib/install.bash
# shellcheck source=lib/latest-stable.bash
. "$(dirname "$BATS_TEST_DIRNAME")"/lib/latest-stable.bash
# shellcheck source=lib/list-all.bash
. "$(dirname "$BATS_TEST_DIRNAME")"/lib/list-all.bash

set +u
