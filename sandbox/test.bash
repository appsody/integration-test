#!/bin/bash
#mkdir -p $HOME/bats-test/nodejs
#cd $HOME/bats-test/nodejs
#appsody init nodejs
#appsody run &
#sleep 60
echo "check container after run"
appsody ps | awk 'NR==2{print $1}'
PID=$(ps xao pgid,command | grep '[a]ppsody run' | awk '{print $1}')
echo "pid is: $PID"
kill -2 -$PID
#kill -2 -$(ps xao pgid,command | grep '[a]ppsody run' | awk '{print $1}')
sleep 11
echo "check container after kill"
appsody ps | awk 'NR==2{print $1}'
