load helper
setup() {
  mkdir -p $HOME/bats_temp/logs
  mkdir -p $HOME/bats_temp/temp
  cd $HOME/bats_temp/temp
  git clone https://github.com/appsody/stacks.git
  git clone https://github.com/appsody/appsody.git
  cd appsody
  make build
  APPSODY=$HOME/bats_temp/temp/appsody/build/appsody-0.0.0-darwin-amd64
  #LOGDIR=$HOME/bats_temp/logs
  TEMPDIR=$HOME/bats_temp/temp
}
@test "good path test appsody stack validate nodejs" {
  cd $TEMPDIR/stacks/incubator/nodejs
  run $APPSODY stack validate
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stack-validate-nodejs.log
  [ "$status" -eq 0 ]
}
@test "good path test appsody deploy nodejs" {
  # init
  mkdir -p $TEMPDIR/nodejs
  cd $TEMPDIR/nodejs
  run $APPSODY init dev.local/nodejs
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-init-nodejs.log
  [ "$status" -eq 0 ]

  # deploy
  run $APPSODY deploy
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-nodejs.log
  [ "$status" -eq 0 ]  

  # deploy delete
  run $APPSODY deploy delete
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-delete-nodejs.log
  [ "$status" -eq 0 ]  
}
@test "good path test appsody stack validate nodejs-express" {
  cd $TEMPDIR/stacks/incubator/nodejs-express
  run $APPSODY stack validate
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stack-validate-nodejs-express.log
  [ "$status" -eq 0 ]
}
@test "good path test appsody deploy nodejs-express" {
  # init
  mkdir -p $TEMPDIR/nodejs-express
  cd $TEMPDIR/nodejs-express
  run $APPSODY init dev.local/nodejs-express
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-init-nodejs-express.log
  [ "$status" -eq 0 ]

  # deploy
  run $APPSODY deploy
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-nodejs-express.log
  [ "$status" -eq 0 ]  

  # deploy delete
  run $APPSODY deploy delete
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-delete-nodejs-express.log
  [ "$status" -eq 0 ]  
}

@test "good path test appsody stack validate nodejs-loopback" {
  cd $TEMPDIR/stacks/incubator/nodejs-loopback
  run $APPSODY stack validate
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stack-validate-nodejs-loopback.log
  [ "$status" -eq 0 ]
}
@test "good path test appsody deploy nodejs-loopback" {
  # init
  mkdir -p $TEMPDIR/nodejs-loopback
  cd $TEMPDIR/nodejs-loopback
  run $APPSODY init dev.local/nodejs-loopback
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-init-nodejs-loopback.log
  [ "$status" -eq 0 ]

  # deploy
  run $APPSODY deploy
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-nodejs-loopback.log
  [ "$status" -eq 0 ]  

  # deploy delete
  run $APPSODY deploy delete
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-delete-nodejs-loopback.log
  [ "$status" -eq 0 ]  
}

@test "good path test appsody stack validate java-microprofile" {
  skip
  cd $TEMPDIR/stacks/incubator/java-microprofile
  run $APPSODY stack validate
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stack-validate-java-microprofile.log
  [ "$status" -eq 0 ]
}
@test "good path test appsody deploy java-microprofile" {
  skip
  # init
  mkdir -p $TEMPDIR/java-microprofile
  cd $TEMPDIR/java-microprofile
  run $APPSODY init dev.local/java-microprofile
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-init-java-microprofile.log
  [ "$status" -eq 0 ]

  # deploy
  run $APPSODY deploy
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-java-microprofile.log
  [ "$status" -eq 0 ]  

  # deploy delete
  run $APPSODY deploy delete
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-delete-java-microprofile.log
  [ "$status" -eq 0 ]  
}

@test "good path test appsody stack validate java-spring-boot2" {
  cd $TEMPDIR/stacks/incubator/java-spring-boot2
  run $APPSODY stack validate
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stack-validate-java-spring-boot2.log
  [ "$status" -eq 0 ]
}
@test "good path test appsody deploy java-spring-boot2" {
  # init
  mkdir -p $TEMPDIR/java-spring-boot2
  cd $TEMPDIR/java-spring-boot2
  run $APPSODY init dev.local/java-spring-boot2
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-init-java-spring-boot2.log
  [ "$status" -eq 0 ]

  # deploy
  run $APPSODY deploy
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-java-spring-boot2.log
  [ "$status" -eq 0 ]  

  # deploy delete
  run $APPSODY deploy delete
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-delete-java-spring-boot2.log
  [ "$status" -eq 0 ]  
}

@test "good path test appsody stack validate kitura" {
  cd $TEMPDIR/stacks/incubator/kitura
  run $APPSODY stack validate
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stack-validate-kitura.log
  [ "$status" -eq 0 ]
}
@test "good path test appsody deploy kitura" {
  # init
  mkdir -p $TEMPDIR/kitura
  cd $TEMPDIR/kitura
  run $APPSODY init dev.local/kitura
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-init-kitura.log
  [ "$status" -eq 0 ]

  # deploy
  run $APPSODY deploy
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-kitura.log
  [ "$status" -eq 0 ]  

  # deploy delete
  run $APPSODY deploy delete
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-delete-kitura.log
  [ "$status" -eq 0 ]  
}

@test "good path test appsody stack validate python-flask" {
  cd $TEMPDIR/stacks/incubator/python-flask
  run $APPSODY stack validate
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stack-validate-python-flask.log
  [ "$status" -eq 0 ]
}
@test "good path test appsody deploy python-flask" {
  # init
  mkdir -p $TEMPDIR/python-flask
  cd $TEMPDIR/python-flask
  run $APPSODY init dev.local/python-flask
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-init-python-flask.log
  [ "$status" -eq 0 ]

  # deploy
  run $APPSODY deploy
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-python-flask.log
  [ "$status" -eq 0 ]  

  # deploy delete
  run $APPSODY deploy delete
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-delete-python-flask.log
  [ "$status" -eq 0 ]  
}

@test "good path test appsody stack validate swift" {
  cd $TEMPDIR/stacks/incubator/swift
  run $APPSODY stack validate
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stack-validate-swift.log
  [ "$status" -eq 0 ]
}
@test "good path test appsody deploy swift" {
  # init
  mkdir -p $TEMPDIR/swift
  cd $TEMPDIR/swift
  run $APPSODY init dev.local/swift
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-init-swift.log
  [ "$status" -eq 0 ]

  # deploy
  run $APPSODY deploy
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-swift.log
  [ "$status" -eq 0 ]  

  # deploy delete
  run $APPSODY deploy delete
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-deploy-delete-swift.log
  [ "$status" -eq 0 ]  
}

teardown() {
  rm -rf $HOME/bats_temp/temp*
}