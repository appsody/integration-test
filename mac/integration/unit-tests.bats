load helper
teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}
# nodejs
@test "unit-tests-appsody" {
  cd $TEMPDIR/appsody
  run timeout 2h make test
  echo "${output}" > $LOGDIR/unit-tests-appsody.log
  [ "$status" -eq 0 ]
}