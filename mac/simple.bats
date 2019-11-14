#!/usr/bin/env bats
@test "test appsody list" {
  run gtimeout 1 appsody list
  echo "${output}"
  [ "$status" -eq 0 ]
}
@test "test appsody repo list" {
  run appsody repo list
  echo "${output}"
  [ "$status" -eq 0 ]
}