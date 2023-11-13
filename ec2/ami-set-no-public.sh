#!/bin/bash

# Block Public Sharing of AMI Images Across all Regions
# Developed by Ben Fellows https://x.com/awsexp
# Reference: https://go.aws/3QO9ChX
# AWS Console: https://go.aws/3uaZ7fT

export AWS_PAGER=""

#prompt for confirmation before running or exit
read -p "This will set AMI Images to block public sharing in all regions. Are you sure? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Get a list of all AWS regions
regions=$(aws ec2 describe-regions --query "Regions[].RegionName" --output text)

# Loop through each region
for region in $regions; do
    echo "Disabling AMI Image block public access in $region..."
    
    # Disable EBS block public access
        
    aws ec2 enable-image-block-public-access \
        --region $region \
        --image-block-public-access-state block-new-sharing
done

echo "Done."
