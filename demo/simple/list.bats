#!/usr/bin/env bats
@test "test appsody list" {
  run timeout 10 appsody list
  echo "${output}"
  [ "$status" -eq 0 ]
}