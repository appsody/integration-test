#!/usr/bin/env bats
@test "test appsody repo list" {
  run appsody repo list
  echo "${output}"
  [ "$status" -eq 0 ]
}