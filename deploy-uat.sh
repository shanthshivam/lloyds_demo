#!/bin/sh

if [ -z "$1" ]; then
  BUILD_HOME=$(pwd)
else
  BUILD_HOME=$1
fi

docker pull tomcat:8.0.28-jre8

runningContainer=`docker ps -l | grep lloydsdemo | awk '{print $1}'`

if [ ! -z "$runningContainer" ]
then
  docker stop $runningContainer
  docker rm $runningContainer
fi

docker run -d -v $BUILD_HOME/build/libs/todo.war:/usr/local/tomcat/webapps/todo.war -p 8181:8080 --name "lloydsdemo" tomcat:8.0.28-jre8
