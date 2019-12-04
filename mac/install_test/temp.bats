load helper
teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    rm -rf $GOPATH
  fi
}
# nodejs
@test "integration-good-path-appsody-init-nodejs" {
  # init
  mkdir -p $TEMPDIR/nodejs
  cd $TEMPDIR/nodejs
  run timeout 1h appsody init nodejs
  echo "${output}" > $LOGDIR/integration-good-path-appsody-init-nodejs.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-nodejs" {
  # run
  cd $TEMPDIR/nodejs
  run timeout 1h appsody run &
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-run.log
  #[ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-stop-nodejs" {
  # stop

  # sleep to let the container come up then capture the container id
  sleep 10
  CONTAINER=$(appsody ps | awk 'NR==2{print $2}')
  echo $CONTAINER > $LOGDIR/good-path-appsody-run-nodejs-ps-before-stop.log

  # stop the container
  run timeout 1m appsody stop --name $CONTAINER
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stop-nodejs.log
  [ "$status" -eq 0 ]

  # verify no running containers
  CONTAINER2=$(appsody ps | awk 'NR==2{print $1}')
  echo $CONTAINER2 > $LOGDIR/good-path-appsody-run-nodejs-ps-after-kill.log
  run timeout 1m appsody ps
  [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-deploy-nodejs" {
  # deploy
  cd $TEMPDIR/nodejs
  run timeout 1h appsody deploy
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-nodejs.log
  [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-nodejs" {
  # deploy delete
  cd $TEMPDIR/nodejs
  run timeout 1h appsody deploy delete
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-nodejs.log
  [ "$status" -eq 0 ]  
}
# nodejs
@test "integration-good-path-appsody-stack-validate-nodejs-express" {
  cd $TEMPDIR/stacks/incubator/nodejs-express
  run timeout 1h appsody stack validate
  echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-nodejs-express.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-nodejs-express" {
  # init
  mkdir -p $TEMPDIR/nodejs-express
  cd $TEMPDIR/nodejs-express
  run timeout 1h appsody init nodejs-express
  echo "${output}" > $LOGDIR/integration-good-path-appsody-init-nodejs-express.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-nodejs-express" {
  # run
  cd $TEMPDIR/nodejs-express
  run timeout 1h appsody run &
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-run.log
  #[ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-stop-nodejs-express" {
  # stop

  # sleep to let the container come up then capture the container id
  sleep 10
  CONTAINER=$(appsody ps | awk 'NR==2{print $2}')
  echo $CONTAINER > $LOGDIR/good-path-appsody-run-nodejs-express-ps-before-stop.log

  # stop the container
  run timeout 1m appsody stop --name $CONTAINER
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stop-nodejs-express.log
  [ "$status" -eq 0 ]

  # verify no running containers
  CONTAINER2=$(appsody ps | awk 'NR==2{print $1}')
  echo $CONTAINER2 > $LOGDIR/good-path-appsody-run-nodejs-express-ps-after-kill.log
  run timeout 1m appsody ps
  [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-deploy-nodejs-express" {
  # deploy
  cd $TEMPDIR/nodejs-express
  run timeout 1h appsody deploy
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-nodejs-express.log
  [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-nodejs-express" {
  # deploy delete
  cd $TEMPDIR/nodejs-express
  run timeout 1h appsody deploy delete
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-nodejs-express.log
  [ "$status" -eq 0 ]  
}
# nodejs-loopback
@test "integration-good-path-appsody-stack-validate-nodejs-loopback" {
  cd $TEMPDIR/stacks/incubator/nodejs-loopback
  run timeout 1h appsody stack validate
  echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-nodejs-loopback.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-nodejs-loopback" {
  # init
  mkdir -p $TEMPDIR/nodejs-loopback
  cd $TEMPDIR/nodejs-loopback
  run timeout 1h appsody init nodejs-loopback
  echo "${output}" > $LOGDIR/integration-good-path-appsody-init-nodejs-loopback.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-nodejs-loopback" {
  # run
  cd $TEMPDIR/nodejs-loopback
  run timeout 1h appsody run &
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-run.log
  #[ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-stop-nodejs-loopback" {
  # stop

  # sleep to let the container come up then capture the container id
  sleep 10
  CONTAINER=$(appsody ps | awk 'NR==2{print $2}')
  echo $CONTAINER > $LOGDIR/good-path-appsody-run-nodejs-loopback-ps-before-stop.log

  # stop the container
  run timeout 1m appsody stop --name $CONTAINER
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stop-nodejs-loopback.log
  [ "$status" -eq 0 ]

  # verify no running containers
  CONTAINER2=$(appsody ps | awk 'NR==2{print $1}')
  echo $CONTAINER2 > $LOGDIR/good-path-appsody-run-nodejs-loopback-ps-after-kill.log
  run timeout 1m appsody ps
  [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-deploy-nodejs-loopback" {
  # deploy
  cd $TEMPDIR/nodejs-loopback
  run timeout 1h appsody deploy
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-nodejs-loopback.log
  [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-nodejs-loopback" {
  # deploy delete
  cd $TEMPDIR/nodejs-loopback
  run timeout 1h appsody deploy delete
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-nodejs-loopback.log
  [ "$status" -eq 0 ]  
}
# java-microprofile
@test "integration-good-path-appsody-stack-validate-java-microprofile" {
  cd $TEMPDIR/stacks/incubator/java-microprofile
  run timeout 1h appsody stack validate
  echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-java-microprofile.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-java-microprofile" {
  # init
  mkdir -p $TEMPDIR/java-microprofile
  cd $TEMPDIR/java-microprofile
  run timeout 1h appsody init java-microprofile
  echo "${output}" > $LOGDIR/integration-good-path-appsody-init-java-microprofile.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-java-microprofile" {
  # run
  cd $TEMPDIR/java-microprofile
  run timeout 1h appsody run &
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-run.log
  #[ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-stop-java-microprofile" {
  # stop

  # sleep to let the container come up then capture the container id
  sleep 10
  CONTAINER=$(appsody ps | awk 'NR==2{print $2}')
  echo $CONTAINER > $LOGDIR/good-path-appsody-run-java-microprofile-ps-before-stop.log

  # stop the container
  run timeout 1m appsody stop --name $CONTAINER
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stop-java-microprofile.log
  [ "$status" -eq 0 ]

  # verify no running containers
  CONTAINER2=$(appsody ps | awk 'NR==2{print $1}')
  echo $CONTAINER2 > $LOGDIR/good-path-appsody-run-java-microprofile-ps-after-kill.log
  run timeout 1m appsody ps
  [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-deploy-java-microprofile" {
  # deploy
  cd $TEMPDIR/java-microprofile
  run timeout 1h appsody deploy
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-java-microprofile.log
  [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-java-microprofile" {
  # deploy delete
  cd $TEMPDIR/java-microprofile
  run timeout 1h appsody deploy delete
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-java-microprofile.log
  [ "$status" -eq 0 ]  
}
# java-spring-boot2
@test "integration-good-path-appsody-stack-validate-java-spring-boot2" {
  cd $TEMPDIR/stacks/incubator/java-spring-boot2
  run timeout 1h appsody stack validate
  echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-java-spring-boot2.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-java-spring-boot2" {
  # init
  mkdir -p $TEMPDIR/java-spring-boot2
  cd $TEMPDIR/java-spring-boot2
  run timeout 1h appsody init java-spring-boot2
  echo "${output}" > $LOGDIR/integration-good-path-appsody-init-java-spring-boot2.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-java-spring-boot2" {
  # run
  cd $TEMPDIR/java-spring-boot2
  run timeout 1h appsody run &
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-run.log
  #[ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-stop-java-spring-boot2" {
  # stop

  # sleep to let the container come up then capture the container id
  sleep 10
  CONTAINER=$(appsody ps | awk 'NR==2{print $2}')
  echo $CONTAINER > $LOGDIR/good-path-appsody-run-java-spring-boot2-ps-before-stop.log

  # stop the container
  run timeout 1m appsody stop --name $CONTAINER
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stop-java-spring-boot2.log
  [ "$status" -eq 0 ]

  # verify no running containers
  CONTAINER2=$(appsody ps | awk 'NR==2{print $1}')
  echo $CONTAINER2 > $LOGDIR/good-path-appsody-run-java-spring-boot2-ps-after-kill.log
  run timeout 1m appsody ps
  [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-deploy-java-spring-boot2" {
  # deploy
  cd $TEMPDIR/java-spring-boot2
  run timeout 1h appsody deploy
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-java-spring-boot2.log
  [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-java-spring-boot2" {
  # deploy delete
  cd $TEMPDIR/java-spring-boot2
  run timeout 1h appsody deploy delete
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-java-spring-boot2.log
  [ "$status" -eq 0 ]  
}
# nodejs
@test "integration-good-path-appsody-stack-validate-kitura" {
  cd $TEMPDIR/stacks/incubator/kitura
  run timeout 1h appsody stack validate
  echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-kitura.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-kitura" {
  # init
  mkdir -p $TEMPDIR/kitura
  cd $TEMPDIR/kitura
  run timeout 1h appsody init kitura
  echo "${output}" > $LOGDIR/integration-good-path-appsody-init-kitura.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-kitura" {
  # run
  cd $TEMPDIR/kitura
  run timeout 1h appsody run &
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-run.log
  #[ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-stop-kitura" {
  # stop

  # sleep to let the container come up then capture the container id
  sleep 10
  CONTAINER=$(appsody ps | awk 'NR==2{print $2}')
  echo $CONTAINER > $LOGDIR/good-path-appsody-run-kitura-ps-before-stop.log

  # stop the container
  run timeout 1m appsody stop --name $CONTAINER
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stop-kitura.log
  [ "$status" -eq 0 ]

  # verify no running containers
  CONTAINER2=$(appsody ps | awk 'NR==2{print $1}')
  echo $CONTAINER2 > $LOGDIR/good-path-appsody-run-kitura-ps-after-kill.log
  run timeout 1m appsody ps
  [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-deploy-kitura" {
  # deploy
  cd $TEMPDIR/kitura
  run timeout 1h appsody deploy
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-kitura.log
  [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-kitura" {
  # deploy delete
  cd $TEMPDIR/kitura
  run timeout 1h appsody deploy delete
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-kitura.log
  [ "$status" -eq 0 ]  
}
# nodejs
@test "integration-good-path-appsody-stack-validate-python-flask" {
  cd $TEMPDIR/stacks/incubator/python-flask
  run timeout 1h appsody stack validate
  echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-python-flask.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-python-flask" {
  # init
  mkdir -p $TEMPDIR/python-flask
  cd $TEMPDIR/python-flask
  run timeout 1h appsody init python-flask
  echo "${output}" > $LOGDIR/integration-good-path-appsody-init-python-flask.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-python-flask" {
  # run
  cd $TEMPDIR/python-flask
  run timeout 1h appsody run &
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-run.log
  #[ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-stop-python-flask" {
  # stop

  # sleep to let the container come up then capture the container id
  sleep 10
  CONTAINER=$(appsody ps | awk 'NR==2{print $2}')
  echo $CONTAINER > $LOGDIR/good-path-appsody-run-python-flask-ps-before-stop.log

  # stop the container
  run timeout 1m appsody stop --name $CONTAINER
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stop-python-flask.log
  [ "$status" -eq 0 ]

  # verify no running containers
  CONTAINER2=$(appsody ps | awk 'NR==2{print $1}')
  echo $CONTAINER2 > $LOGDIR/good-path-appsody-run-python-flask-ps-after-kill.log
  run timeout 1m appsody ps
  [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-deploy-python-flask" {
  # deploy
  cd $TEMPDIR/python-flask
  run timeout 1h appsody deploy
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-python-flask.log
  [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-python-flask" {
  # deploy delete
  cd $TEMPDIR/python-flask
  run timeout 1h appsody deploy delete
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-python-flask.log
  [ "$status" -eq 0 ]  
}
# swift
@test "integration-good-path-appsody-stack-validate-swift" {
  cd $TEMPDIR/stacks/incubator/swift
  run timeout 1h appsody stack validate
  echo "${output}" > $LOGDIR/integration-good-path-appsody-stack-validate-swift.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-init-swift" {
  # init
  mkdir -p $TEMPDIR/swift
  cd $TEMPDIR/swift
  run timeout 1h appsody init swift
  echo "${output}" > $LOGDIR/integration-good-path-appsody-init-swift.log
  [ "$status" -eq 0 ]
}
@test "integration-good-path-appsody-run-swift" {
  # run
  cd $TEMPDIR/swift
  run timeout 1h appsody run &
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-run.log
  #[ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-stop-swift" {
  # stop

  # sleep to let the container come up then capture the container id
  sleep 10
  CONTAINER=$(appsody ps | awk 'NR==2{print $2}')
  echo $CONTAINER > $LOGDIR/good-path-appsody-run-swift-ps-before-stop.log

  # stop the container
  run timeout 1m appsody stop --name $CONTAINER
  echo "${output}"
  echo "${output}" > $LOGDIR/good-path-appsody-stop-swift.log
  [ "$status" -eq 0 ]

  # verify no running containers
  CONTAINER2=$(appsody ps | awk 'NR==2{print $1}')
  echo $CONTAINER2 > $LOGDIR/good-path-appsody-run-swift-ps-after-kill.log
  run timeout 1m appsody ps
  [ "${lines[0]}" = "There are no stack-based containers running in your docker environment" ]

}
@test "integration-good-path-appsody-deploy-swift" {
  # deploy
  cd $TEMPDIR/swift
  run timeout 1h appsody deploy
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-swift.log
  [ "$status" -eq 0 ]  
}
@test "integration-good-path-appsody-deploy-delete-swift" {
  # deploy delete
  cd $TEMPDIR/swift
  run timeout 1h appsody deploy delete
  echo "${output}" > $LOGDIR/integration-good-path-appsody-deploy-delete-swift.log
  [ "$status" -eq 0 ]  
}
