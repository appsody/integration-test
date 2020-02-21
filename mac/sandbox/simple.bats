#!/usr/bin/env bats
@test "test app stop" {
  run timeout 5 appsody list
  echo "${output}"
  [ "$status" -eq 0 ]
}
@test "test app run" {
  run appsody repo list
  echo "${output}"
  [ "$status" -eq 0 ]
}
@test "test app deploy" {
  run appsody repo list tnixa
  echo "${output}"
  [ "$status" -eq 0 ]
}
@test "test app stack validate" {
  run appsody repo list
  echo "${output}"
  [ "$status" -eq 0 ]
}