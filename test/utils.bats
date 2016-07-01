#!/usr/bin/env bats

load test_helpers

setup() {
  setup_asdf_dir
}

teardown() {
  clean_asdf_dir
}

@test "check_if_version_exists should exit with 1 if plugin does not exist" {
  mkdir -p $ASDF_DIR/installs
  run check_if_version_exists "foo" "1.0.0"
  [ "$status" -eq 1 ]
  [ "$output" = "version 1.0.0 is not installed for foo" ]
}

@test "check_if_version_exists should exit with 1 if version does not exist" {
  mkdir -p $ASDF_DIR/installs/foo
  run check_if_version_exists "foo" "1.0.0"
  [ "$status" -eq 1 ]
  [ "$output" = "version 1.0.0 is not installed for foo" ]
}

@test "check_if_version_exists should be noop if version exists" {
  mkdir -p $ASDF_DIR/installs/foo/1.0.0
  run check_if_version_exists "foo" "1.0.0"
  [ "$status" -eq 0 ]
  [ "$output" = "" ]
}
