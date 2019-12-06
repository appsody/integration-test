setup() {
  mkdir -p $HOME/bats_temp/temp
  TEMPDIR=$HOME/bats_temp/temp
  mkdir -p $HOME/bats_temp/logs
  LOGDIR=$HOME/bats_temp/logs
  cd $HOME/bats_temp/temp
  git clone https://github.com/appsody/stacks.git
  
}
@test "test appsody stack validate" {
  cd $TEMPDIR/stacks/incubator
  for f in *; do
    if [ -d ${f} ]; then
      cd $f
      run appsody stack validate
      #echo "${output}" > $LOGDIR/test-appsody-list-$f.log
      #echo "${output}"
      [ "$status" -eq 0 ]
    fi
  done

}
teardown() {
  rm -rf $HOME/bats_temp/temp*
}