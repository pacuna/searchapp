#!/bin/bash
docker pull mysql:5.7
docker pull elasticsearch
docker pull redis
docker run --name mysql -e MYSQL_ROOT_PASSWORD=secretpassword -d mysql:5.7
docker run --name elasticsearch -d elasticsearch
docker run --name redis -d redis

sleep 15s
docker run --name searchapp-test -e PASSENGER_APP_ENV=test --link mysql:db --link elasticsearch:es --link redis:redis --entrypoint="./deploy/run_tests.sh" -t pacuna/searchapp:test_v_${BUILD_NUMBER} | perl -pe '/Tests failed./ && `echo -n "Tests failed" > tests-failed-flag`'
if [ ! -f tests-failed-flag ]; then
  echo -e "Tests passed."
else
  echo -e "Build failed since tests failed."
  rm tests-failed-flag
  echo 'removing test containers'
  docker rm -f searchapp-test
  docker rm -f mysql
  docker rm -f elasticsearch
  docker rm -f redis
  exit 1
fi
echo 'removing test containers'
docker rm -f searchapp-test
docker rm -f mysql
docker rm -f elasticsearch
docker rm -f redis
