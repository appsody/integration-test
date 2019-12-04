#!/usr/bin/env bats
@test "test appsody repo list" {
  run timeout 10 appsody repo list
  echo "${output}"
  [ "$status" -eq 0 ]
}