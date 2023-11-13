#!/bin/bash

# Delete ECS Task Definitions Across all Regions
# Developed by Ben Fellows https://x.com/awsexp

#prompt for confirmation before running or exit
read -p "DANGER: This will delete all ECS Task Definitions in all regions. Are you sure? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Get a list of all regions
regions=$(aws ec2 describe-regions --query "Regions[].RegionName" --output text)

# Loop through each region
for region in $regions; do
    echo "Region: $region"

    # Get a list of all ECS task definitions in the region
    task_definitions=$(aws ecs list-task-definitions --region $region --query "taskDefinitionArns[]" --output text)

    # Loop through each task definition and delete it
    for task_definition in $task_definitions; do
        #print task definition name
        #get task definition container image from task definition
        container_image=$(aws ecs describe-task-definition --region $region --task-definition $task_definition --query "taskDefinition.containerDefinitions[].image" --output text)
        echo "Task definition: $task_definition"
        echo "Container image: $container_image"

        echo "Deleting task definition: $task_definition"
        #avoid prompting for confirmation and also avoid std out
        aws ecs deregister-task-definition --region $region --task-definition $task_definition --no-cli-auto-prompt > /dev/null
    done
done