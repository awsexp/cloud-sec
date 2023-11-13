#!/bin/bash

# Delete ECS Clusters and Services Across all Regions
# Developed by Ben Fellows https://x.com/awsexp

export AWS_PAGER=""

#prompt for confirmation before running or exit
read -p "DANGER: This will delete all ECS clusters in all regions. Are you sure? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Get a list of all AWS regions
regions=$(aws ec2 describe-regions --query "Regions[].RegionName" --output text)

# Loop through each region
for region in $regions; do
    echo "Deleting ECS clusters in $region..."

    # Get a list of all ECS clusters in the region
    clusters=$(aws ecs list-clusters --region $region --query "clusterArns[]" --output text)

    # Loop through each ECS cluster and delete it
    for cluster in $clusters; do
        echo "Deleting ECS cluster $cluster..."
        #get a list of all services in the cluster
        services=$(aws ecs list-services --region $region --cluster $cluster --query "serviceArns[]" --output text)
        #loop through each service and delete it
        for service in $services; do
            echo "Deleting ECS service $service..."
            #set number of tasks to 0 and wait for them to be stopped but don't give any interactive 
            #prompt if there are more than 10 tasks
            aws ecs update-service --region $region --cluster $cluster --service $service --desired-count 0 --no-cli-auto-prompt
            # #wait for tasks to be stopped
            # aws ecs wait services-inactive --region $region --cluster $cluster --services $service
            #delete the service
            
            aws ecs delete-service --region $region --cluster $cluster --service $service  --no-cli-auto-prompt
        done

        aws ecs delete-cluster --region $region --cluster $cluster
    done
done
