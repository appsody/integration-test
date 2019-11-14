setup() {
  mkdir $HOME/bats_temp
}
@test "bad path test appsody repo add" {
  run appsody repo add dev.local
  #run $APPSODY repo add dev.local
  echo "${output}"
  echo "${output}" > bad-path-appsody-repo-add.log
  [ "$status" -eq 0 ]
}
teardown() {
  rm -rf $HOME/bats_temp*
}