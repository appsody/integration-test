load helper
teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}

@test "test appsody stack validate" {
  cd $TEMPDIR/stacks/incubator
  for f in *; do
    if [ -d ${f} ]; then
      cd $f
      run appsody stack package
      echo "${output}" > $LOGDIR/test-appsody-list-$f.log
      echo "${output}"
      [ "$status" -eq 0 ]
      cd -
    fi
  done

}

