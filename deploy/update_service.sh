#!/bin/bash
SERVICE_NAME="searchapp-service"
IMAGE_VERSION="v_"${BUILD_NUMBER}
TASK_FAMILY="searchapp"

# Create a new task definition for this build
sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" task-definitions/searchapp_jenkins_template.json > searchapp-v_${BUILD_NUMBER}.json
aws ecs register-task-definition --family searchapp --cli-input-json file://searchapp-v_${BUILD_NUMBER}.json

# Update the service with the new task definition and desired count
TASK_REVISION=`aws ecs describe-task-definition --task-definition searchapp | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/"$//'`
DESIRED_COUNT=`aws ecs describe-services --cluster searchapp --services ${SERVICE_NAME} | egrep -m 1 "desiredCount" | tr "/" " " | awk '{print $2}' | sed 's/,$//'`
if [ ${DESIRED_COUNT} = "0" ]; then
    DESIRED_COUNT="1"
fi

aws ecs update-service --cluster searchapp --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count ${DESIRED_COUNT}
