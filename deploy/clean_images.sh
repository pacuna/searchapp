#!/bin/bash
echo 'Removing previous images'
docker rmi pacuna/searchapp:v_$((${BUILD_NUMBER}-1))
docker rmi pacuna/searchapp:test_v_$((${BUILD_NUMBER}-1))
